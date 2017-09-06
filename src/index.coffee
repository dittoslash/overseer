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
   research: {}
u = u.u
game.research[i] = 0 for i in Object.keys(data.research)

#copy = (object)
rng = (min,max)-> Math.floor(Math.random() * ((max+1) - min) + min)
rchance = (dec)-> Math.random() < dec
pick = (array)-> array[rng(0,array.length-1)]
picko = (object)-> pick(Object.keys(object))
fnumb = (n)-> numeral(n).format("0.[000]")

traitFormat = (minion)->
   str = ""
   for i in Object.keys(minion.traits)
      str += "#{i}[#{minion.traits[i]}] "
   str = "None" if str == ""
   return str

drawCommander = (minion, n)->
   str = "<select id='command-#{n}'><option disabled>Job</option>"
   str += "<option>#{i}</option>" for i in data.jobs
   str += "</select>"
   return str

partCalcStatBounds = (val) ->
   if val[..8] == "research"
      if game.research[val] > 0
         [1, game.research[val]+1]
      else
         [1, 1]
   else
      return [1, 1]

partCalcStats = (stat, minion, trait, val)->
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
         partCalcStats(i, minion, trait, val)

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
      str += "<td>#{traitFormat(i)}</td><td>#{drawCommander(i, n)}</td></tr>"
      drawInv()

   u("#minions").html str

drawInv = -> u("#inventory").html "<tr><td>Wood: #{fnumb(game.wood)}</td><td>Stone: #{fnumb(game.stone)}</td><td>Stone Bricks: #{fnumb(game.stonebricks)}</td><td>Science: #{fnumb(game.science)}</td></tr>"

addNewMinion = ->
   minion = JSON.parse(JSON.stringify(data.species[pick(data.lists.species)]))
   n = 0
   while true
      if rchance(0.75)
         t = picko(data.lists.traits)
         valBounds = data.lists.traits[t]
         if typeof valBounds == "string"
            valBounds = partCalcStatBounds(valBounds)
         val = rng(valBounds[0], valBounds[1])
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
   n = 0
   for i in game.minions
      n += 1
      e = document.getElementById("command-#{n}")
      i.job = e.options[e.selectedIndex].text
   for i in game.minions
      switch i.job
         when "Miner"       then game.stone += 0.1*i.str*(i.con*0.5)
         when "Woodcutter"  then game.wood += 0.1*i.str*(i.con*0.5)
         when "Stonecutter" then game.stonebricks += 0.1*(i.str*0.5)*i.con
         when "Researcher"  then game.science += 0.1*i.int
   drawInv()
, 100)
