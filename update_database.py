## C:\Python36\python.exe

## from DOS
# SUBST S: \\Seagate-NAS\Public

import os
import re


os.chdir("S:\\ebooks\\knit\\patterns\\designers")
r0 = re.compile("^\\.")
r1 = re.compile("^([A-Z])\\.(?= )|( [A-Z])\\.(?= )")


## get names of designers
folders = [f for f in os.listdir(".") if re.match(r0, f) == None]
folders.sort()
author_groups = list()
authors = list()
id = 1
for f in folders:
    names = re.split(" & ", re.sub("_", "-", f))
    names = [re.sub(r1, "\\1\\2", x) for x in names]
    group = list()
    for name in names:
        if not(name in authors):
            authors.append(name)
            group.append(id)
            id += 1
        else:
            group.append(authors.index(name) + 1)
    author_groups.append(group)


author_names = dict(enumerate(authors, 1))
authors.sort()


## get filenames, titles and publications of books
filenames = list()
for folder in folders:
    ff = [f for f in os.listdir(folder) if re.match(r0, f) == None]
    filenames.append(ff)


## define regexes to create book title
f0 = set(re.sub(".*(\\.\\w{3,4})$", "\\1", f) for ff in filenames for f in ff)
suffices = [f for f in f0 if re.match(r0, f) != None]
r2 = re.compile("$|".join(suffices) + "$")
r3 = re.compile("\\s*\\(NEW\\)$")
r4 = re.compile("\\s*\\(c\\)$")
r5 = re.compile("\\s*\\(crochet\\)$")
r6 = re.compile("\\s*\\(k\\)$")
r7 = re.compile("\\s*\\(knit\\)$")
r8 = re.compile("\\s*\\(\\d{4}\\)$")
r9 = re.compile("\\s+|_")
rA = re.compile("^KNIT\\s*-\\s*")
rB = re.compile(" - (\\w*\\d+) - ")
rC = re.compile(" - ")
## contractions
t1 = re.compile("'S\\b")
t2 = re.compile("'T\\b")
t3 = re.compile("\\bI'M\\b")
## Roman numerals
t4 = re.compile("\\bIi\\b")
t5 = re.compile("\\bIii\\b")
t6 = re.compile("\\bIv\\b")
t7 = re.compile("\\bVi\\b")
t8 = re.compile("\\bVii\\b")
t9 = re.compile("\\bViii\\b")
tA = re.compile("\\bIx\\b")
tB = re.compile("\\bXi\\b")
tC = re.compile("\\bXii\\b")
tD = re.compile("\\bXiii\\b")
tE = re.compile("\\bXiv\\b")
tF = re.compile("\\bXv\\b")
## terminal dot
tG = re.compile("\\bVol(\\.)? ")
tH = re.compile("\\bCo(\\.)?\\b")
## other all-caps
tI = re.compile("\\bBt\\b")
tJ = re.compile("\\bAsn\\b")
tK = re.compile("\\bMs")
tL = re.compile("\\bDk\\b")
tM = re.compile("\\bNy\\b")

def mytitle(i):
    j = i.title()
    ## contractions
    j = re.sub(t1, "'s", j)
    j = re.sub(t2, "'t", j)
    j = re.sub(t3, "I'm", j)
    ## Roman numerals
    j = re.sub(t4, "II", j)
    j = re.sub(t5, "III", j)
    j = re.sub(t6, "IV", j)
    j = re.sub(t7, "VI", j)
    j = re.sub(t8, "VII", j)
    j = re.sub(t9, "VIII", j)
    j = re.sub(tA, "IX", j)
    j = re.sub(tB, "XI", j)
    j = re.sub(tC, "XII", j)
    j = re.sub(tD, "XIII", j)
    j = re.sub(tE, "XIV", j)
    j = re.sub(tF, "XV", j)
    ## terminal dot
    j = re.sub(tG, "Vol. ", j)
    j = re.sub(tH, "Co.", j)
    ## Other
    j = re.sub(tI, "BT", j)
    j = re.sub(tJ, "ASN", j)
    j = re.sub(tK, "MS", j)
    j = re.sub(tL, "DK", j)
    j = re.sub(tM, "NY", j)
    return j


def title_collection(filename, author):
    x = re.sub(r2, "", filename)
    x = re.sub(r3, "", x)
    x = re.sub(r4, "", x)
    x = re.sub(r5, "", x)
    x = re.sub(r6, "", x)
    x = re.sub(r7, "", x)
    x = re.sub(r8, "", x)
    x = re.sub(r9, " ", x)
    x = re.sub("\\s*\\(" + author + "\\)", "", x)
    x = re.sub(rA, "", x)
    x = re.sub(rB, " \\1 - ", x)
    x = re.sub("^" + author + "\\s*-\\s*", "", x)
    x = re.sub("\\s*-\\s*" + author + "$", "", x)
    x = re.sub("\\s*by\\s*" + author + "$", "", x)
    x = list(map(mytitle, re.split(rC, x)))
    tc = list()
    tc.append(x[-1]) ## title
    if len(x) == 1:
        tc.append("")
    else:
        tc.append(" - ".join(x[0:-1])) ## collection
    return tc


titles = list()
publications = list()
for i, folder in enumerate(folders):
    ff = filenames[i]
    tc = [title_collection(filename, folder) for filename in ff]
    titles.append(list(map(lambda x: x[0], tc)))
    publications.append(list(map(lambda x: x[1], tc)))


