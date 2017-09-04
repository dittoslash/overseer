module.exports =
   lists:
      traits: {HardWorker: [1, 3]}
      species: ["human", "goblin"]
   traits:
      ###
      HOW SHIT WORKS
      modN modifies stat N with various options.
      1st option (X): any mathmatical sign (*+-/)
      2nd option (Y): any number
      Stat N will be set to itself X (Y * trait level).
      For example: modStr: ["*", 2] with str 1 and level 3
      2 * 3 = 6, 6 * 1 = 6, new str = 6
      func is a function that takes the minion and returns the changed version.
      ###
      HardWorker:
         modBaseLrn: ["/", 2]
         modStr: ["*", 2]
         modCon: ["*", 2]
         modConLrn: ["/", 2]
         modInt: ["/", 4]
         modIntLrn: ["/", 4]
   species: #Species define base stats of a minion.
      human:  {baselrn: 1, str: 1, strlrn: 1.5, con: 1, conlrn: 1.5, int: 3, intlrn: 1.5}
      goblin: {baselrn: 1, str: 1, strlrn: 1,   con: 1, conlrn: 1,   int: 1, intlrn: 1}
###
   traitsets:
###
