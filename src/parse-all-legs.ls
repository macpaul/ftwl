ftwl = require \./ftwl
argv = require \optimist .argv

doit = ->
    res <- ftwl.parse_all_legs it
    console.log res

if file = argv?file
    data = fs.readFileSync file, \utf8
    data -= /^\uFEFF/ #BOM
    doit data
else
    data <- ftwl.fetch_all_legs!
    doit data