tagnames = list(["knit", "crochet", "loom", "clothing", "coat", "cardigan", "hoodie",
"sweater", "tunic", "vest", "henley", "tank", "tee", "top", "cape", "kimono", "poncho",
"robe", "shawl", "shrug", "wrap", "dress", "pants", "shorts", "skirt", "bodice", "bra",
"cami", "panty", "underwear", "nighty", "pajamas", "sleepwear", "swimwear", "accessory",
"bag", "purse", "tote", "legwear", "socks", "stocking", "legwarmers", "booties", "slippers",
"beanie", "beret", "cap", "cloche", "earflap", "hat", "headband", "hood", "neckwear",
"cowl", "necktie", "scarf", "armwear", "gloves", "mittens", "wristbands", "afghan",
"blanket", "block", "cushion", "dishcloth", "home", "quilt", "teacosy", "throw", "animal",
"doll", "gift", "halloween", "toy", "valentine", "wedding", "xmas", "adult", "baby",
"boy", "child", "girl", "man", "toddler", "woman", "colourwork", "doubleknit", "intarsia",
"mosaic", "stranded", "striped", "bottomup", "edging", "entrelac", "motif", "raglan",
"seamless", "sideways", "stitches", "techniques", "toeup", "topdown", "beaded", "brioche",
"cabled", "chunky", "eyelet", "lace", "lacy", "mesh", "patterned", "reversible", "ribbed",
"smocked", "textured", "folk", "american", "andean", "aran", "british", "celtic", "chinese",
"cowichan", "english", "estonian", "fairisle", "finnish", "french", "german", "guernsey",
"icelandic", "indian", "irish", "italian", "japanese", "latvian", "maltese", "nordic",
"norwegian", "russian", "scottish", "shetland", "slovak", "swedish", "turkish", "world",
"vintage"])


## define regexes to create tags
m0 = re.compile("\\(c\\)") ## Crochet (filename)
m1 = re.compile("\\bCrochet\\b") ## Crochet (title)
m2 = re.compile("\\bLoom\\b")
#
m3 = re.compile(
    "\\bClothing\\b|\\bClothes\\b|\\bWearable[s]?\\b|\\bGarment[s]?\\b|\\bOutfit[s]?\\b|" +
    "\\bFashion[s]?\\b|\\bTrend[sy]?\\b|\\bCouture\\b|\\bCatwalk\\b|\\bBoutique \\b|" +
    "\\bElegant\\b|\\bChic\\b|\\bStylish\\b|\\bFashionable\\b|\\bWardrobe\\b")
