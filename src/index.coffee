templates = require './templates.coffee'
data = require './data.coffee'
u = require './umbrella.min.js'
numeral = require 'numeral'
game =
   wood: 0
   stone: 0
   stonebricks: 0
   science: 0
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
   str = "None" if str == ""
   return str

drawCommander = (minion, n)->
   str = "<select, class='command-#{n}'><option disabled>Job</option>"
   str += "<option>#{i}</option>" for i in data.jobs
   str += "</select>"
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
      for i in ["modBaseLrn", "modStr", "modCon", "modInt", "modStrLrn", "modConLrn", "modIntLrn"]
         calcStatsPart(i, minion, trait, val)

draw = ->
   str = ""
   stats = data.stats
   str += "<tr><th>#</th>"
   str += "<th>#{stats[i]}</th>" for i in Object.keys(stats)
   str += "<th>Traits</th><th>Command</th></tr>"
   n = 0
   for i in game.minions
      n += 1
      str += "<tr><td>#{n}</td>"
      for s in Object.keys(stats)
         if typeof i[s] == "number" then str += "<td>#{fnumb(i[s])}</td>"
         else str += "<td>#{i[s]}</td>"
      str += "<td>#{traitFormat(i)}</td><td>#{drawCommander(i, n-1)}</td></tr>"

   u("#minions").html str
   u("#inventory").html "<tr><td>Wood: #{game.wood}</td><td>Stone: #{game.stone}</td><td>Stone Bricks: #{game.stonebricks}</td><td>Science: #{game.science}</td></tr>"

addNewMinion = ->
   minion = JSON.parse(JSON.stringify(data.species[pick(data.lists.species)]))
   n = 0
   while true
      if rchance(0.75)
         t = picko(data.traits)
         val = rng(data.lists.traits[t][0], data.lists.traits[t][1])
         n += val
         break if n > 5
         minion.traits[t] = val
      else break
   calcStats(minion)
   game.minions.push minion
   console.log(minion)
   draw()

document.addEventListener "DOMContentLoaded", ->
   draw()
   u("button.drawTable").on("click", draw).html("Draw")
   u("button.newMinion").on("click", addNewMinion).html("New Minion")

setInterval(->
   for i in game.minions

, 100)
