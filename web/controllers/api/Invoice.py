# -*- coding: utf-8 -*-
"""
@project = order
@file = Order
@auther = yuewei
@create_time = 2019-08-26 15:47
"""
from  flask import request,jsonify,g

from application import db
from common.libs.Helper import getInvoiceDetail
from common.models.invoice.Invoice import Invoice
from web.controllers.api import route_api


@route_api.route("/invoice", methods=["GET", "POST"])
def get_order():
    data = []
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    invoices = Invoice.query.filter(Invoice.del_flag == 0).all()
    for invoice in invoices:
        item = getInvoiceDetail(invoice)
        data.append(item)
    resp['data'] = [data]
    return jsonify( resp )

@route_api.route("/receiveInvoice", methods=["GET", "POST"])
def receive_invoice():
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    req = request.values
    invoice_id = req['invoice_id'] if 'invoice_id' in req else 0
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
        resp['msg'] = "请不要重复操作~~"
        return jsonify(resp)
    if invoices:
        invoices.status = 2
        invoices.mid = g.member_info.id
        invoices.group_name = g.member_info.group_name
        db.session.add(invoices)
        db.session.commit()
    return jsonify( resp )