#
m4 = re.compile("\\bCoat[s]?\\b|\bOvercoat[s]?\\b|[Jj]acket[s]?\\b") ## not Waistcoat
#
m5 = re.compile("\\bCardi[e]?[s]?\\b|\\bCardigan[s]?\\b") ## Cardigan
m6 = re.compile("\\bHoodie[s]?\\b|\\bHooded Top[s]?\\b") ## not Hood
m7 = re.compile("\\bSweater[s]?|\\bJumper[s]?\\b|\\bPullover[s]?\\b|\\bPull-Over[s]?\\b") ## Sweater
m8 = re.compile("\\bTunic[s]?\\b") ## Tunic
m9 = re.compile("\\bVest[s]?\\b|\bWaistcoat[s]?\\b") ## Vest
#
mA = re.compile("\\bHenley[s]?\\b") ## Henley
mB = re.compile("\\bTank[s]?\\b|\\bTanktop[s]?\\b") ## Tank
mC = re.compile("\\bTee[s]?\\b|\\bT-Shirt[s]?\\b") ## Tee
mD = re.compile("\\bTop[s]?\\b|\\bSleeve[s]?\\b|\\bSleeveless\\b") ## Top
#
mE = re.compile("\\bCape[s]?\\b|\\bCapelet[s]?\\b") ## Cape
mF = re.compile("\\bKimono[s]?\\b") ## Kimono
mG = re.compile("\\bPoncho[s]?\\b") ## Poncho
mH = re.compile("\\bRobe[s]?\\b") ## Robe
mI = re.compile("\\bShawl[s]?\\b|\\bShawlette[s]?\\b|\\bMantle[s]?\\b|\\bMantelet[s]?\\b") ## Shawl
mJ = re.compile("\\bShrug[s]?\\b|\\bBolero\\b|\\bShrowl[s]?\\b") ## Shrug
mK = re.compile("\\bWrap[s]?\\b") ## Wrap
#
mL = re.compile("\\bDress\\b|\\bDresses\\b") ## Dress
mM = re.compile("\\bPant[s]?\\b|(?<!\\bShort )\\bTrousers\\b") ## not Underpants, Panties, Shorts
mN = re.compile("\\bShorts\\b|\\bShort Trousers\\b") ## not Undershorts
mO = re.compile("\\bSkirt[s]?\\b") ## Skirt
#
mP = re.compile("\\bBodice[s]?\\b|\\bCorset[s]?\\b|\\bBasque[s]?\\b|\\bCorselette[s]?\\b") ## Bodice
mQ = re.compile("\\bBras[s]?\\b|\\bBrassi[eè]re[s]?\\b") ## Bra
mR = re.compile("\\bCami[s]?\\b|\\bCamisole[s]?\\b|\\bBabydoll[s]?\\b") ## Cami
mS = re.compile("\\bPanty\\b|\\bPanties\\b|\\bKnickers\\b|\\bUndies\\b|\\bUnderpants\\b|\\bUndershorts\\b") ## Panty
mT = re.compile("\\bUnderwear\\b|\\bLingerie\\b|\\bIntimate[s]?") ## Underwear
#
mU = re.compile("\\bNighty\\b|\\bNightie[s]?\\b|\\bNightgown[s]?\\b") ## Nighty
mV = re.compile("\\bPajama[s]?\\b|\\bPyjama[s]?\\b|\\bPj[s]?\\b|\\bRomper[s]?\\b") ## Pajamas
mW = re.compile("\\bSleepwear\\b|\\bNightwear\\b") ## Sleepwear
#
mX = re.compile("\\bSwimwear\\b|kini[s]?\\b|\\bBeach\\b|\\bBeachwear\\b") ## Swimwear, *kini
#
mY = re.compile("\\bAccessory\\b|\\bAccessories\\b") ## Accessory
#
mZ = re.compile("\\bBag[s]?\\b|\\bHandbag[s]?") ## Bag
mAA = re.compile("\\bPurse[s]?\\b|\\bPouch\\b|\\bPouches\\b") ## Purse
mAB = re.compile("\\bTote[s]?\\b") ## Tote
#
mAC = re.compile("\\bLegwear\\b") ## Legwear
mAD = re.compile("\\bSock[s]?\\b|\\bSocklet[s]?\\b|\\bSox\\b|\\bKnee[- ]High[s]?\\b") ## Socks
mZZ = re.compile("\\bStocking[s]?\\b|\\bThigh[- ]High[s]?\\b") ## Stocking
mAE = re.compile("\\bLegwarmer[s]?\\b|\\bLeg Warmer[s]?\\b") ## Legwarmers
mAF = re.compile("\\bBoot[s]?\\b|\\bBooties\\b|\\bBootees\\b") ## Booties
mAG = re.compile("\\bSlipper[s]?\\b|\\bMules\\b") ## Slippers
#
mAH = re.compile("\\bBeanie[s]?\\b|\\bToque[s]?\\b|\\bBobble Hat[s]?\\b|\\bFez\\b|\\bPillbox\\b") ## Beanie, Toque
mAI = re.compile("\\bB[eé]ret[s]?\\b|\\bTam[s]?\\b") ## Beret
mAJ = re.compile("\\bCap[s]?\\b") ## Cap
mAK = re.compile("\\bCloche[s]?\\b") ## Cloche
mAL = re.compile("\\bEarflap[s]?\\b|\\bEar Flap[s]?\\b|\\bDeerstalker[s]?\\b") ## Earflap
mAM = re.compile("\\bHat[s]?\\b|\\bHead[wg]ear\\b") ## Hat
mAN = re.compile("\\bHeadband[s]?\\b") ## Headband
mAO = re.compile("\\bHood[s]?\\b|\\bSnood[s]?\\b|\\bHooded\\b(?! Top[s]?\\b)") ## not Hoodie
#
mAP = re.compile("\\bNeckwear\\b") ## Neckwear
mAQ = re.compile("\\bCowl[s]?\\b|\\bCollar[s]?\\b|\\bShrowl[s]?\\b") ## Cowl
mAR = re.compile("\\bNecktie[s]?\\b|\\bTie[s]?\\b|\\bCravat[s]?\\b") ## Necktie
mAS = re.compile("\\bScarf\\b|\\bScarves\\b|\\bHeadscarf\\b|\\bHeadscarves\\b|\\bNeck Warmer[s]?\\b") ## Scarf
#
mAT = re.compile("\\bArmwear\\b") ## Armwear
mAU = re.compile("\\bGlove[s]?\\b") ## Gloves
mAV = re.compile("\\bMitten[s]?\\b|\\bMitt[s]?\\b") ## Mittens
mAW = re.compile("\\bWristband[s]?\\b|\\bWristlet[s]?\\b|\\bBracelet[s]?\\b") ## Wristbands
#
mAX = re.compile("\\bAfghan[s]?\\b") ## Afghan
mAY = re.compile("\\bBlanket[s]?\\b|\\bBlankie[s]?\\b") ## Blanket
mAZ = re.compile("\\bBlock[s]?\\b") ## Block
mBA = re.compile("(?<!\\bPin )\\bCushion[s]?\\b|\\bPillow[s]?\\b") ## not Pincushion
mBB = re.compile("\\bDishcloth[s]?\\b|\\bDish Cloth[s]?\\b") ## Dishcloth
mBC = re.compile("\\bHome\\b|\\bPincushion[s]?\\b|\\bPin Cushion[s]?\\b|\\bOrnament[s]?\\b") ## Home
mBD = re.compile("\\bQuilt[s]?\\b") ## Quilt
mBE = re.compile("\\bCo[sz]y\\b|\\bCo[sz]ies\\b|\\bTeaco[sz]y\\b|\\bTeaco[sz]ies\\b") ## Teacosy
mBF = re.compile("\\bThrow[s]?\\b") ## Throw
#
mBG = re.compile(
    "\\bAnimal[s]?\\b|\\bAlligator[s]?\\b|\\bAmigurumi\\b|\\bApe[s]?\\b|\\bArmadillo[s]?\\b|" +
    "\\bBaboon[s]?\\b|\\bBadger[s]?\\b|\\bBambi\\b|\\bBear[s]?\\b|" +
    "\\bBee[s]?\\b|\\bBird[s]?\\b|\\bBirdie[s]?\\b|\\bBirdy\\b|bird[s]?\\b|" +
    "\\bBudgerigar[s]?\\b|\\bBudgie[s]?\\b|\\bBug[s]?\\b|\\bBull[s]?\\b|\\bBunny\\b|\\bBunnies\\b|" +
    "\\bCarp\\b|\\bCat[s]?\\b|cat[s]?\\b|\\bCaterpillar[s]?\\b|" +
    "\\bChick[s]?\\b|\\bChicken[s]?\\b|\\bChimp[s]?\\b|\\bCow[s]?\\b|" +
    "\\bCreature[s]?\\b|\\bCroc[s]?\\b|\\bCrocodile[s]?\\b|\\bCub[s]?\\b|" +
    "\\bDeer\\b|\\bDinosaur[s]?\\b|\\bDog[s]?\\b|\\bDolphin[s]?\\b|\\bDonkey[s]?\\b|" +
    "\\bDragon[s]?\\b|\\bDuck[s]?\\b|\\bDuckling[s]?\\b|" +
    "\\bEgg[s]?\\b|\\bElephant[s]?\\b|" +
    "\\bFarm[s]?\\b|\\bFarmyard\\b|\\bFish\\b|fish\\b|\\bFlamingo\\b|\\bFox\\b|\\bFoxes\\b|\\bFrog[s]?\\b|" +
    "\\bGator[s]?\\b|\\bGiraffe[s]?\\b|\\bGoat[s]?\\b|\\bGoldfish\\b|\\bGorilla[s]?\\b|" +
    "\\bHamster[s]?\\b|\\bHare[s]?\\b|\\bHedgehog[s]?\\b|\\bHen[s]?\\b|" +
    "\\bHippo[s]?\\b|\\bHog[s]?\\b|\\bHorse[s]?\\b|horse[s]?\\b|" +
    "\\bKangaroo[s]?\\b|\\bKitteh\\b|\\bKitten[s]?\\b|\\bKitty|\\bKoala|" +
    "\\bLadybug[s]?\\b|\\bLamb[s]?\\b|\\bLemur[s]?\\b|\\bLion[s]?\\b|\\bLeopard[s]?\\b|" +
    "\\bMice\\b|mice\\b|\\bMochimochi\\b|\\bMonkey[s]?\\b|\\bMonster[s]?\\b|\\bMouse\\b|mouse\\b|\\bMule\\b|" +
    "\\bOctopus\\b|\\bOwl[s]?\\b|" +
    "\\bPanda[s]?\\b|\\bParrot[s]?\\b|\\bPenguin[s]?\\b|\\bPingu\\b|" +
    "\\bPig[s]?\\b|\\bPiggies\\b|\\bPiggy\\b|\\bPiglet[s]?\\b|\\bPigling[s]?\\b|\\bPigeon[s]?\\b|" +
    "\\bPonies\\b|\\bPony\\b|\\bPorcupine[s]?\\b|\\bPup[s]?\\b|\\bPuppies\\b|\\bPuppy\\b|" +
    "\\bRabbit[s]?\\b|\\bRaccoon[s]?\\b|\\bRat[s]?\\b|\\bReindeer[s]?\\b|\\bRhino[s]?\\b|" +
    "\\bShark[s]?\\b|\\bSheep\\b|\\bSnake[s]?\\b|\\bSpider[s]?\\b|" +
    "\\bSquid\\b|\\bSquirrel[s]?\\b|\\bSwan[s]?\\b|\\bSwine\\b|" +
    "\\bTed\\b|\\bTeddies\\b|\\bTeddy\\b|\\bTiger[s]?\\b|\\bToad[s]?\\b|\\bTurtle[s]?\\b|" +
    "\\bUnicorn[s]?\\b|\\bWhale[s]?\\b|\\bWolf\\b|\\bWolves\\b|\\bWomble[s]?\\b|" +
    "\\bZebra[s]?\\b|\\bZoo\\b") ## Animal
