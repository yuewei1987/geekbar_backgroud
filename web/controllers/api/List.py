# -*- coding: utf-8 -*-
"""
@project = order
@file = List
@auther = FengQi
@create_time = 2019-07-21 15:10
"""
from web.controllers.api import route_api
from  flask import request,jsonify,g
from common.models.goods.Goods import Goods
from common.models.goods.Order import Order
from common.libs.Helper import getGoodsDetail
from application import app, db
from common.libs.Helper import ops_render, getCurrentDate, iPagination, getDictFilterField
from datetime import datetime
from sqlalchemy.sql import func

@route_api.route("/list", methods=["GET"])
def get_list():
    resp_data = {'code': 200, 'msg': '操作成功~', 'data':{}}
    req = request.values

    page = int(req['p']) if ('p' in req and req['p']) else 1
    query = Goods.query.filter(Goods.is_delete == '0')


    if 'mix_kw' in req:
        rule = Goods.name.ilike("%{0}%".format(req['mix_kw']))
        query = query.filter(rule)
        resp_data['mix_kw'] = req['mix_kw']

    offset = (page - 1) * app.config['PAGE_SIZE']
    goods_infos = query.filter_by().order_by(Goods.id.desc()).ofsurplus_numfset(offset).limit(app.config['PAGE_SIZE']).all()
    data = []

    for goods_info in goods_infos:
        item = getGoodsDetail(goods_info)
        max_id = Order.query.filter(Order.mid == g.member_info.id).filter(Order.goods_id == goods_info.id).with_entities(func.max(Order.id)).first()

        order = Order.query.filter(Order.id == max_id).first()
        if order:

            item["quantity"] = (float(order.int_num)*10  + float(order.per_num)*10 )/10
        else:
            item["quantity"] = 0
        data.append(item)
    resp_data['data'] = data
    import math
    # 总页数
    resp_data['all_page'] = math.ceil(query.filter_by().count()/int(app.config['PAGE_SIZE']))
    return jsonify( resp_data )
