# -*- coding: utf-8 -*-
"""
@project = order
@file = Order
@auther = yuewei
@create_time = 2019-08-26 15:47
"""
import math

from  flask import request,jsonify,g
from sqlalchemy import or_

from application import db, app
from common.libs.Helper import getInvoiceDetail
from common.models.invoice.Invoice import Invoice
from common.models.invoice.InvoiceEvaluate import InvoiceEvaluate
from common.models.invoice.InvoiceEvaluateImg import InvoiceEvaluateImg
from web.controllers.api import route_api


@route_api.route("/invoice", methods=["GET", "POST"])
def get_invoice():
    data = []
    req = request.values
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    page = int(req['p']) if ('p' in req and req['p']) else 1
    if g.member_info.group_name:
        query = Invoice.query.filter(Invoice.del_flag == '0',or_(Invoice.mid == g.member_info.id,Invoice.group_name == g.member_info.group_name))
    else:
        query = Invoice.query.filter(Invoice.del_flag == '0', Invoice.mid == g.member_info.id)
    if 'keyword' in req:
        if req['keyword']:
            rule = Invoice.notes.ilike("%{0}%".format(req['keyword']))
            query = query.filter(rule)
            resp['keyword'] = req['keyword']

    offset = (page - 1) * app.config['PAGE_SIZE']
    invoices = query.filter_by().order_by(Invoice.invoice_id.desc()).offset(offset).limit(app.config['PAGE_SIZE']).all()
    for invoice in invoices:
        item = getInvoiceDetail(invoice)
        data.append(item)
    resp['data'] = data
    # 总页数
    resp['all_page'] = math.ceil(query.filter_by().count() / int(app.config['PAGE_SIZE']))
    return jsonify( resp )
@route_api.route("/getInvoiceById", methods=["GET", "POST"])
def get_invoice_by_id():
    data = []
    req = request.values
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    invoice_id = req['invoice_id'] if 'invoice_id' in req else ''
    if invoice_id == '':
        resp['msg'] = '参数不正确'
        return jsonify(resp)
    invoices = Invoice.query.filter(Invoice.invoice_id == invoice_id, Invoice.del_flag == 0).first()
    if not invoices:
        resp['msg'] = 'id参数错误'
        return jsonify(resp)
    resp['data'] = getInvoiceDetail(invoices)
    return jsonify( resp )
@route_api.route("/receiveInvoice", methods=["POST"])
def receive_invoice():
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    req = request.values
    invoice_id = req['invoice_id'] if 'invoice_id' in req else 0
    evaluate_star_level1 = req['evaluate_star_level1'] if 'evaluate_star_level1' in req else 0
    evaluate_star_level2 = req['evaluate_star_level2'] if 'evaluate_star_level2' in req else 0
    evaluate_content = req['evaluate_content'] if 'evaluate_content' in req else 0
    file_path = req['file_path'] if 'file_path' in req else 0
    if invoice_id == 0:
        resp['code'] = -1
        resp['msg'] = "ID不正确不能执行~~"
        return jsonify(resp)
    data = []
    print(invoice_id)
    invoices = Invoice.query.filter(Invoice.del_flag == 0,Invoice.invoice_id == invoice_id).first()
    print(invoices)
    if not invoices :
        resp['code'] = -1
        resp['msg'] = "操作错误~~"
        return jsonify(resp)
    if invoices.status == 2:
        resp['code'] = -1
        resp['msg'] = "当前货物已经被确认接受~~"
        return jsonify(resp)
    if invoices:
        invoices.status = 2
        invoices.mid = g.member_info.id
        invoices.group_name = g.member_info.group_name

        db.session.add(invoices)
        db.session.commit()
        # 更新Evaluate图片
        evaluate = InvoiceEvaluate();
        evaluate.invoice_id=invoice_id;
        evaluate.evaluate_star_level1 = evaluate_star_level1;
        evaluate.evaluate_star_level2 = evaluate_star_level2;
        evaluate.evaluate_content = evaluate_content;
        db.session.add(evaluate)
        db.session.commit()
        db.session.flush();
        #更新Evaluate图片
        if file_path:
            for each in file_path.split(','):
                evaluate_img = InvoiceEvaluateImg()
                evaluate_img.invoice_id = invoice_id
                evaluate_img.evaluate_id = evaluate.evaluate_id
                evaluate_img.file_key = each;
                db.session.add(evaluate_img)
                db.session.commit()
    return jsonify( resp )