mBH = re.compile(
    "\\bDoll[s]?\\b|\\bDolly\\b|\\bDollies\\b" +
    "\\bClown[s]?\\b|\\bDevil[s]?\\b|\\bDwarf\\b|\\bDwarves\\b|\\bFairies\\b|\\bFairy\\b|" +
    "\\bGnome[s]?\\b|\\bImp[s]?\\b|\\bKing[s]?\\b|\\bMermaid[s]?\\b|" +
    "\\bPirate[s]?\\b|\\bPrince[s]?\\b|\\bPrincess\\b|\\bPrincesses\\b|\\bQueen[s]?\\b|" +
    "\\bRobot[s]?\\b|\\bSailor[s]?\\b|\\bSanta\\b|\\bSoldier[s]?\\b|\\bTroll[s]?\\b") ## Doll
mBI = re.compile("\\bGift[s]?\\b|\\bPresent[s]?\\b|\\bBirthday[s]?\\b|\\bAnniversary\\b|\\bTo Give\\b") ## Gift
mBJ = re.compile("\\bHallowe[']en\\b") ## Halloween
mBK = re.compile("\\bToy[s]?\\b") ## Toy
mBL = re.compile("\\bValentine") ## Valentine
mBM = re.compile("\\bWedding\\b|\\bBridal\\b|\\bBride|\\bGroom") ## Wedding
mBN = re.compile(
    "\\bChristmas\\b|\\bXmas\\b|\\bYule\\b|\\bYuletide\\b|\\bFestive\\b|" +
    "\\bSanta\\b|\\bSnowm[ae]n\\b|\\bReindeer\\b") ## Xmas
