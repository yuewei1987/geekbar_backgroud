# -*- coding: utf-8 -*-
APP = {
    # 域名
    'domain': 'https://www.umame.cn'

}

# 数据库
# SQLALCHEMY 是否打印日志
SQLALCHEMY_ECHO = False
SQLALCHEMY_DATABASE_URI = 'mysql://root:1qazxsW@@47.108.78.123:3306/geekbar?charset=utf8mb4'
SQLALCHEMY_TRACK_MODIFICATIONS = False
SQLALCHEMY_ENCODING = "utf8mb4"

# 公用设置
SERVER_PORT = 8999
# DEBUG = False

MINA_APP = {
    'appid': 'wxb25420c61a92cb94',
    'appkey': '2f85688921528bdd9c5a3d8bb64f7571',
}

# 有可能你使用浏览器看到的一串字符串不是那么容易看懂的，这是因为python底层使用unicode编码。
# 通过设置下面的参数可以解决这个问题。
JSON_AS_ASCII = False

AUTH_COOKIE_NAME = "xian_wo_wang"

SEO_TITLE = "鲜我网"

##过滤url 就是验证用户登录的时候 登录页面就不用验证了--不需要验证的
IGNORE_URLS = [
    "^/user/login",
    "^/upload/ueditor"
]

IGNORE_CHECK_LOGIN_URLS = [
    "^/static",
    "^/favicon.ico"

]

##不需要验证的
API_IGNORE_URLS = [
    "^/api/member/login",
    "^/api/invoice"
]
STATUS_MAPPING = {
    "0":"无效",
    "1":"有效"
}
# 分页
PAGE_SIZE = 10
PAGE_DISPLAY = 10

# 上传相关参数
UPLOAD = {
    'ext': ['jpg', 'gif', 'bmp', 'jpeg', 'png', 'JPG', 'JPEG','pdf','PDF'],  # 扩展
    'prefix_path': '/web/static/upload/',  # 上传目录
    'prefix_url': '/static/upload/'  # url地址
}
XLSX = {
    'prefix_path': "/web/static/xlsx/",  # 上传目录
    'prefix_url': '/static/xlsx/'  # url地址
}
