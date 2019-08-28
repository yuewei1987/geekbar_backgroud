# -*- coding: utf-8 -*-
import datetime

import qrcode
from flask import request,g
from application import app,db
import json
from common.libs.Helper import getCurrentDate
from common.models.log.AppAccessLog import AppAccessLog
from common.models.log.AppErrorLog import AppErrorLog

class QrcodeService():
    @staticmethod
    def generateqrcode(str,filename):
        resp = {'code': 200, 'msg': '二维码生成成功', 'data': {}}
        config_upload = app.config['UPLOAD']
        image = qrcode.make(str)  # 快速生成一个二维码
        root_path = app.root_path + config_upload['prefix_path']
        file_dir = datetime.datetime.now().strftime("%Y%m%d")
        # 最终存放上传 图片的路径
        save_dir = root_path + file_dir
        # 判断文件路径是否存在，不存在就创建
        image.save(save_dir+"/"+filename)  # 保存二维码到当前目录
        #image.get_image()  # image.show()
        resp['data'] = {
            'save_dir': save_dir
        }
        return resp
