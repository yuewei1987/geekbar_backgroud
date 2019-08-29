# -*- coding: utf-8 -*-
import datetime
import os
import stat

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
        config_upload = app.config['QRCODE']
        image = qrcode.make(str)  # 快速生成一个二维码
        root_path = app.root_path + config_upload['prefix_path']
        # 最终存放上传 图片的路径
        save_dir = root_path
        # 判断文件路径是否存在，不存在就创建
        if not os.path.exists(save_dir+datetime.datetime.now().strftime("%Y%m%d")):
            os.mkdir(save_dir+datetime.datetime.now().strftime("%Y%m%d"))
            # S_IRWXU 700权限, S_IRGRP 040权限, S_IRWXO 007权限
            os.chmod(save_dir+datetime.datetime.now().strftime("%Y%m%d"), stat.S_IRWXU | stat.S_IRGRP | stat.S_IRWXO)
        image.save(save_dir+filename)  # 保存二维码到当前目录
        #image.get_image()  # image.show()
        resp['data'] = {
            'save_dir': save_dir
        }
        return resp
