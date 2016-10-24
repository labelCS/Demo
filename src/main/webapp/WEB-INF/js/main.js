$("#xiazai1").live("click",function(e){
	var path = "../upload/QRcode2.jpg";
	$("#myModal").modal("show");
	$("#pictureid").attr("src",path);
 });
$("#xiazai2").live("click",function(e){
	$("#myModal").modal("show");
	var path = "../upload/QRcode3.jpg";
	$("#pictureid").attr("src",path);
});
$("#xiazai3").live("click",function(e){
	$("#myModal").modal("show");
	var path = "../upload/QRcode4.jpg";
	$("#pictureid").attr("src",path);
});
$("#IOSxiazai1").live("click",function(e){
	var path = "../upload/IOSQRcode2.jpg";
	$("#myModal").modal("show");
	$("#pictureid").attr("src",path);
});
$("#IOSxiazai2").live("click",function(e){
	$("#myModal").modal("show");
	var path = "../upload/IOSQRcode3.jpg";
	$("#pictureid").attr("src",path);
});
$("#IOSxiazai3").live("click",function(e){
	$("#myModal").modal("show");
	var path = "../upload/IOSQRcode4.jpg";
	$("#pictureid").attr("src",path);
});

$("#imgClose").hover(
	    function(){
		    $(this).attr("src","../images/close1.png");
	    },
	function(){
		    $(this).attr("src","../images/close.png");
	        }
    );
function closeModel()
{
	$("#myModal").modal('hide');
	//$("#movie").empty();
}