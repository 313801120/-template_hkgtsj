// JavaScript Document
/*! jquery.easing */jQuery.easing.jswing=jQuery.easing.swing,jQuery.extend(jQuery.easing,{def:"easeOutQuad",swing:function(a,b,c,d,e){return jQuery.easing[jQuery.easing.def](a,b,c,d,e)},easeInQuad:function(a,b,c,d,e){return d*(b/=e)*b+c},easeOutQuad:function(a,b,c,d,e){return-d*(b/=e)*(b-2)+c},easeInOutQuad:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b+c:-d/2*(--b*(b-2)-1)+c},easeInCubic:function(a,b,c,d,e){return d*(b/=e)*b*b+c},easeOutCubic:function(a,b,c,d,e){return d*((b=b/e-1)*b*b+1)+c},easeInOutCubic:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b+c:d/2*((b-=2)*b*b+2)+c},easeInQuart:function(a,b,c,d,e){return d*(b/=e)*b*b*b+c},easeOutQuart:function(a,b,c,d,e){return-d*((b=b/e-1)*b*b*b-1)+c},easeInOutQuart:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b*b+c:-d/2*((b-=2)*b*b*b-2)+c},easeInQuint:function(a,b,c,d,e){return d*(b/=e)*b*b*b*b+c},easeOutQuint:function(a,b,c,d,e){return d*((b=b/e-1)*b*b*b*b+1)+c},easeInOutQuint:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b*b*b+c:d/2*((b-=2)*b*b*b*b+2)+c},easeInSine:function(a,b,c,d,e){return-d*Math.cos(b/e*(Math.PI/2))+d+c},easeOutSine:function(a,b,c,d,e){return d*Math.sin(b/e*(Math.PI/2))+c},easeInOutSine:function(a,b,c,d,e){return-d/2*(Math.cos(Math.PI*b/e)-1)+c},easeInExpo:function(a,b,c,d,e){return 0==b?c:d*Math.pow(2,10*(b/e-1))+c},easeOutExpo:function(a,b,c,d,e){return b==e?c+d:d*(-Math.pow(2,-10*b/e)+1)+c},easeInOutExpo:function(a,b,c,d,e){return 0==b?c:b==e?c+d:(b/=e/2)<1?d/2*Math.pow(2,10*(b-1))+c:d/2*(-Math.pow(2,-10*--b)+2)+c},easeInCirc:function(a,b,c,d,e){return-d*(Math.sqrt(1-(b/=e)*b)-1)+c},easeOutCirc:function(a,b,c,d,e){return d*Math.sqrt(1-(b=b/e-1)*b)+c},easeInOutCirc:function(a,b,c,d,e){return(b/=e/2)<1?-d/2*(Math.sqrt(1-b*b)-1)+c:d/2*(Math.sqrt(1-(b-=2)*b)+1)+c},easeInElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(1==(b/=e))return c+d;if(g||(g=.3*e),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return-(h*Math.pow(2,10*(b-=1))*Math.sin((b*e-f)*2*Math.PI/g))+c},easeOutElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(1==(b/=e))return c+d;if(g||(g=.3*e),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return h*Math.pow(2,-10*b)*Math.sin((b*e-f)*2*Math.PI/g)+d+c},easeInOutElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(2==(b/=e/2))return c+d;if(g||(g=e*.3*1.5),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return 1>b?-.5*h*Math.pow(2,10*(b-=1))*Math.sin((b*e-f)*2*Math.PI/g)+c:.5*h*Math.pow(2,-10*(b-=1))*Math.sin((b*e-f)*2*Math.PI/g)+d+c},easeInBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),d*(b/=e)*b*((f+1)*b-f)+c},easeOutBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),d*((b=b/e-1)*b*((f+1)*b+f)+1)+c},easeInOutBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),(b/=e/2)<1?d/2*b*b*(((f*=1.525)+1)*b-f)+c:d/2*((b-=2)*b*(((f*=1.525)+1)*b+f)+2)+c},easeInBounce:function(a,b,c,d,e){return d-jQuery.easing.easeOutBounce(a,e-b,0,d,e)+c},easeOutBounce:function(a,b,c,d,e){return(b/=e)<1/2.75?d*7.5625*b*b+c:2/2.75>b?d*(7.5625*(b-=1.5/2.75)*b+.75)+c:2.5/2.75>b?d*(7.5625*(b-=2.25/2.75)*b+.9375)+c:d*(7.5625*(b-=2.625/2.75)*b+.984375)+c},easeInOutBounce:function(a,b,c,d,e){return e/2>b?.5*jQuery.easing.easeInBounce(a,2*b,0,d,e)+c:.5*jQuery.easing.easeOutBounce(a,2*b-e,0,d,e)+.5*d+c}});
$(document).ready(function() {

$("#Nav li").each(function(){
	var ol = $(this).find("ol");
	if(ol.length>0){
		$(this).hover(function(){
			ol.css("display","block").animate({"top":"100%","opacity":"1"},300,'easeOutExpo');
		},function(){
			ol.css("display","none").animate({"top":"200%","opacity":"0"},300,'easeOutExpo');
		})
	}
});


//hover
$(".CasesList li,.TeamList li,.JobList li,.ReservaList li").hover(function(){$(this).addClass("hover")},function(){$(this).removeClass("hover")});


$(".hoverList li").hover(function(){
	$(this).find(".lineT,.lineB").stop(true).animate({width: "100%"},500,'easeOutExpo');
	$(this).find(".lineR,.lineL").stop(true).animate({height: "100%"},500,'easeOutExpo');
},function(){
	$(this).find(".lineT,.lineB").stop(true).animate({width: "0"},300,'easeOutExpo');
	$(this).find(".lineR,.lineL").stop(true).animate({height: "0"},300,'easeOutExpo');
});



//右浮动二微码
$("#sideFloat .weixin").hover(function(){
	$(this).find(".img").css({"display":"block"}).animate({opacity: "1",right: "100%"},300,'easeInQuart');
},function(){
	$(this).find(".img").css({"display":"none"}).animate({opacity: "0",right: "200%"},300,'easeInQuart');
});
//返回顶部
$("#backTop,#sidebackTop").click(function(){$('html,body').animate({scrollTop: '0px'}, 800);});


/*input focus*/
$(".table input[type='text'],.table textarea,.iReinfo .cls_houses").focus(function(){$(this).addClass("focus")})
											  .blur(function(){$(this).removeClass("focus")});
$(".table input[type='text'],.table textarea,.iReinfo .cls_houses").hover(function(){$(this).addClass("hover")},function(){$(this).removeClass("hover")});
/*验证码*/
var sCheck = $("#iIndent").find("#sys_check");
sCheck.focus(function(){
	$(this).siblings(".imgcode").css("display","block").animate({"bottom":"100%","opacity":"1"});
});
sCheck.blur(function(){
	$(this).siblings(".imgcode").css("display","none").animate({"bottom":"140%","opacity":"0"});
});
//普通input placeholder
$(".input").each(function(){
	var p = $(this).attr("placeholder");
	if(p){$(this).placeholder();}
});
//报名表单 placeholder
$("#pubRInd,#reinfoForm").find("input[type='text'],textarea").each(function() {
	var clue_on = $(this).closest(".table").find(".clue_on");
	$(this).attr('placeholder', clue_on.text());
	if(!$.browser.msie){
		$(this).focus(function(){$(this).attr("placeholder",'');});
		$(this).blur(function(){$(this).attr("placeholder", clue_on.text());});
	}
}).placeholder();

});

/*公共验证*/
function pub_submit(f){
	var formId = $("#"+f);
	var contact = formId.find("#contact");if(!contact.val()){alert("请输入您的称呼");contact.focus();return false;}
	var phone = formId.find("#phone");if(!(/^1[3|4|5|7|8]{1}[0-9]{9}$/.test(phone.val()))){alert("手机号码未填写或填写错误");phone.focus();return false;}
	var check = formId.find("#sys_check");if(!check.val()){alert("请输入验证码");check.focus();return false;}
	$.get("?c=post&f=ajax_checkcode&sys_check="+check.val(), function(data){
	if(data!="success"){formId.find("#imgcode").attr("src",get_url("login,codes")+'rand='+Math.random());alert("验证码有误！请重新填写");check.val('');check.focus();return false;}else{$.post(formId.find("form").attr("action"), formId.find("form").serialize(),function(data){alert(formId.find("#tomsg").val());formId.find("#imgcode").attr("src",get_url("login,codes")+'rand='+Math.random());check.val('');});}});
	return false;
}
