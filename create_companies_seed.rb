# encoding: utf-8

require "rubygems"
require "active_record"
require "mysql"
require "json"

ActiveRecord::Base.establish_connection(:database => "api", :adapter => "mysql", :username => "root", :password => "blubbi123", :encoding => "utf8")

require '../api/lib/models.rb'

t = TempSync.all

t.each do |n|
	a = n.json[-1] != '}' ? n.json + '"}' : n.json
	j = JSON.parse(a)

	#puts j.inspect
	
	str = "Company.create("
	str << ":old_id => #{j['id']}, " if j['id']
	str << ":main_branch => Branch.find_by_internal_key('#{j['Hauptbranche']}'), " unless j['Hauptbranche'].empty? if j['Hauptbranche']
	str << ":sub_market => Branch.find_by_internal_key('#{j['MkwTeilmarkt']}'), " unless j['MkwTeilmarkt'].empty? if j['MkwTeilmarkt']
	if j['Name']
	unless j['Name'].empty?
		j['Name'].gsub!("'", "\\'")
		str << ":name => '#{j['Name']}', "
	end
	end
	str << ":street => '#{j['Strasse']}', " unless j['Strasse'].empty? if j['Strasse']
	if j['Hausnummer']
	unless j['Hausnummer'].empty? 
		j['Hausnummer'] =~ /[0-9]+/
		str << ":housenumber => #{$&}, " if $&
	end
	end
	if j['HausnummerZusatz'].nil? or j['HausnummerZusatz'].empty?
		j['HausnummerZusatz'] = $'
	else
		j['HausnummerZusatz'] = $' + " " + j['HausnummerZusatz'] unless $'.nil?
	end

	str << ":housenumber_additional => '#{j['HausnummerZusatz']}', " unless j['HausnummerZusatz'].empty? if j['HausnummerZusatz']
	str << ":postcode => '#{j['Plz']}', " unless j['Plz'].empty? if j['Plz']
	str << ":city => '#{j['Ort']}', " unless j['Ort'].empty? if j['Ort']
	if j['Tel1']
		unless j['Tel1'].empty?
				j['Tel1'].lstrip!
				j['Tel1'] = "+" + j['Tel1'] if j['Tel1'][0] != "+"
				
				str << ":phone_primary => '#{j['Tel1']}', " 
		end
	end

	str << ":phone_secondary => '#{j['Tel2']}', " unless j['Tel2'].empty? if j['Tel2']
	str << ":mobile_primary => '#{j['Mobil1']}', " unless j['Mobil1'].empty? if j['Mobil1']
	str << ":mobile_secondary => '#{j['Mobil2']}', " unless j['Mobil2'].empty? if j['Mobil2']
	str << ":url_primary => '#{j['Url1']}', " unless j['Url1'].empty? if j['Url1']
	str << ":url_secondary => '#{j['Url2']}', " unless j['Url2'].empty? if j['Url2']
	str << ":email_primary => '#{j['Email1']}', " unless j['Email1'].empty? if j['Email1']
	str << ":email_secondary => '#{j['Email2']}'" unless j['Email2'].empty? if j['Email2']

	#remove trailing comma if necessary
	str = str[0..-3] if str[-3..-1] == "', "
	str << ")"
	
	puts str
	
	puts "t = Company.find_by_old_id(#{j['id']})"
	

	puts "t.sub_market = Branch.find_by_internal_key('#{j['MkwTeilmarkt']}')" unless j['MkwTeilmarkt'].empty? if j['MkwTeilmarkt']

	puts "t.main_branch = Branch.find_by_internal_key('#{j['Hauptbranche']}')" unless j['Hauptbranche'].empty? if j['Hauptbranche']

	puts "t.sub_branches<<(Branch.find_by_internal_key('#{j['Unterbranche1']}'))" unless j['Unterbranche1'].empty? if j['Unterbranche1']
	puts "t.sub_branches<<(Branch.find_by_internal_key('#{j['Unterbranche2']}'))" unless j['Unterbranche2'].empty? if j['Unterbranche2']
	puts "t.sub_branches<<(Branch.find_by_internal_key('#{j['Unterbranche3']}'))" unless j['Unterbranche3'].empty? if j['Unterbranche3']
	puts "t.sub_branches<<(Branch.find_by_internal_key('#{j['Unterbranche4']}'))" unless j['Unterbranche4'].empty? if j['Unterbranche4']
	puts "t.sub_branches<<(Branch.find_by_internal_key('#{j['Unterbranche5']}'))" unless j['Unterbranche5'].empty? if j['Unterbranche5']
	puts "t.sub_branches<<(Branch.find_by_internal_key('#{j['Unterbranche6']}'))" unless j['Unterbranche6'].empty? if j['Unterbranche6']
	
	unless j['GF1Vorname'].nil?
	unless j['GF1Vorname'].empty?
	str = "t.people.create({"
	str << ":first_name => '#{j['GF1Vorname']}', " unless j['GF1Vorname'].empty? if j['GF1Vorname']
	str << ":last_name => '#{j['GF1Nachname']}', " unless j['GF1Nachname'].empty? if j['GF1Nachname']
	str << ":title => '#{j['GF1Titel']}', " unless j['GF1Titel'].empty? if j['GF1Titel']
	str << ":position => '#{j['GF1Funktion']}', " unless j['GF1Funktion'].empty? if j['GF1Funktion']

	str << ":type => 'manager'})"
	puts str
	end
	end
	
	unless j['GF2Vorname'].nil?
	unless j['GF2Vorname'].empty?
	str = "t.people.create({"
	str << ":first_name => '#{j['GF2Vorname']}', " unless j['GF2Vorname'].empty? if j['GF2Vorname']
	str << ":last_name => '#{j['GF2Nachname']}', " unless j['GF2Nachname'].empty? if j['GF2Nachname']
	str << ":title => '#{j['GF2Titel']}', " unless j['GF2Titel'].empty? if j['GF2Titel']
	str << ":position => '#{j['GF2Funktion']}', " unless j['GF2Funktion'].empty? if j['GF2Funktion']

	str << ":type => 'manager'})"
	puts str
	end
	end

	unless j['GF3Vorname'].nil?
	unless j['GF3Vorname'].empty?
	str = "t.people.create({"
	str << ":first_name => '#{j['GF3Vorname']}', " unless j['GF3Vorname'].empty? if j['GF3Vorname']
	str << ":last_name => '#{j['GF3Nachname']}', " unless j['GF3Nachname'].empty? if j['GF3Nachname']
	str << ":title => '#{j['GF3Titel']}', " unless j['GF3Titel'].empty? if j['GF3Titel']
	str << ":position => '#{j['GF3Funktion']}', " unless j['GF3Funktion'].empty? if j['GF3Funktion']

	str << ":type => 'manager'})"
	puts str
	end
	end

	unless j['Asp1Vorname'].nil?
	unless j['Asp1Vorname'].empty?
	str = "t.people.create({"
	str << ":first_name => '#{j['Asp1Vorname']}', " unless j['Asp1Vorname'].empty? if j['Asp1Vorname']
	str << ":last_name => '#{j['Asp1Nachname']}', " unless j['Asp1Nachname'].empty? if j['Asp1Nachname']
	str << ":title => '#{j['Asp1Titel']}', " unless j['Asp1Titel'].empty? if j['Asp1Titel']
	str << ":position => '#{j['Asp1Funktion']}', " unless j['Asp1Funktion'].empty? if j['Asp1Funktion']

	str << ":type => 'contact'})"
	puts str
	end
	end

	unless j['Asp2Vorname'].nil?
	unless j['Asp2Vorname'].empty?
	str = "t.people.create({"
	str << ":first_name => '#{j['Asp2Vorname']}', " unless j['Asp2Vorname'].empty? if j['Asp2Vorname']
	str << ":last_name => '#{j['Asp2Nachname']}', " unless j['Asp2Nachname'].empty? if j['Asp2Nachname']
	str << ":title => '#{j['Asp2Titel']}', " unless j['Asp2Titel'].empty? if j['Asp2Titel']
	str << ":position => '#{j['Asp2Funktion']}', " unless j['Asp2Funktion'].empty? if j['Asp2Funktion']

	str << ":type => 'contact'})"
	puts str
	end
	end

	puts "t.save"
end
