# -*- coding: utf-8 -*-
from flask import Blueprint,request,redirect,jsonify
from common.libs.Helper import ops_render,iPagination,getCurrentDate
from common.libs.UrlManager import UrlManager
from common.libs.user.UserService import UserService
from common.models.log.AppAccessLog import AppAccessLog
from common.models.User import User
from sqlalchemy import or_
from application import app, db
from common.models.member.Member import Member

route_member = Blueprint('member_page', __name__)


@route_member.route("/index")
def index():
    resp_data = {}
    req = request.values
    page = int(req['p']) if ('p' in req and req['p']) else 1
    query = Member.query

    if 'mix_kw' in req:
        rule = or_(Member.nickname.ilike("%{0}%".format(req['mix_kw'])), Member.mobile.ilike("%{0}%".format(req['mix_kw'])))
        query = query.filter(rule)

    if 'status' in req and int(req['status']) > -1:
        query = query.filter(Member.status == int(req['status']))

    page_params = {
        'total': query.count(),
        'page_size': app.config['PAGE_SIZE'],
        'page': page,
        'display': app.config['PAGE_DISPLAY'],
        'url': request.full_path.replace("&p={}".format(page), "")
    }

    pages = iPagination(page_params)
    offset = (page - 1) * app.config['PAGE_SIZE']
    limit = app.config['PAGE_SIZE'] * page

    list = query.order_by(Member.id.desc()).all()[offset:limit]

    resp_data['list'] = list
    resp_data['pages'] = pages
    resp_data['search_con'] = req
    resp_data['status_mapping'] = app.config['STATUS_MAPPING']
    print(resp_data, '**********')
    return ops_render( "member/index.html",resp_data )


@route_member.route("/set", methods=["GET", "POST"])
def set():
    default_pwd = "******"
    if request.method == "GET":
        resp_data = {}
        req = request.args
        id = int(req.get("id", 0))
        info = None
        if id:
            info = Member.query.filter_by(id=id).first()
        resp_data['info'] = info
        return ops_render("member/set.html", resp_data)

    resp = {'code': 200, 'msg': '操作成功~~', 'data': {}}
    req = request.values

    id = req['id'] if 'id' in req else 0
    nickname = req['nickname'] if 'nickname' in req else ''
    group_name = req['group_name'] if 'group_name' in req else ''

    if group_name is None or len(group_name) < 1:
        resp['code'] = -1
        resp['msg'] = "请输入符合规范的组名~~"
        return jsonify(resp)


    # has_in = Member.query.filter(Member.group_name == login_name, User.uid != id).first()
    # if has_in:
    #     resp['code'] = -1
    #     resp['msg'] = "该登录名已存在，请换一个试试~~"
    #     return jsonify(resp)

    member_info = Member.query.filter_by(id=id).first()
    if member_info:
        model_member = member_info;
    else:
        resp['code'] = -1
        resp['msg'] = "当前账号信息不存在,请确认后修改~~"
        return jsonify(resp)
    model_member.group_name = group_name;
    model_member.nickname = nickname;
    model_member.updated_time = getCurrentDate()
    db.session.add(model_member)
    ret = db.session.commit()
    return jsonify(resp)


