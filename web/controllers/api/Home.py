# -*- coding: utf-8 -*-
"""
@project = order
@file = Home
@auther = FengQi
@create_time = 2019-07-21 11:55
"""
from web.controllers.api import route_api
from  flask import request,jsonify,g
from common.models.Banner import Banner
from common.models.goods.Order import Order
from datetime import datetime
from common.libs.UrlManager import UrlManager
from sqlalchemy.sql import func
@route_api.route("/home", methods=["GET", "POST"])
def get_home():

    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    banner_imgs = []
    banners = Banner.query.filter(Banner.is_delete == 0).all()
    for banner in banners:
        banner_imgs.append({
            "id":banner.id,
            "type":banner.type,
            "url":UrlManager.buildImageUrl(banner.url),
            "location_url":banner.location_url,
        })
    resp['data']['banner_imgs'] = banner_imgs
    # orders = Order.query.with_entities(Order.all_price).filter((Order.mid == g.member_info.id) and (Order.add_time > datetime.now())).all()
    # orders = Order.query.with_entities(Order.all_price).filter(Order.mid == g.member_info.id).filter(Order.add_time > datetime.now().strftime("%Y-%m-%d 00:00:00")).all()
    all_price = 0.0
    orders = Order.query.with_entities(func.max(Order.id)).filter(Order.mid == g.member_info.id).group_by(Order.goods_id).all()
    for max_id in orders:
        order = Order.query.filter(Order.id == max_id).first()
        if order:
            all_price+=float(order.all_price)
    resp['data']['all_price'] = {"show_name": "Current Stock Price", "price": "￥ %.2f"%all_price}

    return jsonify( resp )