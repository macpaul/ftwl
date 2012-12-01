fetch(args, cb) =
	error, {statusCode}, body <- (require \request) args
	throw error if error
	throw 'got response '+statusCode unless statusCode === 200
	cb body

### fetch leglist

queryFlag = \true
#searchValues[0] = \王金平

twlyurl = \http://www.ly.gov.tw

fetch_all_legs = fetch url: \http://www.ly.gov.tw/03_leg/0301_main/legList.action

# fetch_a_leg(data, cb) =
#	console.log data
#	legintro = fetch url: data
#	cb legintro
fetch_a_leg = fetch url: \http://www.ly.gov.tw/03_leg/0301_main/legIntro.action?lgno=00001&stage=8

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
		leginfo = {}
		leginfo['name'] = leg.children[0].children[0]['data']
		leginfo['url'] = twlyurl + leg.children[0]['attribs']['href']
		#res.push [name, url]
		res.push leginfo
	cb res

parse_a_leg(data, cb) =
	leginfo = []
	$ = require \cheerio .load(data)
	# console.log $.html()

	leginfotb = $('td.contentbgtop04').next().children().html()
	# console.log leginfotb

	$ = require \cheerio .load(leginfotb)
	leginfotb = $('table')
	# console.log leginfotb.html()

	# picture and party info
	party = $('table tr td').children().text()
	#console.log party

	# intro
	intro = $('table').children().next().html()
	# console.log intro
	$ = require \cheerio .load(intro)

	#intro_html = $('td ul li').html()
	introtb = $('td ul li').toArray()

	# 中文名字
	intro_name = introtb[0]['children'][0]['data']
	console.log intro_name

	# 英文名字
	intro_enname = introtb[1]['children'][0]['data']
	console.log intro_enname

	# 性別
	intro_sex = introtb[2]['children'][0]['data']
	console.log intro_sex

	# 黨籍
	intro_party = introtb[3]['children'][0]['data']
	console.log intro_party

	# 黨團
	intro_partygroup = introtb[4]['children'][0]['data']
	console.log intro_partygroup

	# 選區
	intro_elecreg = introtb[5]['children'][0]['data']
	console.log intro_elecreg

	# 委員會
	intro_commitee = introtb[6]['children'][0]['data']
	console.log intro_commitee


	cb leginfo

module.exports = {
	fetch_all_legs,
	fetch_a_leg,
	parse_all_legs,
	parse_a_leg,
}
