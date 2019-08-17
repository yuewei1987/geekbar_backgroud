# -*- coding: utf-8 -*-
"""
@project = order
@file = Goods
@auther = FengQi
@create_time = 2019-07-21 15:14
"""
from web.controllers.api import route_api
from flask import request, jsonify, g
from common.models.goods.Goods import Goods
from common.models.goods.Order import Order
from common.libs.Helper import getCurrentDate,getGoodsDetail,getXlsx
from application import app, db
from datetime import datetime
from common.libs.UrlManager import UrlManager
from sqlalchemy.sql import func

@route_api.route("/add", methods=["POST"])
def add_goods():
    resp = { 'code':200 ,'msg':'操作成功~','data':{} }
    req = request.values
    name = req['name'] if 'name' in req else ''
    icon = req['icon'] if 'icon' in req else ''
    desc = req['desc'] if 'desc' in req else ''
    all_num = req['all_num'] if 'all_num' in req else ''
    star = req['star'] if 'star' in req else ''
    price = req['price'] if 'price' in req else ''
    if name == '' or icon == '' or all_num == '' or price == '':
        resp['msg'] = '参数不正确'
        return jsonify(resp)

    model_goods = Goods()
    model_goods.name = name
    model_goods.icon = icon
    model_goods.desc = desc
    model_goods.all_num = all_num
    model_goods.surplus_num = all_num
    model_goods.star = star
    model_goods.price = price
    model_goods.upd_time = model_goods.add_time = getCurrentDate()
    db.session.add(model_goods)
    db.session.commit()
    return jsonify( resp )

@route_api.route("/save", methods=["POST"])
def save_goods():
    resp = { 'code':200 ,'msg':'操作成功~','data':{} }
    req = request.values
    goods_id = req['id'] if 'id' in req else ''
    if goods_id == '':
        resp['msg'] = '参数不正确'
        return jsonify(resp)

    model_goods = Goods.query.filter(Goods.id == goods_id, Goods.is_delete == 0).first()
    if not model_goods:
        resp['msg'] = 'id参数错误'
        return jsonify(resp)

    name = req['name'] if 'name' in req else model_goods.name
    icon = req['icon'] if 'icon' in req else model_goods.icon
    desc = req['desc'] if 'desc' in req else model_goods.desc
    surplus_num = req['surplus_num'] if 'surplus_num' in req else model_goods.surplus_num
    all_num = req['all_num'] if 'all_num' in req else model_goods.all_num
    star = req['star'] if 'star' in req else model_goods.star
    price = req['price'] if 'price' in req else model_goods.price

    # 更新
    model_goods.name = name
    model_goods.icon = icon
    model_goods.desc = desc
    model_goods.all_num = all_num
    model_goods.surplus_num = surplus_num
    model_goods.star = star
    model_goods.price = price
    model_goods.upd_time = getCurrentDate()
    db.session.add(model_goods)
    db.session.commit()
    return jsonify( resp )

@route_api.route("/goods", methods=["POST"])
def get_goods():
    resp = { 'code':200 ,'msg':'操作成功~','data':{} }
    req = request.values
    opt = req['opt'] if 'opt' in req else '1'
    goods_id = req['id'] if 'id' in req else ''
    if opt not in ['-1','0','1',] or goods_id == '':
        resp['msg'] = '参数不正确'
        return jsonify(resp)
    if opt == '0':
        if goods_id == '0':
            goods_info = Goods.query.filter_by(is_delete=0).first()
        else:
            goods_info = Goods.query.filter(Goods.id == goods_id,Goods.is_delete==0).first()
            if goods_info is None:
                resp['code'] = 5009
                resp['msg'] = '没有找到对应的货物'
                return jsonify(resp)
            data = getGoodsDetail(goods_info)
            data['percent_num'] = '0'
            data['int_num'] = '0'

            resp['data'] = [data]
            return jsonify(resp)
    else:
        goods_info = Goods.query.filter(Goods.id == goods_id, Goods.is_delete == 0).first()
        if not goods_info:
            resp['msg'] = '找不到对应的货物'
            return jsonify(resp)
        if opt == '1':
            # 下一个
            goods_info = Goods.query.filter(Goods.id > goods_id, Goods.is_delete == 0).order_by(Goods.id.asc()).first()  # asc 升序
            if goods_info is None:
                resp['code'] = 5001
                resp['msg'] = '已经是最后一个'
                return jsonify(resp)
        else:  # opt = -1
            # 上一个
            goods_info = Goods.query.filter(Goods.id < goods_id, Goods.is_delete == 0).order_by(Goods.id.desc()).first()  # desc 降序
            if goods_info is None:
                resp['code'] = 5001
                resp['msg'] = '已经是第一个'
                return jsonify(resp)

    data = getGoodsDetail(goods_info)

    data['percent_num'] = '0'
    data['int_num'] = '0'
    resp['data'] = [data]
    return jsonify( resp )


