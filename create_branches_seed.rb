# coding: utf-8
require 'rubygems'
require 'nokogiri'

puts "Branch.create(:name => 'Cluster Medien & Kreativwirtschaft', :internal_type => 'cluster')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Software/Games-Industrie', :internal_key => 'SG')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Buchmarkt', :internal_key => 'BM')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Pressemarkt', :internal_key => 'PM')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Rundfunkwirtschaft', :internal_key => 'RW')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Filmwirtschaft', :internal_key => 'FW')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Markt für darstellende Künste', :internal_key => 'DK')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Kunstmarkt', :internal_key => 'KM')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Musikwirtschaft', :internal_key => 'MW')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Werbemarkt', :internal_key => 'WM')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Designwirtschaft', :internal_key => 'DW')"
puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_type => 'sub_market', :name => 'Architekturmarkt', :internal_key => 'AM')"



doc = Nokogiri::HTML(open('branches.htm'))

b = []

doc.search('tr').each do |i|
	a = []
	i.search('td').each do |j|
			#puts "#"
			#puts 	j.inner_html
			a << j.content
	end
	b << a[3]
	# Branch.create(:parent_id => 1, :cluster_id => 1, :internal_key => "1A", :name => "Interaktive Medien", :description => "Ganz tolle Interaktionen möglich.")
	puts "Branch.create(:parent_id => Branch.find_by_name('Cluster Medien & Kreativwirtschaft').id, :internal_key => '#{a[2]}', :name => '#{a[3]}', :internal_type => 'main_branch')"
	#puts "-------------------"
end


doc = Nokogiri::HTML(open('subbranches.htm'))

doc.search('tr').each do |i|
	a = []
	i.search('td').each do |j|
			#puts "#"
			#puts 	j.inner_html
			a << j.content
	end
	#puts a.inspect
	case a[2]
		when '1' then a[2] = b[0]
		when '2' then a[2] = b[1]
		when '3'	then a[2] = b[2]
		when '4'	then a[2] = b[3]
		when '5'	then a[2] = b[4]
		when '6'	then a[2] = b[5]
	end
	# Branch.create(:parent_id => 1, :cluster_id => 1, :internal_key => "1A", :name => "Interaktive Medien", :description => "Ganz tolle Interaktionen möglich.")
	puts "Branch.create(:parent_id => Branch.find_by_name('#{a[2]}').id, :internal_key => '#{a[5]}', :name => '#{a[4]}', :internal_type => 'sub_branch')"
	#puts "-------------------"
end


