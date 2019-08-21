--CHECK consistency OF Tags

UPDATE Tags SET sweater = 1
	WHERE cardigan OR hoodie OR tunic OR vest;
UPDATE Tags SET top = 1
	WHERE henley OR tank OR tee;
UPDATE Tags SET wrap = 1
	WHERE cape OR kimono OR poncho OR robe OR shawl OR shrug;
UPDATE Tags SET underwear = 1
	WHERE bodice OR bra OR cami OR panty;	
UPDATE Tags SET sleepwear = 1
	WHERE nighty OR pajamas;
UPDATE Tags SET clothing = 1
	WHERE coat OR sweater OR top OR wrap OR dress OR pants OR shorts OR skirt OR underwear OR sleepwear OR swimwear;
	
UPDATE Tags SET armwear = 1
	WHERE gloves OR mittens OR wristbands;
UPDATE Tags SET bag = 1
	WHERE tote OR purse;
UPDATE Tags SET hat = 1
	WHERE beanie OR beret OR cloche OR earflap OR headband OR hood;
UPDATE Tags SET legwear = 1
	WHERE socks OR stocking OR legwarmers OR booties OR slippers;
UPDATE Tags SET neckwear = 1
	WHERE cowl OR scarf;
UPDATE Tags SET accessory = 1
	WHERE armwear OR bag OR hat OR legwear OR neckwear;
		
UPDATE Tags SET home = 1
	WHERE afghan OR blanket OR block OR cushion OR dishcloth OR quilt OR teacosy OR throw;

UPDATE Tags SET gift = 1
	WHERE animal OR doll OR halloween OR toy OR valentine OR wedding OR xmas;

UPDATE Tags SET child = 1
	WHERE baby OR toddler OR boy OR girl;
UPDATE Tags SET adult = 1
	WHERE man OR woman; 

UPDATE Tags SET colourwork = 1
	WHERE doubleknit OR intarsia OR mosaic OR stranded OR striped OR fairisle;

UPDATE Tags SET techniques = 1
	WHERE bottomup OR edging OR entrelac OR motif OR raglan OR seamless OR stitches OR toeup OR topdown;

UPDATE Tags SET british = 1
	WHERE english OR scottish OR irish OR aran OR guernsey OR shetland OR fairisle OR celtic;
UPDATE Tags SET nordic = 1
	WHERE finnish OR norwegian OR swedish OR estonian OR latvian;