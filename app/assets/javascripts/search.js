var masterList = [];

$(document).ready(function() {
	
	$("input[name='search']")
		.on('input', function(event) {

			//clear search results when search field is empty
			if(event.target.value.length === 0) {
				$("#searchResults").empty();

			//ajax request for names and playerIDs when one letter is input 
			} else if(event.target.value.length === 1 && event.target.value.match(/[a-z]/i)) {
				$.ajax("/letterlist/" + event.target.value)
					.done(function(data) {
						masterList = data;

						//after receiving list, make sure only one char. is in search field before showing full list for that letter
						if($("input[name='search']").val().length === 1) {
							$("#searchResults").empty();
							data.forEach(function(player) {
								appendLink(player);
							});

						//handle when 2nd char. input before ajax is complete
						} else if (event.target.value.length > 1) {
							localLookup(event.target.value);
						}
					});

			//search locally stored list when more than one char. in search field
			} else if(event.target.value.length > 1) {
				localLookup(event.target.value);
			}
		});
})

//appends player page link to search results div
function appendLink(playerInfo) {
	$("#searchResults")
		.append("<a href='/masters/" + playerInfo[2] + "'><p>" + playerInfo[1] + ", " + playerInfo[0] + "</p></a>");
}

//searches locally stored list for a last name beginning with the search string
function localLookup(rawSearchString) {
	$("#searchResults").empty();
	var searchString = rawSearchString.toLowerCase();
	var searchStringLength = searchString.length;
	//check if masterList corresponds to first letter first?
	masterList.forEach(function(player) {
		if(player[1].toLowerCase().slice(0, searchStringLength) === searchString) {
			appendLink(player);
		}
	});

}