@route_api.route("/opt", methods=["GET","POST"])
def operate_goods():
    resp = { 'code':200 ,'msg':'操作成功~','data':{} }
    if request.method != "POST":
        resp['msg'] = '请用POST请求'
        return jsonify(resp)

    req = request.values
    # 1表示加，0表示减-- 不传默认为 加
    op = req['opt'] if 'opt' in req else '1'
    goods_id = req['id'] if 'id' in req else ''
    if goods_id == '' or op not in ['0','1']:
        resp['msg'] = '参数不正确'
        return jsonify(resp)

    goods_info = Goods.query.filter(Goods.id==goods_id, Goods.is_delete == 0).first()
    goods_surplus_num = int(goods_info.surplus_num)
    goods_all_num = int(goods_info.all_num)

    if op == '1':
        # 加1
        goods_surplus_num +=1
        goods_all_num +=1
    else:
        # 减1
        goods_surplus_num -=1

    goods_info.all_num = goods_all_num
    goods_info.surplus_num = goods_surplus_num
    goods_info.upd_time = getCurrentDate()

    db.session.add(goods_info)
    db.session.commit()

    data = getGoodsDetail(goods_info)
    data['percent_num'] = '0'
    data['int_num'] = '0'
    resp['data'] = [data]
    return jsonify( resp )


@route_api.route("/search", methods=["GET","POST"])
def search_goods():
    resp = { 'code':200 ,'msg':'操作成功~','data':{} }
    if request.method != "POST":
        resp['msg'] = '请用POST请求'
        return jsonify(resp)
    req = request.values
    # 1表示加，0表示减-- 不传默认为 加
    keyword = req['keyword'] if 'keyword' in req else ''
    if keyword == '':
        resp['msg'] = '参数不正确'
        return jsonify(resp)
    data = []
    goods_infos = Goods.query.filter(Goods.name.like("%"+keyword+"%") , Goods.is_delete == 0).all()
    for goods_info in goods_infos:
        item = getGoodsDetail(goods_info)

        max_id = Order.query.filter(Order.mid == g.member_info.id).filter(Order.goods_id == goods_info.id).with_entities(func.max(Order.id)).first()

        order = Order.query.filter(Order.id == max_id).first()
        if order:
            item["quantity"] = (float(order.int_num)*10  + float(order.per_num)*10 )/10
        else:
            item["quantity"] = 0
        data.append(item)


    resp['data'] = data

    return jsonify( resp )

@route_api.route("/scan", methods=["GET","POST"])
def scan_goods():
    resp = { 'code':200 ,'msg':'操作成功~','data':{} }
    if request.method != "POST":
        resp['msg'] = '请用POST请求'
        return jsonify(resp)
    req = request.values
    # 1表示加，0表示减-- 不传默认为 加
    bar_code = req['bar_code'] if 'bar_code' in req else ''
    if bar_code == '':
        resp['msg'] = '参数不正确'
        return jsonify(resp)

    goods_info = Goods.query.filter(Goods.bar_code == bar_code, Goods.is_delete == 0).first()
    if not goods_info:
        resp['code'] = 5004
        resp['msg'] = '没有找到该条形码对应的货物'
        return jsonify(resp)

    resp['data'] = goods_info.id
    return jsonify(resp)

