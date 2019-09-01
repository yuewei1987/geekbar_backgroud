# -*- coding: utf-8 -*-
"""
@project = order
@file = Upload
@auther = Yuewei
@create_time = 2019-09-01 13:40
"""
from flask import Blueprint,request,jsonify

from common.libs.UploadService import UploadService
from web.controllers.api import route_api

@route_api.route("/upload", methods=["GET", "POST"])
def upload():
	resp = {'code': 200, 'msg': '图片上传成功~', 'data': {}}
	file_target = request.files
	upfile = file_target['uploadfile_ant'] if 'uploadfile_ant' in file_target else None
	if upfile is None:
		resp['code'] = -1
		resp['msg'] = "无上传文件";
		return jsonify(resp)
	ret = UploadService.uploadByFile(upfile)
	if ret['code'] != 200:
		resp['code'] = -1
		resp['msg'] = "上传内部异常";
	resp['data']= ret['data']['file_key']
	return jsonify(resp)


