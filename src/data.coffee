module.exports =
   lists:
      traits: {HardWorker: "researchHardWorker", Intelligent: "researchIntelligent"}
      species: ["human", "goblin"]
   stats: {species: "Species", str: "Strength", con: "Constitution", int: "Intelligence", baselrn: "LM", strlrn: "Str. LM", conlrn: "Con. LM", intlrn: "Int. LM"}
   jobs: ["None", "Woodcutter", "Stonecutter", "Miner", "Researcher"]
   research: {researchHardWorker: [], researchIntelligent: []}
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
         modStr: ["*", 2]
         modCon: ["*", 2]
      Intelligent:
         modInt: ["*", 2]
         modBaseLrn: ["*", 3]
   species: #Species define base stats of a minion.
      human:  {species: "Human", baselrn: 1.5, str: 1, strlrn: 1, con: 1, conlrn: 1, int: 3, intlrn: 1, traits: {}, job: ""}
      goblin: {species: "Goblin", baselrn: 0.5, str: 2, strlrn: 1,   con: 2, conlrn: 1, int: 0.5, intlrn: 1, traits: {}, job: ""}
###
   traitsets:
###
