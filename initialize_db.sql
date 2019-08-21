--create main tables
CREATE TABLE Authors(
	id INTEGER NOT NULL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE,
	ravelry_username TEXT DEFAULT NULL,
	ravelry_designername TEXT DEFAULT NULL,
	website TEXT DEFAULT NULL);

CREATE TABLE Books(
	id INTEGER NOT NULL PRIMARY KEY,
	file_name TEXT NOT NULL UNIQUE, 
	authors_names TEXT NOT NULL,
	title TEXT NOT NULL, publication TEXT DEFAULT NULL,
	ravelry_source TEXT, ravelry_pattern TEXT DEFAULT NULL);
CREATE INDEX Idx_Books ON Books(authors_names, title);

CREATE TABLE Book_Authors(
	author_id INTEGER NOT NULL,
	book_id INTEGER NOT NULL, 
	FOREIGN KEY(author_id) REFERENCES Authors(id),
	FOREIGN KEY(book_id) REFERENCES Books(id));
	
CREATE TABLE Book_Tags(
	id INTEGER NOT NULL PRIMARY KEY,
	book_id INTEGER NOT NULL,
	tag TEXT NOT NULL, 
	FOREIGN KEY(book_id) REFERENCES Books(id));
CREATE INDEX Idx_Book_Tags ON Book_Tags(book_id, tag);

CREATE TABLE Tags(
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
	FOREIGN KEY(book_id) REFERENCES Books(id));     
CREATE INDEX Idx_Tags ON Tags(book_id);
INSERT INTO Tags(book_id) SELECT id FROM Books;



--create views

--authors without books
DROP VIEW IF EXISTS Authors_no_Books;

CREATE VIEW Authors_no_Books 
	AS SELECT id, name 
	FROM Authors LEFT JOIN Book_Authors ON id=author_id 
	WHERE author_id IS NULL ORDER BY id;

--books without authors
DROP VIEW IF EXISTS Books_no_Authors;

CREATE VIEW Books_no_Authors 
	AS SELECT id, authors_names, title 
	FROM Books LEFT JOIN Book_Authors ON id=book_id 
	WHERE book_id IS NULL ORDER BY id;

--tags without books
DROP VIEW IF EXISTS Tags_no_Books;

CREATE VIEW Tags_no_Books AS SELECT book_id, title 
	FROM Tags LEFT JOIN Books ON id=book_id 
	WHERE id IS NULL ORDER BY book_id;

--books without tags
DROP VIEW IF EXISTS Books_no_Tags;

CREATE VIEW Books_no_Tags AS SELECT id, title 
	FROM Books LEFT JOIN Tags ON id=book_id 
	WHERE book_id IS NULL ORDER BY id;

--duplicate authors
DROP VIEW IF EXISTS Authors_dup;

CREATE VIEW Authors_dup AS SELECT id, name, COUNT(name) 
	FROM Authors GROUP BY name HAVING (COUNT(name) > 1)
	ORDER BY id;