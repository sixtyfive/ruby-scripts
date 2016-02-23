#!/usr/bin/env ruby

text = File.read('data/arabisch.txt')
sentences = text.gsub(/[\n]+/, "\n").split(/\n|\.|,|;/) # Even a comma would end a sentence for our purposes.

shortest_sequence = 2
possible_sequences = []

sentences.each do |sen|
  words = sen.split
  longest_sequence = words.length
  next if longest_sequence < shortest_sequence
  seqs = []

  puts "Neuer Satz:"

  words.length.times do |pos|
    (shortest_sequence..longest_sequence).each do |len|
      seq = words[pos, len]
      seqs << seq if seq.length >= shortest_sequence
    end
  end

  puts seqs.uniq.inspect
  puts "--"

  seqs.uniq.each do |seq|
    possible_sequences << seq.join(' ')
  end
end

sequences = {}
minimum_occurances = 2

possible_sequences.uniq.each do |seq|
  occurances = text.scan(/(?=#{seq})/).count
  if sequences[seq]
    sequences[seq] += occurances
  else
    sequences[seq] = occurances
  end
end

sequences.sort_by {|k,v| v}.to_h.each {|k,v| puts "#{v} times: '#{k}'" if v >= minimum_occurances}
