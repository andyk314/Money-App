getData = ->
  url = "http://query.yahooapis.com/v1/public/yql"
  symbol = $("#symbol").val()
  data = encodeURIComponent("select * from yahoo.finance.quotes where symbol in ('" + symbol + "')")
  $.getJSON(url, "q=" + data + "&format=json&diagnostics=true&env=http://datatables.org/alltables.env").done((data) ->
    $("#result").text "Bid Price: " + data.query.results.quote.LastTradePriceOnly
    return
  ).fail (jqxhr, textStatus, error) ->
    err = textStatus + ", " + error
    $("#result").text "Request failed: " + err
    return

  return