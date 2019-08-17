# coding: utf-8
from sqlalchemy import BigInteger, Column, DateTime, Integer, String
from sqlalchemy.schema import FetchedValue
from application import db


class Banner(db.Model):
    __tablename__ = 'banner'

    id = db.Column(db.Integer, primary_key=True)
    type = db.Column(db.String(11))
    url = db.Column(db.String(500))
    location_url = db.Column(db.String(500))
    add_time = db.Column(db.DateTime)
    upd_time = db.Column(db.DateTime)
    is_delete = db.Column(db.String(11), server_default=db.FetchedValue())