@route_api.route("/order", methods=["GET","POST"])
def order_goods():
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    if request.method != "POST":
        resp['msg'] = '请用POST请求'
        return jsonify(resp)
    req = request.values
    id_ = req['id'] if 'id' in req else ''
    name = req['name'] if 'name' in req else ''
    int_num = req['int_num'] if 'int_num' in req else ''
    per_num = req['per_num'] if 'per_num' in req else ''
    price = req['price'] if 'price' in req else ''
    all_price = req['all_price'] if 'all_price' in req else ''
    if id_ == '' or int_num == '' or per_num == '' or (per_num == '0' and int_num == '0' ) or price == '' or all_price == '' or name == '':
        resp['code'] = 5005
        resp['msg'] = '参数不正确'
        return jsonify(resp)

    goods_info = Goods.query.filter(Goods.id == id_, Goods.is_delete == 0).first()
    if not goods_info:
        resp['code'] = 5004
        resp['msg'] = '没有找到对应的货物'
        return jsonify(resp)
    import time
    order_id = str(time.strftime('%Y%m%d%H%M%S', time.localtime(time.time())))+ str(time.time()).replace('.', '')[-7:]
    resp['data'] = {"order_id":order_id}
    order = Order()
    order.goods_id = id_
    order.name = name
    order.mid = g.member_info.id
    order.int_num = int_num
    order.per_num = str(int(per_num)/100)
    order.price = price
    order.all_price = all_price
    order.order_id = order_id
    order.upd_time = order.add_time = getCurrentDate()
    db.session.add(order)
    db.session.commit()
    return jsonify( resp )

@route_api.route("/xlsx", methods=["GET","POST"])
def xlsx_goods():
    resp = {'code': 200, 'msg': '操作成功~', 'data': {}}
    if request.method != "GET":
        resp['msg'] = '请用GET请求'
        return jsonify(resp)
    #comment by yuewei
    #orders = Order.query.filter(Order.mid == g.member_info.id).filter(Order.add_time > datetime.now().strftime("%Y-%m-%d 00:00:00")).all()
    #data = {}
    #for order in orders:
    #    if order.name not in data:
    #        data[order.name] = {'quantity': float(order.int_num) + float(order.per_num),
    #                            'total_value': float(order.all_price)}
    #    else:
    #        data[order.name] = {
    #            'quantity': data[order.name].get("quantity") + float(order.int_num) + float(order.per_num),
    #            'total_value': data[order.name].get("total_value") + float(order.all_price)}
    orders = Order.query.with_entities(func.max(Order.id)).filter(Order.mid == g.member_info.id).group_by(Order.goods_id).all()
    data = {}
    for max_id in orders:
        order = Order.query.filter(Order.id == max_id).first()
        if order.name not in data:
            data[order.name] = {'quantity': float(order.int_num) + float(order.per_num),
            'total_value': float(order.all_price)}
        else:
            data[order.name] = {'quantity': data[order.name].get("quantity") + float(order.int_num) + float(order.per_num),
            'total_value': data[order.name].get("total_value") + float(order.all_price)}
    path = getXlsx(data)
    from common.libs.UrlManager import UrlManager

    resp['data'] = {"path": UrlManager.buildXlsxUrl(path)}

    return jsonify(resp)

@route_api.route("/goodslist", methods=["POST"])
def get_goodslist():
  resp = { 'code':200 ,'msg':'操作成功~','data':{} }
  req = request.values
  data = []
  goods_infos = Goods.query.filter(Goods.is_delete == 0).all()
  if goods_infos is None:
        resp['code'] = 5009
        resp['msg'] = '没有找到对应的货物'
        return jsonify(resp)
  for goods_info in goods_infos:
      item = getGoodsDetail(goods_info)
      item["percent_num"] = 0
      item["int_num"] = 0
      max_id = Order.query.filter(Order.mid == g.member_info.id).filter(Order.goods_id == goods_info.id).with_entities(func.max(Order.id)).first()
      order = Order.query.filter(Order.id == max_id).first()
      if order:
         item["quantity"] = (float(order.int_num)*10  + float(order.per_num)*10 )/10
      else:
         item["quantity"] = 0
      data.append(item)
  resp['data'] = data
  return jsonify( resp )