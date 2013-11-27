Reverb-Code-Challenge
=====================

This app allows for the parsing and displaying of records delimited using one of three methods. Records can be parsed from the following formats:

* LastName FirstName MiddleInitial G* BirthDate FavoriteColor
* LastName, FirstName, Gender, FavoriteColor, BirthDate
* LastName | FirstName | MiddleInitial | G* | FavoriteColor | BirthDate

*Single-letter gender abbreviation ("M" or "F")

Records are stored and can be displayed sorted by gender, birth date, or last name.

Application Use
===============

To parse files and display the records they contain, simply run the driver code script ("driver.rb") with the file paths as command-line arguments.

```
ruby driver.rb pipe.txt directory/comma.txt ../otherdirectory/space.txt
```

API Use
=======

This application also comes with an API that can be launched using rack.

```
rackup config.ru
```

While racked, simply GET localhost:9292/records/sort_method with the sort method being "gender", "birthdate", or "name" depending on your preference.

You can also add additional records via a POST request to /records. The request must send the param "record" with the text of the record url-encoded. The record can follow any of the three acceptable formats.

API Configuration
=============

By default, the API expects a "pipe.txt", "comma.txt", and "space.txt" file in its directory, which contain records in the named format.

New records are written to the posted_records.txt file in the root directory. These records will also be read in every time this API is racked again.

To change these options, simply edit the config.ru file. You can change the $write_file variable to the path of the file in which you'd like to save new records. You can change the $filenames variable to an array of filenames you'd like to parse when the API is racked.

Questions and Contact
=====================

Please feel free to send me all questions and comments directly at JosephWLevering at gmail dot com.