var upload = {
    error: function (msg) {
        common_ops.alert(msg);
    },
    success: function (file_key) {
        if (!file_key) {
            return;
        }
        var html = '<img width="100%"  height="100%" src="' + common_ops.buildPicUrl(file_key) + '" onclick="tf.click();"/>';
        $("#upd_img").html(html);

    }
};
var invoice_index_ops = {
    init:function(){
        this.eventBind();
    },
    eventBind:function(){
        var that = this;
        $(".upload_pic_wrap input[name=icon]").change(function () {
             $(".upload_pic_wrap").submit();
        });

        $(".right-invoice button").click(function () {
            that.ops( "add",$(this).attr("data") )
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
        // $("#searchBtn").blur( function(){
        //       that.search($(this).val())
        // });
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
                    url:common_ops.buildUrl("/goods/ops"),
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
        common_ops.confirm( ( act=="remove" )?"确定删除？":"确定恢复？",callback );
    }
};

$(document).ready( function(){
    invoice_index_ops.init();
});