#
mBO = re.compile("\\bAdult[s]?\\b") ## Adult
mBP = re.compile("\\bBaby\\b|\\Babies\\b|\\bInfant[s]?\\b|\\bNewborn[s]?\\b|\\bTot[s]?\\b|\\bNursery\\b") ## Baby
mBQ = re.compile("\\bBoy[s]?\\b") ## Boy
mBR = re.compile("\\bChild\\b|\\bChildren\\b|\\bKid[s]?\\b|\\bT[w]?een\\b|\\bT[w]?eenager[s]?\\b") ## Child
mBS = re.compile("\\bGirl[s]?\\b") ## Girl
mBT = re.compile("\\bM[ae]n\\b|\\bFather[s]?\\b|\\bDad[s]?\\b|\\bMenswear\\b") ## Man
mBU = re.compile("\\bToddler[s]?\\b") ## Toddler
mBV = re.compile("\\bWom[ae]n\\b|\\bMother[s]?\\b|\\bMum[s]?\\b|\\bFeminine\\b") ## Woman
#
mBW = re.compile("\\bColo[u]?rwork\\b|\\bColo[u]?r Knit") ## Colourwork
mBX = re.compile("\\bDoubleknit |\\bDouble Knit") ## Doubleknit
mBY = re.compile("\\bIntarsia\\b") ## Intarsia
mBZ = re.compile("\\bMosaic[s]?\\b") ## Mosaic
mCA = re.compile("\\bStranded\\b|\\bFair Isle\\b") ## Stranded
mCD = re.compile("\\bStripe[dsy]?\\b|\\bStripy\\b") ## Striped
#
mCE = re.compile("\\bBottom[- ]Up\\b") ## Bottom Up
mCF = re.compile("\\bEdging[s]?\\b") ## Edging
mCG = re.compile("\\bEntrelac\\b") ## Entrelac
mCH = re.compile("\\bMotif[s]?\\b|\\bApplique[s]?\\b") ## Motif
mCI = re.compile("\\bRaglan\\b") ## Raglan
mCJ = re.compile("\\bSeamless\\b|\\bCircular Knit") ## Seamless
mCK = re.compile("\\bSideways\\b") ## Sideways
mCL = re.compile("\\bStitches\\b") ## Stitches
mCM = re.compile("\\bTechnique[s]?\\b|\\bTechnology\\b|\\bTechnologies\\b") ## Techniques
mCN = re.compile("\\bToe[- ]Up\\b") ## Toe Up
mCO = re.compile("\\bTop[- ]Down\\b") ## Top Down
#
mCP = re.compile("\\bBeaded\\b|\\bBeading\\b|\\bBead[s]?\\b") ## Beaded
mCQ = re.compile("\\bBrioche\\b") ## Brioche
mCR = re.compile("\\bCable[sd]?\\b|\\bCabling\\b") ## Cabled
mCS = re.compile("\\bChunky\\b|\\bThick\\b") ## Chunky
mCT = re.compile("\\bEye[s]?\\b|\\bEyelet[s]?\\b") ## Eyelets
mCU = re.compile("\\bLace\\b") ## Lace
mCV = re.compile("\\bLacy\\b") ## Lacy
mCW = re.compile("\\bMesh\\b|\\bGauz[ey]\\b") ## Mesh
mCX = re.compile("\\bPattern[s]?\\b|\\bPatterned\\b") ## Patterned
mCY = re.compile("\\bReversible\\b") ## Reversible
mCZ = re.compile("\\bRib[s]?\\b|\\bRibbed\\b|\\bRibbing\\b") ## Ribbed
mDA = re.compile("\\bSmocked\\b|\\bSmocking\\b") ## Smocked
mDB = re.compile("\\bTexture[sd]?\\b") ## Textured
#
mDC = re.compile("\\bFolk\\b|\\bEthnic\\b|\\bTraditional\\b") ## Folk
mDE = re.compile("\\bAmerica[n]?\\b")
mDF = re.compile("\\bAndean\\b|\\bAndes\\b|\\bPeru\\b|\\bPeruvian\\b|\\bBolivia[n]?|\\bInca\\b")
mDG = re.compile("\\bAran\\b")
mDH = re.compile("\\bBritish\\b|\\bBritain\\b")
mDI = re.compile("\\bCeltic\\b")
mDJ = re.compile("\\bChinese\\b|\\bChina\\b")
mDK = re.compile("\\bCowichan\\b")
mDL = re.compile("\\bEnglish\\b|\\bEngland\\b")
mDM = re.compile("\\bEstonia[n]?\\b")
mDN = re.compile("\\bFairisle\\b|\\bFair Isle\\b")
mDO = re.compile("\\bFinnish\\b|\\bFinland\\b")
mDP = re.compile("\\bFrench\\b|\\bFrance\\b")
mDQ = re.compile("\\bGerman[y]?\\b")
mDR = re.compile("\\bGuernsey\\b|\\bGansey\\b")
mDS = re.compile("\\bIcelandic\\b|\\bIceland\\b|\\bLopi\\b")
mDT = re.compile("\\bIndia[n]?\\b")
mDU = re.compile("\\bIrish\\b|\\bIreland\\b")
mDV = re.compile("\\bItalian\\b|\\bItaly\\b|\\bTuscan[y]?\\b")
mDW = re.compile("\\bJapanese\\b|\\bJapan\\b")
mDX = re.compile("\\bLatvia[n]?\\b")
mDY = re.compile("\\bMaltese\\b|\\bMalta\\b")
mDZ = re.compile("\\bNordic\\b|\\bNorse\\b|\\bViking\\b|\\bScandinavian\\b")
mEA = re.compile("\\bNorwegian\\b|\\bNorway\\b")
mEB = re.compile("\\bRussia[n]?\\b")
mEC = re.compile("\\bScottish\\b|\\bScotland\\b|\\bScots\\b|\\bHebrides\\b|\\bHebridean\\b")
mED = re.compile("\\bShetland\\b|\\bOrkney\\b")
mEE = re.compile("\\bSlovak\\b|\\bSlovakia\\b")
mEF = re.compile("\\bSwedish\\b|\\bSweden\\b")
mEG = re.compile("\\bTurkish\\b|\\bTurkey\\b|\\bAnatolia[n]?\\b")
mEH = re.compile("\\bWorld\\b|\\bGlobal\\b")
mEI = re.compile("\\bVintage\\b|\\bReproduction\\b")


