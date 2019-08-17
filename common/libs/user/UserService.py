# -*- coding: utf-8 -*-
import hashlib, base64, random, string


class UserService():

    @staticmethod
    def geneAuthCode(user_info=None):
        """
        产生授权码-加密cookie
        :param user_info:
        :return:
        """
        m = hashlib.md5()
        str = "%s-%s-%s-%s" % (user_info.uid, user_info.login_name, user_info.login_pwd, user_info.login_salt)
        m.update(str.encode("utf-8"))
        return m.hexdigest()

    @staticmethod
    def genePwd(pwd, salt):
        """
        产生 加密密码
        :param pwd: 正确密码
        :param salt: 加密随机数
        :return:
        """
        m = hashlib.md5()
        str = "%s-%s" % (base64.encodebytes(pwd.encode("utf-8")), salt)
        m.update(str.encode("utf-8"))
        return m.hexdigest()

    @staticmethod
    def geneSalt(length=16):
        keylist = [random.choice((string.ascii_letters + string.digits)) for i in range(length)]
        return ("".join(keylist))

