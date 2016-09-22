$(document).ready(function(e) {
$('#fullpage').fullpage({
	anchors: ['firstPage', 'secondPage', '3rdPage', '4thpage','5thpage','6thpage','7thpage','8thpage','lastPage'],
	menu: '#menu',
	verticalCentered: false,
	//loopTop: true,
	//loopBottom: true,
	navigation: true,
	navigationPosition: 'left',
	slidesNavigation: true,
	//scrollOverflow: true,
	css3: true,
	//页面初始化完成后
	afterRender: function(anchorLink, index){
		//$(".qiu").addClass("first").animate({left: "50%",top: "40%"},500);
	},
	//进入第*屏
	afterLoad: function(anchorLink, index){
//		if(index==1){
//			$(".qiu").addClass("first").animate({left: "50%",top: "40%"},500);
//		}
//			if(index=3){
//				$("#fp-nav li").eq(3).children("a").removeClass("active");
//			}
//			if(index=4){
//				$("#fp-nav li").eq(2).children("a").removeClass("active");
//			}
	},
	//离开第*屏
	onLeave: function(index,nextIndex,direction){
//		if(index==1){
//			$(".qiu").removeClass("first").animate({left: "100px",top: "60%"},500);
//		}
	},

});


$(".ztModule li").each(function(){
	var bg = $(".bg",this),txt = $(".txt",this);
	$(this).hover(function(){
		bg.stop(true).animate({"top":"-100%","opacity":"0"},600,'easeInOutExpo').fadeOut(600);
		txt.stop(true).animate({"top": "110%"});
	},function(){
		bg.stop(true).animate({"top":"0","opacity":"1"},800,'easeInOutExpo').show();
		txt.stop(true).animate({"top": "53px"});
	})
});


$("#Slide4").slide({titCell:"",mainCell:".bd ul",effect:"leftLoop",autoPlay:true,autoPage:false,trigger:"mouseover"});

$("#Slide5").slide({titCell:"",mainCell:".bd ul",effect:"leftLoop",autoPlay:true,autoPage:false,trigger:"mouseover",startFun: function(i,c){
	var li = $("#Slide5 li").eq(i+1);
	li.addClass('tc').removeClass('tl tr');
	li.prevAll().addClass('tr').removeClass('tc tl');
	li.nextAll().addClass('tl').removeClass('tc tr');
	li.find('img').animate({width: '670px',height: '445px',marginTop: '0px'},1000);
	li.siblings('li').find('img').animate({width: '610px',height: '385px',marginTop: '30px'},100);
}});

$("#Slide6").slide({titCell:".hd li",mainCell:".bd ul",effect:"fade",autoPlay:true,autoPage:false,trigger:"mouseover"});

$("#Slide7").slide({titCell:"",mainCell:".bd ul",effect:"leftLoop",autoPlay:true,autoPage:false,trigger:"mouseover"});

$("#Slide8").slide({titCell:".hd a",mainCell:".bd ul",effect:"leftLoop",autoPlay:false,autoPage:false,trigger:"mouseover"});

$("#Slide8 .lImg").slide({titCell:".imgHd a",mainCell:".imgBd",effect:"leftLoop",autoPlay:true,autoPage:false,trigger:"mouseover",prevCell:".sprev",nextCell:".snext"});

//右浮动二微码
$("#sideFloat .weixin").hover(function(){
	$(this).find(".img").css({"display":"block"}).animate({opacity: "1",right: "100%"},300,'easeInQuart');
},function(){
	$(this).find(".img").css({"display":"none"}).animate({opacity: "0",right: "200%"},300,'easeInQuart');
});
//返回顶部
$("#backTop,#sidebackTop").click(function(){$('html,body').animate({scrollTop: '0px'}, 800);});


});