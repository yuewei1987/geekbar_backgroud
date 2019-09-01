# coding: utf-8
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text, Integer, DateTime, String
from application import db


class InvoiceEvaluateImg(db.Model):
    __tablename__ = 'invoice_evaluate_img'

    invoice_evaluate_img_id = db.Column(Integer, primary_key=True)
    invoice_id = db.Column(Integer, nullable=False)
    evaluate_id = db.Column(Integer, nullable=False)
    file_key = db.Column(String(60))
    create_time = db.Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    update_time = db.Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    del_flag = db.Column(Integer, nullable=False, server_default=text("'0'"))
