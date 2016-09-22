// JavaScript Document
$(document).ready(function(e) {

jQuery("#iPlayer").slide({titCell:".hd .inline",mainCell:".bd ul",effect:"fade",autoPlay:true,autoPage:"<a href='javascript:void(0);'>&nbsp;</a>",trigger:"mouseover"});
$(window).resize(function(){$("#iPlayer .bd ul,#iPlayer .bd li").css({width:$(window).width()})});

$("#iModule li").each(function(){
	var txt = $(".txt",this),
		img = $(".img",this);
	$(this).hover(function(){
		txt.stop(true).animate({"right":"0","opacity":"1"},800,'easeInOutExpo').show();
		img.stop(true).animate({"left":"0","opacity":"1"},1400,'easeInOutExpo').show();
	},function(){
		txt.stop(true).animate({"right":"100%","opacity":"0"},1000,'easeInOutExpo').fadeOut(1000);
		img.stop(true).animate({"left":"100%","opacity":"0"},500,'easeInOutExpo').fadeOut(500);
	})
});

var iSearch = $(".iSearch"),
	iSearchUl = $("ul",iSearch),
	iSearchExt = $("#ext",iSearch);
$(".chosen",iSearch).hover(function(){
	iSearchUl.stop(true).animate({"opacity":"1"}).show();
},function(){
	iSearchUl.stop(true).animate({"opacity":"0"}).fadeOut();
});
$("li",iSearchUl).hover(function(){$(this).addClass("hover")},function(){$(this).removeClass("hover")});
$("li",iSearchUl).click(function(){
	$(".chosen p",iSearch).text($(this).text());
	iSearchExt.val($(this).attr("data"));
	iSearchUl.stop(true).animate({"opacity":"0"}).fadeOut();
});

var iHouse = $("#iHouses"),
	hsbar = $(".bar",iHouse);
$("li",iHouse).each(function(){
	var box = $(".box",this),
		left = $(this).position().left;
	if(box.length>0){
		$(this).hover(function(){
			$(this).addClass("hover");
			hsbar.stop(true).animate({"left":left,"opacity":"1"}).show();
			box.stop(true).animate({"paddingTop": "175px"},800,'easeInOutExpo');
		},function(){
			$(this).removeClass("hover")
			hsbar.stop(true).css({"opacity":"0"}).fadeOut();
			box.stop(true).animate({"paddingTop": "0"},800,'easeInOutExpo');
		})
	}
});

jQuery("#iCasesL").slide({titCell:".hd .inline",mainCell:".bd ul",effect:"leftLoop",autoPlay:true,autoPage:"<a href='javascript:void(0);'>&nbsp;</a>",trigger:"mouseover",startFun: function(i,c){
	$("#iCasesL .page").html((i+1)+'&nbsp;/&nbsp;'+c)
}});
$(".iCasesL .btn").hover(function(){
	$(this).addClass("opac7r");
},function(){
	$(this).removeClass("opac7r");
});

$(".iCasesB li,.iCasesR li").hover(function(){
	$(".line",this).stop(true).animate({"bottom":"0"})
},function(){
	$(".line",this).stop(true).animate({"bottom":"-5px"})
})

jQuery("#iTeam").slide({mainCell:".bd ul",effect:"leftLoop",autoPlay:true,autoPage:false,scroll:1,vis:5,trigger:"mouseover"});

$("#iVisit li").each(function(){
	var me = $(this),
		li = me.siblings("li");
	me.hover(function(){
		if(!me.hasClass("hover")){
			me.addClass("hover").removeClass("first").siblings("li").removeClass("hover").removeClass("first");
			$(".box",this).stop(true).animate({"height":"210px"},800,'easeInOutQuad');
			$(".ht",this).stop(true).animate({"marginBottom":"-30px"},800,'easeInOutQuad');
			$(".box",li).stop(true).animate({"height":"0"},800,'easeInOutQuad');
			$(".ht",li).stop(true).animate({"marginBottom":"0"},800,'easeInOutQuad');
		}
	});
});

jQuery("#iPartner").slide({mainCell:".bd",effect:"fade",autoPlay:true,autoPage:false,scroll:1,vis:1,trigger:"mouseover",interTime:5000});
$(".iPartner li").hover(function(){$(this).addClass("hover")},function(){$(this).removeClass("hover")});

$(".iNews li").each(function(){
	var me = $(this);
	me.hover(function(){
		if(!me.hasClass("hover") && !me.hasClass("first")){
			me.addClass("hover").siblings("li").removeClass("hover");
		}
	});
});

});