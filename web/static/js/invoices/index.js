var upload = {
    error: function (msg) {
        common_ops.alert(msg);
    },
    success: function (file_key) {
        if (!file_key) {
            return;
        }
        var html = '<img width="100"  height="100" src="' + common_ops.buildPicUrl(file_key) + '" onclick="tf.click();"/>' +
            '<input name="filepath" style="display: none" value="'+file_key+'"/>';
        $("#upd_img").html(html);

    }
};
var invoice_index_ops = {
    init:function(){
        this.eventBind();
    },
    eventBind:function(){
        var that = this;
        $(".upload_pic_wrap input[name=pdf]").change(function () {
             $(".upload_pic_wrap").submit();
        });

        $(".right-invoice button").click(function (e) {
            if(!e.isPropagationStopped()){//确定stopPropagation是否被调用过
                 var btn_target = $(this);
                if (btn_target.hasClass("disabled")) {
                    common_ops.alert("正在处理!!请不要重复提交~~");
                    return;
                }
                var file_path_target = $(".right-invoice input[name=filepath]");
                var file_path = file_path_target.val();

                var amount_target = $(".right-invoice input[name=amount]");
                var amount = amount_target.val();

                var notes_target = $(".right-invoice textarea[name=notes]");
                var notes = notes_target.val();
                if (typeof(file_path) == "undefined" || file_path.length < 1) {
                    common_ops.alert("请上传您的文件信息");
                    return;
                }

                if (typeof(amount) == "undefined" || amount.length < 1) {
                    common_ops.alert("请输入输入价格金额");
                    return;
                }

                if (parseFloat(amount) <= 0) {
                    common_ops.tip("请输入符合规范的价格金额", amount_target);
                    return;
                }

                btn_target.addClass("disabled");

                var data = {
                    file_path: file_path,
                    amount: amount,
                    notes: notes
                };
                $.ajax({
                    url: common_ops.buildUrl("/invoices/set"),
                    type: 'POST',
                    data: data,
                    dataType: 'json',
                    success: function (res) {
                        btn_target.removeClass("disabled");
                        var callback = null;
                        if (res.code == 200) {
                            callback = function () {
                                window.location.href = common_ops.buildUrl("/invoices/index");
                            }
                        }
                        common_ops.alert(res.msg, callback);
                    }
                });
            }
            e.stopPropagation();
        });
        $(".left-body .btn-success").click( function(e){
          if(!e.isPropagationStopped()){//确定stopPropagation是否被调用过
            that.ops( "deliver",$(this).attr("data") )
          }
           e.stopPropagation();
        });
        $(".remove").click( function(){
            that.ops( "remove",$(this).attr("data") )
        });

        $(".recover").click( function(){
            that.ops( "recover",$(this).attr("data") )
        });

        $(".wrap_search #searchBtn").blur( function(){
            $(".wrap_search").submit();
        });
    },search:function(val ){
      $.ajax({
            url:common_ops.buildUrl("/invoices/index"),
            type:'GET',
            data:{
                address:val
            },
            dataType:'json',
            success:function( res ){
                console.dir(res);
                var callback = null;
                window.location.href = window.location.href;
                common_ops.alert( res.msg,callback );
            }
        });
    },
    ops:function( act,id ){
        var callback = {
            'ok':function(){
                $.ajax({
                    url:common_ops.buildUrl("/invoices/ops"),
                    type:'POST',
                    data:{
                        act:act,
                        id:id
                    },
                    dataType:'json',
                    success:function( res ){
                        var callback = null;
                        if( res.code == 200 ){
                            callback = function(){
                                window.location.href = window.location.href;
                            }
                        }
                        common_ops.alert( res.msg,callback );
                    }
                });
            },
            'cancel':null
        };
        common_ops.confirm( "确定操作？",callback );
    }
};

$(document).ready( function(){
    invoice_index_ops.init();
});