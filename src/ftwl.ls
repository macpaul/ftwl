fetch(args, cb) =
	error, {statusCode}, body <- (require \request) args
	throw error if error
	throw 'got response '+statusCode unless statusCode === 200
	cb body

### fetch leglist

queryFlag = \true
#searchValues[0] = \王金平

fetch_leglist = fetch url: \http://www.ly.gov.tw/03_leg/0301_main/legList.action

fetch_all_legs = fetch url: \http://www.ly.gov.tw/03_leg/0301_main/legList.action

### parse all legists
parse_all_legs(data, cb) =
	res = []
	$ = require \cheerio .load(data)

	# 第八屆  立法委員名單
	title = $('span[class=leg03_titbg]').text()

	# name of legister
	# name = $('td.leg03_news_search_03 a').text()
	legtable = $('td.leg03_news_search_03').toArray()
	for leg in legtable
		name = leg.children[0].children[0]['data']
		url = leg.children[0]['attribs']['href']
		res.push name, url

#    $('table#tableData tbody tr').each ->
#        try [_area, station, rain] = $ @ .find \td .get!map -> $ it .text!
#        [,station_name,station_id] = station.match /(\S+)\s*\((\S+)\)/
#        [,town,area] = _area.match /(...)(.*)/
#        res.push [station_id, rain, town, area, station_name]

	cb res

module.exports = {
	fetch_all_legs,
	parse_all_legs,
}