def tag(filename, title, publication):
    tags = list()
    #
    knit        = 1
    crochet     = re.search(m0, filename) != None or re.search(m1, title) != None
    loom        = re.search(m2, title) != None or re.search(m2, publication) != None
    #
    clothing    = re.search(m3, title) != None or re.search(m3, publication) != None
    #
    coat        = re.search(m4, title) != None
    cardigan    = re.search(m5, title) != None
    hoodie      = re.search(m6, title) != None
    sweater     = re.search(m7, title) != None or re.search(m7, publication) != None
    tunic       = re.search(m8, title) != None
    vest        = re.search(m9, title) != None
    #
    henley      = re.search(mA, title) != None
    tank        = re.search(mB, title) != None
    tee         = re.search(mC, title) != None
    top         = re.search(mD, title) != None
    #
    cape        = re.search(mE, title) != None
    kimono      = re.search(mF, title) != None
    poncho      = re.search(mG, title) != None
    robe        = re.search(mH, title) != None
    shawl       = re.search(mI, title) != None
    shrug       = re.search(mJ, title) != None
    wrap        = re.search(mK, title) != None
    #
    dress       = re.search(mL, title) != None
    pants       = re.search(mM, title) != None
    shorts      = re.search(mN, title) != None
    skirt       = re.search(mO, title) != None
    #
    bodice      = re.search(mP, title) != None
    bra         = re.search(mQ, title) != None
    cami        = re.search(mR, title) != None
    panty       = re.search(mS, title) != None
    underwear   = re.search(mT, title) != None or re.search(mT, publication) != None
    #
    nighty      = re.search(mU, title) != None
    pajamas     = re.search(mV, title) != None
    sleepwear   = re.search(mW, title) != None or re.search(mW, publication) != None
    #
    swimwear    = re.search(mX, title) != None or re.search(mX, publication) != None
    #
    accessory   = re.search(mY, title) != None or re.search(mY, publication) != None
    #
    bag         = re.search(mZ, title) != None
    purse       = re.search(mAA, title) != None
    tote        = re.search(mAB, title) != None
    #
    legwear     = re.search(mAC, title) != None
    socks       = re.search(mAD, title) != None
    stocking    = re.search(mZZ, title) != None
    legwarmers  = re.search(mAE, title) != None
    booties     = re.search(mAF, title) != None
    slippers    = re.search(mAG, title) != None
    #
    beanie      = re.search(mAH, title) != None
    beret       = re.search(mAI, title) != None
    cap         = re.search(mAJ, title) != None
    cloche      = re.search(mAK, title) != None
    earflap     = re.search(mAL, title) != None
    hat         = re.search(mAM, title) != None
    headband    = re.search(mAN, title) != None
    hood        = re.search(mAO, title) != None
    #
    neckwear    = re.search(mAP, title) != None
    cowl        = re.search(mAQ, title) != None
    necktie     = re.search(mAR, title) != None
    scarf       = re.search(mAS, title) != None
    #
    armwear     = re.search(mAT, title) != None
    gloves      = re.search(mAU, title) != None
    mittens     = re.search(mAV, title) != None
    wristbands  = re.search(mAW, title) != None
    #
    afghan      = re.search(mAX, title) != None
    blanket     = re.search(mAY, title) != None
    block       = re.search(mAZ, title) != None
    cushion     = re.search(mBA, title) != None
    dishcloth   = re.search(mBB, title) != None
    home        = re.search(mBC, title) != None
    quilt       = re.search(mBD, title) != None
    teacosy     = re.search(mBE, title) != None
    throw       = re.search(mBF, title) != None
    #
    animal      = re.search(mBG, title) != None or re.search(mBG, publication) != None
    doll        = re.search(mBH, title) != None or re.search(mBH, publication) != None
    gift        = re.search(mBI, title) != None or re.search(mBI, publication) != None
    halloween   = re.search(mBJ, title) != None or re.search(mBJ, publication) != None
    toy         = re.search(mBK, title) != None or re.search(mBK, publication) != None
    valentine   = re.search(mBL, title) != None or re.search(mBL, publication) != None
    wedding     = re.search(mBM, title) != None or re.search(mBM, publication) != None
    xmas        = re.search(mBN, title) != None or re.search(mBN, publication) != None
    #
    adult       = re.search(mBO, title) != None or re.search(mBO, publication) != None
    baby        = re.search(mBP, title) != None or re.search(mBP, publication) != None
    boy         = re.search(mBQ, title) != None or re.search(mBQ, publication) != None
    child       = re.search(mBR, title) != None or re.search(mBR, publication) != None
    girl        = re.search(mBS, title) != None or re.search(mBS, publication) != None
    man         = re.search(mBT, title) != None or re.search(mBT, publication) != None
    toddler     = re.search(mBU, title) != None or re.search(mBU, publication) != None
    woman       = re.search(mBV, title) != None or re.search(mBV, publication) != None
    #
    colourwork  = re.search(mBW, title) != None
    doubleknit  = re.search(mBX, title) != None
    intarsia    = re.search(mBY, title) != None
    mosaic      = re.search(mBZ, title) != None
    stranded    = re.search(mCA, title) != None
    striped     = re.search(mCD, title) != None
    #
    bottomup    = re.search(mCE, title) != None
    edging      = re.search(mCF, title) != None
    entrelac    = re.search(mCG, title) != None
    motif       = re.search(mCH, title) != None
    raglan      = re.search(mCI, title) != None
    seamless    = re.search(mCJ, title) != None
    sideways    = re.search(mCK, title) != None
    stitches    = re.search(mCL, title) != None
    techniques  = re.search(mCM, title) != None
    toeup       = re.search(mCN, title) != None
    topdown     = re.search(mCO, title) != None
    #
    beaded      = re.search(mCP, title) != None
    brioche     = re.search(mCQ, title) != None
    cabled      = re.search(mCR, title) != None
    chunky      = re.search(mCS, title) != None
    eyelet      = re.search(mCT, title) != None
    lace        = re.search(mCU, title) != None
    lacy        = re.search(mCV, title) != None
    mesh        = re.search(mCW, title) != None
    patterned   = re.search(mCX, title) != None
    reversible  = re.search(mCY, title) != None
    ribbed      = re.search(mCZ, title) != None
    smocked     = re.search(mDA, title) != None
    textured    = re.search(mDB, title) != None
    #
    folk        = re.search(mDC, title) != None
    american    = re.search(mDE, title) != None
    andean      = re.search(mDF, title) != None
    aran        = re.search(mDG, title) != None
    british     = re.search(mDH, title) != None
    celtic      = re.search(mDI, title) != None
    chinese     = re.search(mDJ, title) != None
    cowichan    = re.search(mDK, title) != None
    english     = re.search(mDL, title) != None
    estonian    = re.search(mDM, title) != None
    fairisle    = re.search(mDN, title) != None
    finnish     = re.search(mDO, title) != None
    french      = re.search(mDP, title) != None
    german      = re.search(mDQ, title) != None
    guernsey    = re.search(mDR, title) != None
    icelandic   = re.search(mDS, title) != None
    indian      = re.search(mDT, title) != None
    irish       = re.search(mDU, title) != None
    italian     = re.search(mDV, title) != None
    japanese    = re.search(mDW, title) != None
    latvian     = re.search(mDX, title) != None
    maltese     = re.search(mDY, title) != None
    nordic      = re.search(mDZ, title) != None
    norwegian   = re.search(mEA, title) != None
    russian     = re.search(mEB, title) != None
    scottish    = re.search(mEC, title) != None
    shetland    = re.search(mED, title) != None
    slovak      = re.search(mEE, title) != None
    swedish     = re.search(mEF, title) != None
    turkish     = re.search(mEG, title) != None
    world       = re.search(mEH, title) != None
    vintage     = re.search(mEI, title) != None
    tags = [knit, crochet, loom, clothing, coat, cardigan, hoodie, sweater, tunic,
vest, henley, tank, tee, top, cape, kimono, poncho, robe, shawl, shrug, wrap, dress,
pants, shorts, skirt, bodice, bra, cami, panty, underwear, nighty, pajamas, sleepwear,
swimwear, accessory, bag, purse, tote, legwear, socks, stocking, legwarmers, booties,
slippers, beanie, beret, cap, cloche, earflap, hat, headband, hood, neckwear, cowl,
necktie, scarf, armwear, gloves, mittens, wristbands, afghan, blanket, block, cushion,
dishcloth, home, quilt, teacosy, throw, animal, doll, gift, halloween, toy, valentine,
wedding, xmas, adult, baby, boy, child, girl, man, toddler, woman, colourwork, doubleknit,
intarsia, mosaic, stranded, striped, bottomup, edging, entrelac, motif, raglan, seamless,
sideways, stitches, techniques, toeup, topdown, beaded, brioche, cabled, chunky, eyelet,
lace, lacy, mesh, patterned, reversible, ribbed, smocked, textured, folk, american,
andean, aran, british, celtic, chinese, cowichan, english, estonian, fairisle, finnish,
french, german, guernsey, icelandic, indian, irish, italian, japanese, latvian, maltese,
nordic, norwegian, russian, scottish, shetland, slovak, swedish, turkish, world, vintage]
    return tags


