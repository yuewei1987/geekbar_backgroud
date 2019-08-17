# -*- coding: utf-8 -*-
from flask import g,render_template
import datetime
from application import app, db
import os, stat, uuid

'''
自定义分页类
'''
def iPagination( params ):
    import math

    ret = {
        "is_prev":1,
        "is_next":1,
        "from" :0 ,
        "end":0,
        "current":0,
        "total_pages":0,
        "page_size" : 0,
        "total" : 0,
        "url":params['url'].replace("&p=","")
    }

    total = int( params['total'] )
    page_size = int( params['page_size'] )
    page = int( params['page'] )
    display = int( params['display'] )
    total_pages = int( math.ceil( total / page_size ) )
    total_pages = total_pages if total_pages > 0 else 1
    if page <= 1:
        ret['is_prev'] = 0

    if page >= total_pages:
        ret['is_next'] = 0

    semi = int( math.ceil( display / 2 ) )

    if page - semi > 0 :
        ret['from'] = page - semi
    else:
        ret['from'] = 1

    if page + semi <= total_pages :
        ret['end'] = page + semi
    else:
        ret['end'] = total_pages

    ret['current'] = page
    ret['total_pages'] = total_pages
    ret['page_size'] = page_size
    ret['total'] = total
    ret['range'] = range( ret['from'],ret['end'] + 1 )
    return ret

'''
统一渲染方法
'''
def ops_render( template,context = {} ):
    if 'current_user' in g:
        context['current_user'] = g.current_user
    return render_template( template,**context )

'''
获取当前时间
'''
def getCurrentDate( format = "%Y-%m-%d %H:%M:%S"):
    #return datetime.datetime.now().strftime( format )
    return datetime.datetime.now()

'''
获取格式化的时间
'''
def getFormatDate( date = None ,format = "%Y-%m-%d %H:%M:%S" ):
    if date is None:
        date = datetime.datetime.now()

    return date.strftime( format )


'''
根据某个字段获取一个dic出来
'''
def getDictFilterField( db_model,select_filed,key_field,id_list ):
    ret = {}
    query = db_model.query
    if id_list and len( id_list ) > 0:
        query = query.filter( select_filed.in_( id_list ) )

    list = query.all()
    if not list:
        return ret
    for item in list:
        if not hasattr( item,key_field ):
            break

        ret[ getattr( item,key_field ) ] = item
    return ret



def selectFilterObj( obj,field ):
    ret = []
    for item in obj:
        if not hasattr(item, field ):
            break
        if getattr( item,field )  in ret:
            continue
        ret.append( getattr( item,field ) )
    return ret


def getDictListFilterField( db_model,select_filed,key_field,id_list ):
    ret = {}
    query = db_model.query
    if id_list and len( id_list ) > 0:
        query = query.filter( select_filed.in_( id_list ) )

    list = query.all()
    if not list:
        return ret
    for item in list:
        if not hasattr( item,key_field ):
            break
        if getattr( item,key_field ) not in ret:
            ret[getattr(item, key_field)] = []

        ret[ getattr( item,key_field ) ].append(item )
    return ret

from common.libs.UrlManager import UrlManager

'''
拼接数据库模型的一条信息
'''
def getGoodsDetail(goods_info):
    if not goods_info:
        return {}
    data = {
        "id": goods_info.id,
        "icon": UrlManager.buildImageUrl(goods_info.icon),
        "name": goods_info.name,
        "detail": "",
        # "detail": "{}% {} full bottles".format(
        #     "%.0f" % ((float(goods_info.surplus_num) / float(goods_info.all_num)) * 100.0), goods_info.all_num),
        "surplus_num": goods_info.surplus_num,
        "pirce": goods_info.price,
        "unit":"￥"
    }

    return data

import pandas as pd
import pandas.io.formats.excel
pandas.io.formats.excel.header_style = None
import time
import uuid

# 生成表格
def getXlsx(datas):
    now_time = str(time.strftime('%Y%m%d%H%M%S', time.localtime(time.time())))
    xlsx_list = [[],["DATE",now_time],["Product Name", "Quantity", "Total Value"]]
    total_inventory_value = 0.0
    for k,v in datas.items():
        total_inventory_value += v.get("total_value")
        xlsx_list.append([k,str(v.get("quantity")),"￥"+str(v.get("total_value"))])

    xlsx_list.append(["Total Inventory Value", "", "￥%s"%total_inventory_value])

    df = pd.DataFrame(xlsx_list)


    # 存放表格文件夹的 全局路径
    root_path = app.root_path + app.config['XLSX']['prefix_path']
    # 不使用getCurrentDate创建目录，为了保证其他写的可以用，这里改掉，服务器上好像对时间不兼容
    file_dir = datetime.datetime.now().strftime("%Y%m%d")
    # 最终存放上传 图片的路径
    save_dir = root_path + file_dir
    # 判断文件路径是否存在，不存在就创建
    if not os.path.exists(save_dir):
        os.mkdir(save_dir)
        # S_IRWXU 700权限, S_IRGRP 040权限, S_IRWXO 007权限
        os.chmod(save_dir, stat.S_IRWXU | stat.S_IRGRP | stat.S_IRWXO)

    file_name = str(uuid.uuid4()).replace("-", "") + ".xlsx"

    # Create a Pandas Excel writer using XlsxWriter as the engine.
    writer = pd.ExcelWriter(save_dir+'/'+file_name, engine='xlsxwriter')

    # Convert the dataframe to an XlsxWriter Excel object.
    df.to_excel(writer, sheet_name='Sheet1', header=False, index=False)
    workbook  = writer.book
    worksheet = writer.sheets['Sheet1']
    head_workfomat = workbook.add_format({
        'bold':  True,                 #字体加粗
        'align':    'center',          #对齐方式
        'valign':   'vcenter',         #字体对齐方式
        'font_size': 15,  # 单元格背景颜色
    })
    workfomat1 = workbook.add_format({
        'font_size': 14,  # 单元格背景颜色
        'bold': True,  # 字体加粗
    })
    workfomat2 = workbook.add_format({
        'font_size': 13,  # 单元格背景颜色

    })

    worksheet.merge_range('A1:C1','Stock Inventory',head_workfomat)        #合并单元格
    worksheet.set_column('A:A', 26,workfomat1)
    worksheet.set_column('B:C', 19,workfomat2)
    worksheet.set_row(1, cell_format=workfomat1)
    worksheet.set_row(2, cell_format=workfomat1)

    # worksheet.set_column('A2:A5', 20,workfomat)
    writer.save()

    return file_dir+'/'+file_name
