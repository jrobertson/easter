#!/usr/bin/env ruby

# file: easter.rb

# ASP (rewritten in Ruby) Easter Calculation Library
#
# Copyright (c) 2008, reusablecode.blogspot.com; some rights reserved.
#
# This work is licensed under the Creative Commons Attribution License. To view
# a copy of this license, visit http://creativecommons.org/licenses/by/3.0/ or
# send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California
# 94305, USA.
#
# This function library allows calculation of the following ecclesiastical holidays:
# Ash Wednesday, Palm Sunday, Good Friday, Easter, Ascension Day, and Pentecost.
#
# Refer to Wikipedia for information on the purpose of these holidays..
# Determine the date of Easter for a given year.



require 'date'
require 'human_speakable'

class Easter

  def self.easter(some_year=Time.now.year)

    golden_number = (some_year % 19) + 1
    
    if some_year <= 1752 then
      # Julian calendar
      dominical_number = (some_year + (some_year / 4) + 5) % 7
      paschal_full_moon = (3 - (11 * golden_number) - 7) % 30
    else
      # Gregorian calendar
      dominical_number = (some_year + (some_year / 4) - (some_year / 100) + (some_year / 400)) % 7
      solar_correction = (some_year - 1600) / 100 - (some_year - 1600) / 400
      lunar_correction = (((some_year - 1400) / 100) * 8) / 25
      paschal_full_moon = (3 - 11 * golden_number + solar_correction - lunar_correction) % 30
    end
    
    dominical_number += 7 until dominical_number > 0 

    paschal_full_moon += 30 until paschal_full_moon > 0 
    paschal_full_moon -= 1 if paschal_full_moon == 29 or (paschal_full_moon == 28 and golden_number > 11)

    difference = (4 - paschal_full_moon - dominical_number) % 7
    difference += 7 if difference < 0 

    day_easter = paschal_full_moon + difference + 1
    
    if day_easter < 11 then
      # Easter occurs in March.
      return Date.new(y=some_year, m=3, d=day_easter + 21)
    else
      # Easter occurs in April.
      return Date.new(y=some_year, m=4, d=day_easter - 10)
    end
    
  end
  
  def self.holy_thursday(some_year=Time.now.year)
    easter(some_year) - 3
  end    

  # Determine the date of Good Friday for a given year.
  #
  def self.good_friday(some_year=Time.now.year)
    easter(some_year) - 2
  end
  
  def self.holy_saturday(some_year=Time.now.year)
    easter(some_year) - 1
  end  

  # Determine the date of Palm Sunday for a given year.
  #
  def self.palm_sunday(some_year=Time.now.year)
    easter(some_year) - 7
  end

  # Determines the date of Ash Wednesday for a given year.
  #
  def self.ash_wednesday(some_year=Time.now.year)
    easter(some_year) - 46
  end

  # Determines the date of Ascension Day for a given year.
  #
  def self.ascension_day(some_year=Time.now.year)
    easter(some_year) + 39
  end

  # Determines the date of Pentecost for a given year.
  #
  def self.pentecost(some_year=Time.now.year)
    easter(some_year) + 49
  end

end

class EasterVoice
  using HumanSpeakable
  
  def initialize(future: false)
    @future = future
  end

  def easter()        date :easter                         end
  def ascension_day() date :ascension_day, 'Ascension day' end
  def ash_wednesday() date :ash_wednesday, 'Ash Wednesday' end
  def good_friday()   date :good_friday,   'Good Friday'   end
  def holy_thursday() date :holy_thursday, 'Holy Thursday' end        
  def holy_saturday() date :holy_saturday, 'Holy Saturday' end    
  def palm_sunday()   date :palm_sunday,   'Palm Sunday'   end
  def pentecost()     date :pentecost,     'Pentecost'     end
    
  def easter_dates()
    %i(ash_wednesday palm_sunday good_friday easter ascension_day  pentecost)\
        .map {|day| method(day).call }.join("\n")
  end
  
  
  def lent_start() date :ash_wednesday, 'Lent'               end
  def lent_end()   date :holy_thursday, 'The end of Lent'    end
  
  def lent()
    
    participle = case Date.today
    when (Easter.ash_wednesday..Easter.holy_thursday) then 'is'      
    when (Date.new(Date.year)..Easter.ash_wednesday) then 'will be'
    else 
      'was'
    end
    
    days =  %i(ash_wednesday holy_thursday)\
        .map {|x| Easter.method(x).call.humanize(year: true).sub(/on /,'') }
    "Lent %s from %s to %s." % [participle, *days]
  end
  
  private
  
  def date(s, label=s.to_s.capitalize)

    d = Easter.method(s.to_sym).call    
    
    year = if d < Date.today and @future then
      d = Easter.method(s.to_sym).call(Time.now.year+1)
      ' ' + (Time.now.year+1).to_s
    else
      ''
    end
    
    participle = d >= Date.today ? 'is' : 'was'
    r = "%s %s %s" % [label, participle, d.humanize]
    r + year + '.'
  end
  
end

if $0 == __FILE__ then

  test_year = 2014
  out = []
  out << "Ash Wednesday: ".ljust(15)\
                        + Easter.ash_wednesday(test_year).strftime("%D")
  out << "Palm Sunday: ".ljust(15)\
                        + Easter.palm_sunday(test_year).strftime("%D")
  out << "Good Friday: ".ljust(15)\
                        + Easter.good_friday(test_year).strftime("%D")
  out << "Easter: ".ljust(15) + Easter.easter(test_year).strftime("%D")
  out << "Ascension Day: ".ljust(15)\
                        + Easter.ascension_day(test_year).strftime("%D")
  out << "Pentecost: ".ljust(15)\
                        + Easter.pentecost(test_year).strftime("%D")

  puts out.join "\n"

end
