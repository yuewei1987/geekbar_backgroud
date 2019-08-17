# -*- coding: utf-8 -*-
"""
@project = order
@file = __init__.py
@auther = FengQi
@create_time = 2019-07-18 18:28
"""
from flask import Blueprint
route_api = Blueprint( 'api_page',__name__ )
from web.controllers.api.Member import *

# geek_bar 的接口  2019.07.21
from web.controllers.api.Home import *
from web.controllers.api.List import *
from web.controllers.api.Goods import *

@route_api.route("/")
def index():
    return "Mina Api V1.0~~"
