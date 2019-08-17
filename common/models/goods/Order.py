# coding: utf-8
from sqlalchemy import Column, DateTime, Integer, String
from flask_sqlalchemy import SQLAlchemy
from application import db


class Order(db.Model):
    __tablename__ = 'order'

    id = db.Column(db.Integer, primary_key=True)
    mid = db.Column(db.Integer, nullable=False)
    goods_id = db.Column(db.Integer)
    int_num = db.Column(db.String(20))
    per_num = db.Column(db.String(20))
    price = db.Column(db.String(20))
    all_price = db.Column(db.String(20))
    add_time = db.Column(db.DateTime)
    upd_time = db.Column(db.DateTime)
    order_id = db.Column(db.String(50))
    name = db.Column(db.String(20))
