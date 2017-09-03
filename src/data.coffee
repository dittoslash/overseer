module.exports =
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
         modInt: ["/", 4]
      human:


   traitsets:
