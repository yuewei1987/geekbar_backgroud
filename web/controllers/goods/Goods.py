# -*- coding: utf-8 -*-
from flask import request, jsonify, redirect
from common.libs.Helper import ops_render, getCurrentDate, iPagination
from application import app, db
from common.models.goods.Goods import Goods
from common.libs.UrlManager import UrlManager
from decimal import Decimal
from flask import Blueprint

route_goods = Blueprint( 'goods_page',__name__ )

@route_goods.route( "/index" )
def index():
    resp_data = {}
    req = request.values

    page = int(req['p']) if ('p' in req and req['p']) else 1
    query = Goods.query.filter(Goods.is_delete == '0')


    if 'mix_kw' in req:
        rule = Goods.name.ilike("%{0}%".format(req['mix_kw']))
        query = query.filter(rule)
        resp_data['mix_kw'] = req['mix_kw']

    page_params = {
        'total': query.count(),
        'page_size': app.config['PAGE_SIZE'],
        'page': page,
        'display': app.config['PAGE_DISPLAY'],
        'url': request.full_path.replace("&p={}".format(page), "")
    }

    pages = iPagination(page_params)
    offset = (page - 1) * app.config['PAGE_SIZE']
    list = query.filter_by().order_by(Goods.id.desc()).offset(offset).limit(app.config['PAGE_SIZE']).all()

    resp_data['list'] = list
    resp_data['pages'] = pages
    resp_data['search_con'] = req

    return ops_render("goods/index.html", resp_data)



@route_goods.route( "/set" ,methods = [ 'GET','POST'] )
def set():
    if request.method == "GET":
        resp_data = {}
        req = request.args
        id = int( req.get('id',0) )
        info = Goods.query.filter( Goods.id == id ,Goods.is_delete == '0').first()

        if info and info.is_delete == 1:
            return redirect( UrlManager.buildUrl("/goods/index") )

        resp_data['info'] = info
        resp_data['current'] = 'index'
        return ops_render( "goods/set.html" ,resp_data)

    resp = {'code': 200, 'msg': '操作成功~~', 'data': {}}
    req = request.values

    id = int(req['id']) if 'id' in req and req['id'] else 0
    bar_code = req['bar_code'] if 'bar_code' in req else ''
    name = req['name'] if 'name' in req else ''
    price = req['price'] if 'price' in req else ''
    main_image = req['main_image'] if 'main_image' in req else ''

    if name is None or len(name) < 1:
        resp['code'] = -1
        resp['msg'] = "请输入符合规范的名称~~"
        return jsonify(resp)

    if not price or len( price ) < 1:
        resp['code'] = -1
        resp['msg'] = "请输入符合规范的售卖价格~~"
        return jsonify(resp)

    price = Decimal(price).quantize(Decimal('0.00'))
    if  price <= 0:
        resp['code'] = -1
        resp['msg'] = "请输入符合规范的售卖价格~~"
        return jsonify(resp)

    if main_image is None or len(main_image) < 3:
        resp['code'] = -1
        resp['msg'] = "请上传封面图~~"
        return jsonify(resp)

    goods_info = Goods.query.filter_by(id=id).first()
    if goods_info:
        model_goods = goods_info
    else:
        model_goods = Goods()
        model_goods.add_time = getCurrentDate()

    model_goods.bar_code = bar_code
    model_goods.name = name
    model_goods.price = price
    model_goods.icon = main_image

    model_goods.upd_time = getCurrentDate()

    db.session.add(model_goods)
    ret = db.session.commit()

    return jsonify(resp)



@route_goods.route("/ops",methods=["POST"])
def ops():
    resp = { 'code':200,'msg':'操作成功~~','data':{} }
    req = request.values

    id = req['id'] if 'id' in req else 0
    act = req['act'] if 'act' in req else ''

    if not id :
        resp['code'] = -1
        resp['msg'] = "请选择要操作的货物~~"
        return jsonify(resp)

    if act not in [ 'remove','recover' ]:
        resp['code'] = -1
        resp['msg'] = "操作有误，请重试~~"
        return jsonify(resp)

    goods_info = Goods.query.filter_by( id = id ).first()
    if not goods_info:
        resp['code'] = -1
        resp['msg'] = "货物不存在~~"
        return jsonify(resp)

    if act == "remove":
        goods_info.is_delete = 1
    elif act == "recover":
        goods_info.is_delete = 0

    goods_info.updated_time = getCurrentDate()
    db.session.add(goods_info)
    db.session.commit()
    return jsonify( resp )


