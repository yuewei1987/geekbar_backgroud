# coding: utf-8
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text, Integer, DateTime, String
from application import db


class InvoiceEvaluate(db.Model):
    __tablename__ = 'invoice_evaluate'

    evaluate_id = db.Column(Integer, primary_key=True)
    invoice_id = db.Column(Integer, nullable=False)
    evaluate_star_level1 = db.Column(Integer, nullable=False, server_default=text("'0'"))
    evaluate_star_level2 = db.Column(Integer, nullable=False, server_default=text("'0'"))
    evaluate_content = db.Column(String(500))
    create_time = db.Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    update_time = db.Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    del_flag = db.Column(Integer, nullable=False, server_default=text("'0'"))
