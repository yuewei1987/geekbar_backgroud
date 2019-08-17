# coding: utf-8
from sqlalchemy import Column, DateTime, Integer, String
from flask_sqlalchemy import SQLAlchemy
from application import db


class Goods(db.Model):
    __tablename__ = 'goods'

    id = db.Column(db.Integer, primary_key=True)
    icon = db.Column(db.String(200))
    name = db.Column(db.String(50))
    desc = db.Column(db.String(200),default="")
    add_time = db.Column(db.DateTime)
    upd_time = db.Column(db.DateTime)
    all_num = db.Column(db.String(11),default="0")
    surplus_num = db.Column(db.String(11),default="0")
    star = db.Column(db.String(11),default="0")
    price = db.Column(db.String(11))
    bar_code = db.Column(db.String(20))
    is_delete = db.Column(db.Integer,default=0)
