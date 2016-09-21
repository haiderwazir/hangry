jQuery(document).ready(function($){
	$(document).on('click', '.add_to_order',
		function(){
			$.ajax({
	      type: "POST",
	      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	      url: "/orders",
	      data: {order_id: document.getElementById('order_id').value, item_id: this.id, flavor: document.getElementById('flavor-'+this.id).value},
	     });


		}
	)

	$(document).on('click', '.remove_from_order',
		function(){
			$.ajax({
	      type: "POST",
	      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	      url: "/orders/remove_item",
	      data: {order_id: document.getElementById('order_id').value, item_id: this.id},
	     });
		}
	)

	$(document).on('click', '#confirm_order',
		function(){
			$.ajax({
	      type: "POST",
	      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	      url: "/orders/confirm",
	      data: {order_id: document.getElementById('order_id').value},
	     });
		}
	)
	

	$(function() {
		setTimeout(function(){
	    $('#notice').hide();
	    $('#notice').hide();
	  }, 3000);
	});

	$().UItoTop({ easingType: 'easeOutQuart' });
         // $('.gallery a.gal').touchTouch();
	 $(".bt-menu-trigger").toggle( 
    function(){
      $('.bt-menu').addClass('bt-menu-open'); 
    }, 
    function(){
      $('.bt-menu').removeClass('bt-menu-open'); 
    } 
  ); 
	
});