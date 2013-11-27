require './API'

$write_file = "posted_records.txt"
$filenames = ["pipe.txt", "comma.txt", "space.txt", $write_file]

run RecordParser::API