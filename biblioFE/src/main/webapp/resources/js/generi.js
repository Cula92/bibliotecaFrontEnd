        $(document).ready(function() {
        	  $("#bottone").click(function(){
        	    var id = $("#id").val();
        	    var formData = $("#modulo").serialize();
        	    $.ajax({
        	      type: "GET",
        	      url: "http://localhost:8080/biblioBE/genere/list",
        	      data: formData,
        	      dataType: "json",
        	      contentType: 'application/json',
        	      success: function(data)
        	      {
        	    	  $("#risultato").html(data);
        	        for(element in data)
        	        	{
        	        	 $("#risultato").append(element.descrizione);
        	        	}
        	      },
        	      error: function()
        	      {
        	        alert("Chiamata fallita, si prega di riprovare...");
        	      }
        	    });
        	  });
        	});