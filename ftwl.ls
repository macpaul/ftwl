fetch(args, cb) =
    error, {statusCode}, body <- (require \request) args
    throw error if error
    throw 'got response '+statusCode unless statusCode === 200
    cb body

### fetch leglist

leglist = fetch url: \http://www.ly.gov.tw/03_leg/0301_main/legList.action
queryFlag = \true
searchValues[0] = \王金平

