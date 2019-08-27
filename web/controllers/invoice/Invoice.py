# -*- coding: utf-8 -*-
"""
@project = order
@file = Order
@auther = yuewei
@create_time = 2019-08-26 15:47
"""
from flask import request, jsonify, g, Blueprint

from application import app
from common.libs.Helper import getInvoiceDetail, ops_render, iPagination
from common.models.invoice.Invoice import Invoice
from web.controllers.api import route_api


route_invoices = Blueprint( 'invoices_page',__name__ )

@route_invoices.route("/invoice", methods=["GET", "POST"])
def get_order():
    INVOICE_PAGE_SIZE=8
    data = []
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    req = request.values
    page = int(req['p']) if ('p' in req and req['p']) else 1

    query = Invoice.query.filter(Invoice.del_flag == '0')
    if 'mix_kw' in req:
        rule = Invoice.address.ilike("%{0}%".format(req['mix_kw']))
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