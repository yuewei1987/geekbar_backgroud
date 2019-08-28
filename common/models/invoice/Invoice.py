# coding: utf-8
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from sqlalchemy.dialects.mysql import TINYINT

from application import db


class Invoice(db.Model):
    __tablename__ = 'invoice'

    invoice_id = db.Column(db.Integer, primary_key=True, comment='主键id')
    address = db.Column(db.String(100), comment='地址')
    phone = db.Column(db.String(20), comment='电话')
    amount = db.Column(db.DECIMAL(12, 2), nullable=False, comment='金额')
    notes = db.Column(db.String(200), comment='备注信息')
    group_name = db.Column(db.String(255), comment='组名称')
    file_path = db.Column(db.String(255), comment='文件路径')
    status = db.Column(TINYINT(4), default="0", comment='订单状态( 0已创建Sent，1待发送Pending，2-已经扫码,完成Receivd)')
    create_time = db.Column(db.TIMESTAMP, nullable=False, server_default=text("CURRENT_TIMESTAMP"), comment='创建时间')
    update_time = db.Column(db.TIMESTAMP, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"), comment='更新时间')
    del_flag = db.Column(TINYINT(4), nullable=False, server_default=text("'0'"), comment='1:删除 0:未删除')
    order_id = db.Column(db.INTEGER, comment='订单号')
    mid = db.Column(db.INTEGER, comment='用户id member')
    goods_id = db.Column(db.INTEGER, comment='货物id')
