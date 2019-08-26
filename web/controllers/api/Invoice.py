# -*- coding: utf-8 -*-
"""
@project = order
@file = Order
@auther = yuewei
@create_time = 2019-08-26 15:47
"""
from  flask import request,jsonify,g

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