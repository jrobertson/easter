# Introducing the Easter gem

    require 'easter'

    # return the date of Easter for the current year (2014)
    Easter.easter        #=>  #<DateTime: 2014-04-20T00:00:00+00:00 (...)>

    # return the date of Easter for 2015
    Easter.easter 2015   #=>  #<DateTime: 2015-04-05T00:00:00+00:00 (...)>
 
In addition we can return the dates for Ash Wednesday, Palm Sunday, Good Friday, Ascension Day, and Pentecost.

    Easter.ash_wednesday #=>  #<DateTime: 2014-03-05T00:00:00+00:00 (...)>

## Resources

* [Easter](https://en.wikipedia.org/wiki/Easter)
* [jrobertson/easter](https://github.com/jrobertson/easter)

gem easter dates holidays
