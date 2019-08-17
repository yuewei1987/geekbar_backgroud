# -*- coding: utf-8 -*-
"""
@project = order
@file = static
@auther = FengQi
@create_time = 2019-07-18 01:21
"""
# send_from_directory 来解决加载资源的问题 2019.07.18 01:31
from flask import Blueprint,send_from_directory
from application import app

route_static = Blueprint("static",__name__)
@route_static.route("/<path:filename>")
def index(filename):
    # app.root 项目的根目录
     return send_from_directory(app.root_path + "/web/static/",filename)
