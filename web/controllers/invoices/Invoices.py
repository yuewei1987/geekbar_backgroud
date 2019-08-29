# -*- coding: utf-8 -*-
"""
@project = order
@file = Order
@auther = yuewei
@create_time = 2019-08-26 15:47
"""
import datetime
from decimal import Decimal

from flask import request, jsonify, Blueprint
from sqlalchemy import func

from application import  db
from common.libs.Helper import getInvoiceDetail, ops_render, iPagination, get_current_month_start_and_end
from common.libs.QrcodeService import QrcodeService
from common.libs.UrlManager import UrlManager
from common.models.invoice.Invoice import Invoice

route_invoices = Blueprint( 'invoices_page',__name__ )

@route_invoices.route("/index", methods=["GET", "POST"])
def get_order():
    INVOICE_PAGE_SIZE=5
    data = []
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    req = request.values
    page = int(req['p']) if ('p' in req and req['p']) else 1

    query = Invoice.query.filter(Invoice.del_flag == '0')
    if 'mix_kw' in req:
        rule = Invoice.notes.ilike("%{0}%".format(req['mix_kw']))
        query = query.filter(rule)
        resp['mix_kw'] = req['mix_kw']

    page_params = {
        'total': query.count(),
        'page_size': INVOICE_PAGE_SIZE,
        'page': page,
        'display': INVOICE_PAGE_SIZE,
        'url': request.full_path.replace("&p={}".format(page), "")
    }

    pages = iPagination(page_params)
    offset = (page - 1) * INVOICE_PAGE_SIZE
    list = query.filter_by().order_by(Invoice.invoice_id.desc()).offset(offset).limit(INVOICE_PAGE_SIZE).all()
    for invoice in list:
        item = getInvoiceDetail(invoice)
        data.append(item)
    resp['list'] = data
    resp['pages'] = pages
    resp['search_con'] = req
    print(resp)
    return ops_render("invoices/index.html", resp)

@route_invoices.route( "/set" ,methods = [ 'GET','POST'] )
def set():
    # if request.method == "GET":
    #     resp_data = {}
    #     req = request.args
    #     id = int( req.get('id',0) )
    #     info = Invoice.query.filter( Invoice.id == id ,Invoice.del_flag == '0').first()
    #     if info and info.del_flag == 1:
    #         return redirect( UrlManager.buildUrl("/invoices/index") )
    #
    #     resp_data['info'] = info
    #     resp_data['current'] = 'index'
    #     return ops_render( "invoices/set.html" ,resp_data)

    resp = {'code': 200, 'msg': '操作成功~~', 'data': {}}
    req = request.values

    id = int(req['id']) if 'id' in req and req['id'] else 0
    file_path = req['file_path'] if 'file_path' in req else ''
    amount = req['amount'] if 'amount' in req else ''
    notes = req['notes'] if 'notes' in req else ''

    if file_path is None or len(file_path) < 1:
        resp['code'] = -1
        resp['msg'] = "请输入符合规范的名称"
        return jsonify(resp)

    if not amount or len( amount ) < 1:
        resp['code'] = -1
        resp['msg'] = "请输入符合规范的价格"
        return jsonify(resp)

    price = Decimal(amount).quantize(Decimal('0.00'))
    if  price <= 0:
        resp['code'] = -1
        resp['msg'] = "请输入符合规范的价格"
        return jsonify(resp)


    invoices_info = Invoice.query.filter_by(invoice_id=id).first()
    if invoices_info:
        model_invoices = invoices_info
    else:
        model_invoices = Invoice()

    model_invoices.file_path = file_path
    model_invoices.amount = amount
    model_invoices.notes = notes
    db.session.add(model_invoices)
    ret = db.session.commit()
    db.session.flush();
    # UrlManager.buildImageUrl(file_key) PDF的地址
    # qrcode 与实际上传文件同名只是在不同目录 /web/upload/qrcode
    print(UrlManager.buildScanUrl("/api/receiveInvoice?invoice_id="+str(model_invoices.invoice_id)));
    qret = QrcodeService.generateqrcode(UrlManager.buildScanUrl("/api/receiveInvoice?invoice_id="+str(model_invoices.invoice_id)), file_path)
    if qret['code'] != 200:
        resp['code'] = -1
        resp['msg'] = "二维码生成失败，请重试~~"
        return jsonify(resp)
    return jsonify(resp)


@route_invoices.route("/ops",methods=["POST"])
def ops():
    resp = { 'code':200,'msg':'操作成功~~','data':{} }
    req = request.values

    id = req['id'] if 'id' in req else 0
    act = req['act'] if 'act' in req else ''

    if not id :
        resp['code'] = -1
        resp['msg'] = "请选择要操作的发货单"
        return jsonify(resp)

    if act not in [ 'deliver','remove' , 'recover']:
        resp['code'] = -1
        resp['msg'] = "操作有误，请重试~~"
        return jsonify(resp)

    invoices_info = Invoice.query.filter_by( invoice_id = id ).first()
    if not invoices_info:
        resp['code'] = -1
        resp['msg'] = "发货单不存在"
        return jsonify(resp)

    if act == "remove":
        invoices_info.del_flag = 1
    elif act == "recover":
        invoices_info.del_flag = 0
    elif act == "deliver":
        invoices_info.status = 1

    db.session.add(invoices_info)
    db.session.commit()
    return jsonify( resp )


@route_invoices.route("/chart",methods=["GET"])
def revenue():
    resp = { 'code':200,'msg':'操作成功~~','data':{} }
    data = []
    createtimedata = []
    deliverdata = []
    req = request.values
    # id = req['id'] if 'id' in req else 0
    # act = req['act'] if 'act' in req else ''
    today = datetime.datetime.now().strftime("%Y-%m-%d")
    revenues = Invoice.query.with_entities(func.sum(Invoice.amount)) \
        .filter(Invoice.del_flag == 0,Invoice.create_time <= today).all()
    if not revenues:
        resp['code'] = -1
        resp['msg'] = "操作有误，请重试~~"
        return jsonify(resp)
    item = {
            "totalamount": float(revenues[0][0]),
            "today": datetime.datetime.now().strftime("%d/%m/%Y"),
        }
    resp['revenues'] = item
    deliveriescount = Invoice.query.filter(Invoice.del_flag == 0,Invoice.create_time <= today).count()
    deliveritem = {
        "deliveriescount": deliveriescount,
        "today": datetime.datetime.now().strftime("%d/%m/%Y"),
    }
    resp['deliveries'] = deliveritem
    datefor = get_current_month_start_and_end(today);
    invoices = Invoice.query.with_entities(func.count(Invoice.invoice_id), func.sum(Invoice.amount) ,func.date(Invoice.create_time))\
        .filter(Invoice.del_flag == 0,Invoice.create_time >= datefor[0],Invoice.create_time <= datefor[1])\
        .group_by(func.date(Invoice.create_time)).all()
    for invoice in invoices:
        createtimedata.append(invoice[2].strftime("%Y-%m-%d"))
        data.append(float(invoice[1]))
        deliverdata.append(float(invoice[0]))
    resp['data'] = data
    resp['createtimedata'] = createtimedata
    resp['deliveriedata'] = deliverdata
    return jsonify( resp )

