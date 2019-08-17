# -*- coding: utf-8 -*-
from werkzeug.utils import secure_filename
from application import app, db
from common.libs.Helper import getCurrentDate
import datetime
import os, stat, uuid
from common.models.Image import Image


class UploadService():
    @staticmethod
    def uploadByFile(file):
        config_upload = app.config['UPLOAD']
        resp = {'code': 200, 'msg': '操作成功~~', 'data': {}}
        # 获取文件名 【secure_filename() 获取一个安全的文件名】
        filename = secure_filename(file.filename)
        # 获取文件的后缀
        ext = filename.rsplit(".", 1)[1]
        # 判断 这个 后缀 是否在 规定的后缀里面
        if ext not in config_upload['ext']:
            resp['code'] = -1
            resp['msg'] = "不允许的扩展类型文件"
            return resp

        # 存放图片文件夹的 全局路径
        root_path = app.root_path + config_upload['prefix_path']
        # 'prefix_path': '/web/static/upload/',  # 上传目录

        # 不使用getCurrentDate创建目录，为了保证其他写的可以用，这里改掉，服务器上好像对时间不兼容
        file_dir = datetime.datetime.now().strftime("%Y%m%d")
        # 最终存放上传 图片的路径
        save_dir = root_path + file_dir
        # 判断文件路径是否存在，不存在就创建
        if not os.path.exists(save_dir):
            os.mkdir(save_dir)
            # S_IRWXU 700权限, S_IRGRP 040权限, S_IRWXO 007权限
            os.chmod(save_dir, stat.S_IRWXU | stat.S_IRGRP | stat.S_IRWXO)
        # 生成文件名 uuid 来做，再加上后缀
        file_name = str(uuid.uuid4()).replace("-", "") + "." + ext
        # 存储文件 [路径+文件名]就可以了
        file.save("{0}/{1}".format(save_dir, file_name))

        model_image = Image()
        model_image.file_key = file_dir + "/" + file_name
        model_image.created_time = getCurrentDate()
        db.session.add(model_image)
        db.session.commit()

        resp['data'] = {
            'file_key': model_image.file_key
        }
        return resp