tags = list()
for i, ff in enumerate(filenames):
    for j, title in enumerate(titles[i]):
        tags.append(list(map(int,tag(filename, title, publications[i][j]))))


## output SQL scripts to create and populate new database tables
os.chdir("C:\\Users\\Tom\\Documents\\books\\knit\\db")
with open("authors_new.sql", "w") as AUTHORS:
    AUTHORS.write(
"""
CREATE TABLE Authors_new(
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    ravelry_username TEXT DEFAULT NULL,
    ravelry_designername TEXT DEFAULT NULL,
    website TEXT DEFAULT NULL);
INSERT INTO Authors_new VALUES
""")
    for id, author in enumerate(authors, 1):
        AUTHORS.write(f"({id},\"{author}\",'','','')")
        AUTHORS.write(";\n") if id == len(authors) else AUTHORS.write(",\n")


with open("books_new.sql", "w") as BOOKS:
    BOOKS.write(
"""
CREATE TABLE Books_new(
    id INTEGER NOT NULL PRIMARY KEY,
    file_name TEXT NOT NULL UNIQUE, 
    authors_names TEXT NOT NULL,
    title TEXT NOT NULL,
    publication TEXT DEFAULT NULL,
    ravelry_source TEXT DEFAULT NULL,
    ravelry_pattern TEXT DEFAULT NULL);
CREATE INDEX Idx_Books_new ON Books_new(authors_names, title);
INSERT INTO Books_new VALUES
""")
    id = 1
    for i, folder in enumerate(folders):
        authors_names = " & ".join([author_names[id] for id in author_groups[i]])
        for j, title in enumerate(titles[i]):
            filename = "knit/patterns/designers/" + folder + "/" + filenames[i][j]
            publication = publications[i][j]
            BOOKS.write(f"({id},\"{filename}\",\"{authors_names}\",\"{title}\",\"{publication}\",'','')")
            if i == len(folders) - 1 and j == len(titles[i]) - 1:
                BOOKS.write(";\n")
            else:
                BOOKS.write(",\n")
            id += 1


with open("books_authors_new.sql", "w") as BOOKS_AUTHORS:
    BOOKS_AUTHORS.write(
"""
CREATE TABLE Book_Authors_new(
    author_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL, 
    FOREIGN KEY(author_id) REFERENCES Authors_new(id),
    FOREIGN KEY(book_id) REFERENCES Books_new(id));
INSERT INTO Book_Authors_new VALUES
""")
    book_id = 1
    for i, author_group in enumerate(author_groups):
        author_ids = [authors.index(author_names[id]) + 1 for id in author_group]
        author_ids.sort()
        for j in range(len(filenames[i])):
            for author_id in author_ids:
                BOOKS_AUTHORS.write(f"({author_id},{book_id})")
                if i == len(author_groups) - 1 and j == len(filenames[i]) - 1:
                    BOOKS_AUTHORS.write(";\n")
                else:
                    BOOKS_AUTHORS.write(",\n")
            book_id += 1


with open("book_tags_new.sql", "w") as BOOKS_TAGS:
    BOOKS_TAGS.write(
"""
CREATE TABLE Book_Tags_new(
    id INTEGER NOT NULL PRIMARY KEY,
    book_id INTEGER NOT NULL,
    tag TEXT NOT NULL, 
    FOREIGN KEY(book_id) REFERENCES Books_new(id));
CREATE INDEX Idx_Book_Tags_new ON Book_Tags_new(book_id, tag);
INSERT INTO Book_Tags_new VALUES
""")
    id = 1
    for t in range(1, len(tagnames)):
        tagname = tagnames[t]
        for book_id, tt in enumerate(tags, 1):
            if tt[t]:
                if id > 1:
                    BOOKS_TAGS.write(",\n")
                BOOKS_TAGS.write(f"({id},{book_id},\"{tagname}\")")
                id += 1
            if t == len(tagnames) - 1 and book_id == len(tags):
                BOOKS_TAGS.write(";\n")



