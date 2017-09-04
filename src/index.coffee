templates = require './templates.coffee'
data = require './data.coffee'
u = require './umbrella.min.js'
game =
   minions: []
u = u.u

rng = (min,max)-> Math.floor(Math.random() * (max - min) + min)

traitFormat = (i)->


draw = ->
   str = "<tr><th>#</th><th>STR</th><th>CON</th>
   <th>INT</th><th>LRN</th><th>STRLRN</th>
   <th>CONLRN</th><th>INTLRN</th><th>Traits</th></tr>"
   for i in game.minions
      str += "<tr><td>#{i.str}</td><td>#{i.con}</td><td>#{i.int}</td>
      <td>#{i.baselrn}</td><td>#{i.strlrn}</td><td>#{i.conlrn}</td>
      <td>#{i.lrn}</td><td>#{traitFormat(i)}</td>"

   u("#minions").html str

addNewMinion = ->
   minion = templates.minion
   


draw()

u("button.drawTable").on("click", draw)
u("button.newMinion").on("click", addNewMinion)