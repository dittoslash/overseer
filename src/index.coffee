templates = require './templates.coffee'
data = require './data.coffee'
u = require './umbrella.min.js'
numeral = require 'numeral'
game =
   minions: []
u = u.u

#copy = (object)
rng = (min,max)-> Math.floor(Math.random() * ((max+1) - min) + min)
rchance = (dec)-> Math.random() < dec
pick = (array)-> array[rng(0,array.length-1)]
picko = (object)-> pick(Object.keys(object))
fnumb = (n)-> numeral(n).format(0.000)

traitFormat = (minion)->
   str = ""
   for i in Object.keys(minion.traits)
      str += "#{i}[#{minion.traits[i]}] "
   return str

calcStatsPart = (stat, minion, trait, val)->
   if trait[stat]
      switch trait[stat][0]
         when "/" then minion[stat[3..].toLowerCase()] /= (val * trait[stat][1])
         when "*" then minion[stat[3..].toLowerCase()] *= (val * trait[stat][1])
         when "+" then minion[stat[3..].toLowerCase()] += (val * trait[stat][1])
         when "-" then minion[stat[3..].toLowerCase()] -= (val * trait[stat][1])

calcStats = (minion)->
   for i in Object.keys(minion.traits)
      val = minion.traits[i]
      trait = data.traits[i]
      calcStatsPart("modBaseLrn", minion, trait, val)
      calcStatsPart("modStr", minion, trait, val)
      calcStatsPart("modCon", minion, trait, val)
      calcStatsPart("modInt", minion, trait, val)
      calcStatsPart("modStrLrn", minion, trait, val)
      calcStatsPart("modConLrn", minion, trait, val)
      calcStatsPart("modIntLrn", minion, trait, val)
draw = ->
   str = "<tr><th>#</th><th>Species</th><th>STR</th><th>CON</th>
   <th>INT</th><th>LRN</th><th>STRLRN</th>
   <th>CONLRN</th><th>INTLRN</th><th>Traits</th></tr>"
   n = 0
   for i in game.minions
      n++
      str += "<tr><td>#{n}</td><td>#{i.species}</td><td>#{fnumb(i.str)}</td><td>#{fnumb(i.con)}</td><td>#{fnumb(i.int)}</td>
      <td>#{fnumb(i.baselrn)}</td><td>#{fnumb(i.strlrn)}</td><td>#{fnumb(i.conlrn)}</td>
      <td>#{fnumb(i.intlrn)}</td><td>#{traitFormat(i)}</td>"

   u("#minions").html str

addNewMinion = ->
   minion = JSON.parse(JSON.stringify(data.species[pick(data.lists.species)]))
   n = 0
   while true
      if rchance(0.75)
         n++
         break if n > 5
         t = picko(data.traits)
         minion.traits[t] = rng(data.lists.traits[t][0], data.lists.traits[t][1])
      else break
   calcStats(minion)
   game.minions.push minion
   console.log(minion)
   draw()

document.addEventListener "DOMContentLoaded", ->
   draw()
   u("button.drawTable").on("click", draw).html("Draw")
   u("button.newMinion").on("click", addNewMinion).html("New Minion")
