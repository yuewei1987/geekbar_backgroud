# coding: utf-8
from sqlalchemy import Column, DateTime, Integer, String
from sqlalchemy.schema import FetchedValue
from flask_sqlalchemy import SQLAlchemy
from application import db


class Banner(db.Model):
    __tablename__ = 'banner'

    id = db.Column(db.Integer, primary_key=True)
    type = db.Column(db.String(11))
    url = db.Column(db.String(200))
    location_url = db.Column(db.String(200))
    add_time = db.Column(db.DateTime)
    upd_time = db.Column(db.DateTime)
    is_delete = db.Column(db.Integer, server_default=db.FetchedValue())