with open("tags_new.sql", "w") as TAGS:
    TAGS.write(
"""
CREATE TABLE Tags_new(
    book_id INTEGER NOT NULL PRIMARY KEY, 
    knit BIT DEFAULT 1, 
    crochet BIT DEFAULT 0, 
    loom BIT DEFAULT 0, 
    clothing BIT DEFAULT 0, 
    coat BIT DEFAULT 0, 
    cardigan BIT DEFAULT 0, 
    hoodie BIT DEFAULT 0, 
    sweater BIT DEFAULT 0, 
    tunic BIT DEFAULT 0, 
    vest BIT DEFAULT 0, 
    henley BIT DEFAULT 0, 
    tank BIT DEFAULT 0, 
    tee BIT DEFAULT 0, 
    top BIT DEFAULT 0, 
    cape BIT DEFAULT 0, 
    kimono BIT DEFAULT 0, 
    poncho BIT DEFAULT 0, 
    robe BIT DEFAULT 0, 
    shawl BIT DEFAULT 0, 
    shrug BIT DEFAULT 0, 
    wrap BIT DEFAULT 0, 
    dress BIT DEFAULT 0, 
    pants BIT DEFAULT 0, 
    shorts BIT DEFAULT 0, 
    skirt BIT DEFAULT 0, 
    bodice BIT DEFAULT 0, 
    bra BIT DEFAULT 0, 
    cami BIT DEFAULT 0, 
    panty BIT DEFAULT 0, 
    underwear BIT DEFAULT 0, 
    nighty BIT DEFAULT 0, 
    pajamas BIT DEFAULT 0, 
    sleepwear BIT DEFAULT 0, 
    swimwear BIT DEFAULT 0, 
    accessory BIT DEFAULT 0, 
    bag BIT DEFAULT 0, 
    purse BIT DEFAULT 0, 
    tote BIT DEFAULT 0, 
    legwear BIT DEFAULT 0, 
    socks BIT DEFAULT 0, 
    stocking BIT DEFAULT 0, 
    legwarmers BIT DEFAULT 0, 
    booties BIT DEFAULT 0, 
    slippers BIT DEFAULT 0, 
    beanie BIT DEFAULT 0, 
    beret BIT DEFAULT 0, 
    cap BIT DEFAULT 0, 
    cloche BIT DEFAULT 0, 
    earflap BIT DEFAULT 0, 
    hat BIT DEFAULT 0, 
    headband BIT DEFAULT 0, 
    hood BIT DEFAULT 0, 
    neckwear BIT DEFAULT 0, 
    cowl BIT DEFAULT 0, 
    necktie BIT DEFAULT 0, 
    scarf BIT DEFAULT 0, 
    armwear BIT DEFAULT 0, 
    gloves BIT DEFAULT 0, 
    mittens BIT DEFAULT 0, 
    wristbands BIT DEFAULT 0, 
    afghan BIT DEFAULT 0, 
    blanket BIT DEFAULT 0, 
    block BIT DEFAULT 0, 
    cushion BIT DEFAULT 0, 
    dishcloth BIT DEFAULT 0, 
    home BIT DEFAULT 0, 
    quilt BIT DEFAULT 0, 
    teacosy BIT DEFAULT 0, 
    throw BIT DEFAULT 0, 
    animal BIT DEFAULT 0, 
    doll BIT DEFAULT 0, 
    gift BIT DEFAULT 0, 
    halloween BIT DEFAULT 0, 
    toy BIT DEFAULT 0, 
    valentine BIT DEFAULT 0, 
    wedding BIT DEFAULT 0, 
    xmas BIT DEFAULT 0, 
    adult BIT DEFAULT 0, 
    baby BIT DEFAULT 0, 
    boy BIT DEFAULT 0, 
    child BIT DEFAULT 0, 
    girl BIT DEFAULT 0, 
    man BIT DEFAULT 0, 
    toddler BIT DEFAULT 0, 
    woman BIT DEFAULT 0, 
    colourwork BIT DEFAULT 0, 
    doubleknit BIT DEFAULT 0, 
    intarsia BIT DEFAULT 0, 
    mosaic BIT DEFAULT 0, 
    stranded BIT DEFAULT 0, 
    striped BIT DEFAULT 0, 
    bottomup BIT DEFAULT 0, 
    edging BIT DEFAULT 0, 
    entrelac BIT DEFAULT 0, 
    motif BIT DEFAULT 0, 
    raglan BIT DEFAULT 0, 
    seamless BIT DEFAULT 0, 
    sideways BIT DEFAULT 0, 
    stitches BIT DEFAULT 0, 
    techniques BIT DEFAULT 0, 
    toeup BIT DEFAULT 0, 
    topdown BIT DEFAULT 0, 
    beaded BIT DEFAULT 0, 
    brioche BIT DEFAULT 0, 
    cabled BIT DEFAULT 0, 
    chunky BIT DEFAULT 0, 
    eyelet BIT DEFAULT 0, 
    lace BIT DEFAULT 0, 
    lacy BIT DEFAULT 0, 
    mesh BIT DEFAULT 0,
    patterned BIT DEFAULT 0, 
    reversible BIT DEFAULT 0,
    ribbed BIT DEFAULT 0,
    smocked BIT DEFAULT 0, 
    textured BIT DEFAULT 0,
    folk BIT DEFAULT 0,
    american BIT DEFAULT 0, 
    andean BIT DEFAULT 0,
    aran BIT DEFAULT 0, 
    british BIT DEFAULT 0, 
    celtic BIT DEFAULT 0, 
    chinese BIT DEFAULT 0,
    cowichan BIT DEFAULT 0,
    english BIT DEFAULT 0, 
    estonian BIT DEFAULT 0, 
    fairisle BIT DEFAULT 0, 
    finnish BIT DEFAULT 0, 
    french BIT DEFAULT 0, 
    german BIT DEFAULT 0,
    guernsey BIT DEFAULT 0,
    icelandic BIT DEFAULT 0,
    indian BIT DEFAULT 0,
    irish BIT DEFAULT 0, 
    italian BIT DEFAULT 0, 
    japanese BIT DEFAULT 0, 
    latvian BIT DEFAULT 0,
    maltese BIT DEFAULT 0,
    nordic BIT DEFAULT 0, 
    norwegian BIT DEFAULT 0,
    russian BIT DEFAULT 0, 
    scottish BIT DEFAULT 0, 
    shetland BIT DEFAULT 0,
    slovak BIT DEFAULT 0,
    swedish BIT DEFAULT 0,
    turkish BIT DEFAULT 0, 
    world BIT DEFAULT 0, 
    vintage BIT DEFAULT 0, 
    FOREIGN KEY(book_id) REFERENCES Books_new(id));
CREATE INDEX Idx_Tags_new ON Tags_new(book_id);
INSERT INTO Tags_new VALUES
""")
    for book_id, tt in enumerate(tags, 1):
        TAGS.write(f"({book_id}," + ",".join(list(map(str, tt))) + ")")
        TAGS.write(";\n") if book_id == len(tags) else TAGS.write(",\n")



with open("update_book_tags.sql", "w") as TMP:
    TMP.write(
"""
--remake Book_Tags from Tags

--first run consolidate_tags.sql

--view columns in Tags
-- SELECT name FROM PRAGMA table_info(Tags

--drop existing Book_Tags_new table
DROP TABLE IF EXISTS Book_Tags_new;

--create Book_Tags_new table
CREATE TABLE Book_Tags_new(
    id INTEGER NOT NULL PRIMARY KEY,
    book_id INTEGER NOT NULL,
    tag TEXT NOT NULL, 
    FOREIGN KEY(book_id) REFERENCES Books_new(id));
CREATE INDEX Idx_Book_Tags_new ON Book_Tags_new(book_id, tag);

--update each tag in turn
INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) FROM Tags AS t2 WHERE crochet = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE crochet = 1 ORDER BY book_id), 
    (SELECT "crochet" AS tag);
""")
    for tag in tagnames[2:]:
        TMP.write(
f"""
INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE {tag} = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE {tag} = 1 ORDER BY book_id), 
    (SELECT "{tag}" AS tag);
""")


