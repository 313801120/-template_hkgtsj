function reply_submit(f){
var formId = $("#"+f);
var username = formId.find("#username");if(!username.val()){alert("请输入您的称呼");username.focus();return false;}
var contact = formId.find("#contact");if(!(/^1[3|4|5|8][0-9]\d{7,8}$/.test(contact.val()))){alert("手机号码未填写或填写错误");contact.focus();return false;}
var content = formId.find("#content");if(!content.val()){alert("写点什么与大家分享吧。");content.focus();return false;}
var check = formId.find("#sys_check");if(!check.val()){alert("请输入验证码");check.focus();return false;}
	$.get("?c=post&f=ajax_checkcode&sys_check="+check.val(), function(data){
		if(data!="success"){
			formId.find("#imgcode").attr("src",get_url("login,codes")+'rand='+Math.random());
			alert("验证码有误！请重新填写");
			check.val('');check.focus();return false;
		}else{
			$.post(formId.find("form").attr("action"), formId.find("form").serialize(),function(data){
				if(data=='success'){//success
					$(".ajaxtips").html('<font color="#C8A048">评论发布成功！我们客服审核后才显示！</font>');
					content.val('');
					check.val('')
					$.get("?c=reply&id={:$rs[id]}&ajax=1", function(data){
						$(".replylistBox").html(data);
					});
				}else{
					$(".ajaxtips").html('<font color="red">'+data+'</font>');
				}
				formId.find("#imgcode").attr("src",get_url("login,codes")+'rand='+Math.random());
			});
			return false;
		}
	});
	return false;
};