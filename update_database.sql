--first run update_database.py
--update_database.py generates the following SQL scripts:
--		authors_new.sql
--		books_new.sql
--		book_authors_new.sql
--		tags_new.sql
--these scripts create the following database tables, respectively:
--		Authors_new
--		Books_new
--		Book_authors_new
--		Tags_new


--next, copy across manually entered data from pre-existing tables:

--check that we still have all existing authors (should be empty):
SELECT * FROM Authors LEFT JOIN Authors_new ON Authors_new.name = Authors.name WHERE Authors_new.name IS NULL;
--check new authors for variant spellings of existing authors' names:
SELECT * FROM Authors_new LEFT JOIN Authors ON Authors_new.name = Authors.name WHERE Authors.name IS NULL;
--view matching authors:
SELECT * FROM Authors_new JOIN Authors ON Authors_new.name = Authors.name;
--update `Authors_new` with manually-entered data from `Authors`:
REPLACE INTO Authors_new 
SELECT Authors_new.id, Authors_new.name, 
	Authors.ravelry_username, Authors.ravelry_designername, Authors.website 
FROM Authors_new JOIN Authors ON Authors_new.name = Authors.name;

--check that we still have all existing books (should be empty):
SELECT * FROM Books LEFT JOIN Books_new ON Books_new.file_name = Books.file_name WHERE Books_new.file_name IS NULL;
--check new books for variant spellings of existing books' names:
SELECT * FROM Books_new LEFT JOIN Books ON Books_new.file_name = Books.file_name WHERE Books.file_name IS NULL;
--view matching books:
SELECT * FROM Books_new INNER JOIN Books ON Books_new.file_name = Books.file_name;
--update `Books_new` with manually-entered data from `Books`:
REPLACE INTO Books_new 
SELECT Books_new.id, Books_new.file_name, Books_new.authors_names, Books_new.title, Books_new.publication, 
	Books.ravelry_source, Books.ravelry_pattern 
FROM Books_new JOIN Books ON Books_new.file_name = Books.file_name;


--BE CAREFUL !
--delete the data from the pre-existing tables and replace with new data:
DELETE FROM Authors;
INSERT INTO Authors SELECT * FROM Authors_new;

DELETE FROM Books;
INSERT INTO Books SELECT * FROM Books_new;

DELETE FROM Book_Authors;
INSERT INTO Book_Authors SELECT * FROM Book_Authors_new;

DELETE FROM Tags;
INSERT INTO Tags SELECT * FROM Tags_new;

DELETE FROM Book_Tags;
INSERT INTO Book_Tags SELECT * FROM Book_Tags_new;


--BE CAREFUL !
--finally, delete the new tables:
DROP TABLE Authors_new;
DROP TABLE Books_new;
DROP TABLE Book_Authors_new;
DROP TABLE Tags_new;
DROP TABLE Book_Tags_new;



--now run consolidate_tags.sql


--remove duplicate authors
DELETE FROM Authors_new WHERE id IN 
	(SELECT Authors_new.id FROM Authors_new JOIN Authors ON Authors_new.name = Authors.name);
	
--remove duplicate book_tags
DELETE FROM Book_Tags_new WHERE book_id IN 
	(SELECT Books_new.id AS book_id FROM Books_new JOIN Books ON Books_new.authors_names = Books.authors_names AND Books_new.title = Books.title);
	
--remove duplicate tags
DELETE FROM Tags_new WHERE book_id IN 
	(SELECT Books_new.id AS book_id FROM Books_new JOIN Books ON Books_new.authors_names = Books.authors_names AND Books_new.title = Books.title);
	
--remove duplicate books
DELETE FROM Books_new WHERE id IN 
	(SELECT Books_new.id FROM Books_new JOIN Books ON Books_new.authors_names = Books.authors_names AND Books_new.title = Books.title);

	
	
--view new books without tags
SELECT Books_new.id, title, tag FROM Books_new LEFT JOIN Book_Tags_new ON Books_new.id = Book_Tags_new.book_id 
	WHERE book_id IS NULL 
	ORDER BY title;
	
--check tags and book_tags
SELECT * FROM Tags_new JOIN Book_Tags_new JOIN Books_new ON Tags_new.book_id = Book_Tags_new.book_id AND Tags_new.book_id = Books_new.id ORDER BY Tags_new.book_id;



	
--check for authors without books
SELECT id, name FROM Authors LEFT JOIN Book_Authors ON id=author_id WHERE author_id IS NULL;

--check for books without authors
SELECT author_id, name FROM Book_Authors LEFT JOIN Authors ON id=author_id WHERE id IS NULL;

--check for tags without books
SELECT book_id, title FROM Tags LEFT JOIN Books ON id=book_id WHERE id IS NULL;

--check for books without tags
SELECT id, title FROM Books LEFT JOIN Tags ON id=book_id WHERE book_id IS NULL;



--add new entries to Authors
INSERT INTO Authors SELECT NULL, name, NULL, NULL, NULL, original_name FROM Authors_new;

--add new entries to Books
INSERT INTO Books SELECT NULL, file_name, authors_names, title, publication, NULL, NULL FROM Books_new;

--select new authors and/or books
SELECT author_id, author_name, book_id, title FROM 
	(SELECT Authors.id AS author_id, Authors.name AS author_name 
		FROM Authors JOIN Authors_new ON Authors.name = Authors_new.name),
	(SELECT Books.id AS book_id, Books.authors_names AS authors_names, Books.title AS title 
		FROM Books JOIN Books_new ON Books.authors_names = Books_new.authors_names AND Books.title = Books_new.title)
	WHERE author_name = authors_names OR 
	(
		(INSTR(authors_names, " & ") > 0) AND 
		(
			(author_name = SUBSTR(authors_names, 1, INSTR(authors_names, " & ") - 1)) OR 
			(author_name = SUBSTR(authors_names, INSTR(authors_names, " & ") + 3))
		)
	)
	ORDER BY author_id;
	
--add new entries to Book_Authors
INSERT INTO Book_Authors  
	SELECT author_id, book_id FROM 
		(SELECT Authors.id AS author_id, Authors.name AS author_name
			FROM Authors JOIN Authors_new ON Authors.name = Authors_new.name),
		(SELECT Books.id AS book_id, Books.authors_names AS authors_names, Books.title AS title 
			FROM Books JOIN Books_new ON Books.authors_names = Books_new.authors_names AND Books.title = Books_new.title)
		WHERE author_name = authors_names OR 
		(
			(INSTR(authors_names, " & ") > 0) AND 
			(
				(author_name = SUBSTR(authors_names, 1, INSTR(authors_names, " & ") - 1)) OR 
				(author_name = SUBSTR(authors_names, INSTR(authors_names, " & ") + 3))
			)
		)
		ORDER BY author_id;

--add missing entries for Book_Authors identified by Books_no_Authors
INSERT INTO Book_Authors
	SELECT author_id, Books_id 
	FROM 
	(SELECT id AS Books_id, authors_names, title 
		FROM Books LEFT JOIN Book_Authors ON id=book_id 
		WHERE book_id IS NULL ORDER BY id),
	(SELECT id AS author_id, name AS author_name
		FROM Authors)
		WHERE author_name = authors_names OR 
		(
			(INSTR(authors_names, " & ") > 0) AND 
			(
				(author_name = SUBSTR(authors_names, 1, INSTR(authors_names, " & ") - 1)) OR 
				(author_name = SUBSTR(authors_names, INSTR(authors_names, " & ") + 3))
			)
		)
		ORDER BY author_id;
	
--add new entries to Tags
INSERT INTO Tags SELECT NULL
,knit
,crochet
,loom
,clothing
,coat
,cardigan
,hoodie
,sweater
,tunic
,vest
,henley
,tank
,tee
,top
,cape
,kimono
,poncho
,robe
,shawl
,shrug
,wrap
,dress
,pants
,shorts
,skirt
,bodice
,bra
,cami
,panty
,underwear
,nighty
,pajamas
,sleepwear
,swimwear
,accessory
,bag
,purse
,tote
,legwear
,socks
,stocking
,legwarmers
,booties
,slippers
,beanie
,beret
,cap
,cloche
,earflap
,hat
,headband
,hood
,neckwear
,cowl
,necktie
,scarf
,armwear
,gloves
,mittens
,wristbands
,afghan
,blanket
,block
,cushion
,dishcloth
,home
,quilt
,teacosy
,throw
,animal
,doll
,gift
,halloween
,toy
,valentine
,wedding
,xmas
,adult
,baby
,boy
,child
,girl
,man
,toddler
,woman
,colourwork
,doubleknit
,intarsia
,mosaic
,stranded
,striped
,bottomup
,edging
,entrelac
,motif
,raglan
,seamless
,sideways
,stitches
,techniques
,toeup
,topdown
,beaded
,brioche
,cabled
,chunky
,eyelet
,lace
,lacy
,mesh
,patterned
,reversible
,ribbed
,smocked
,textured
,folk
,american
,andean
,aran
,british
,celtic
,chinese
,cowichan
,english
,estonian
,fairisle
,finnish
,french
,german
,guernsey
,icelandic
,indian
,irish
,italian
,japanese
,latvian
,maltese
,nordic
,norwegian
,russian
,scottish
,shetland
,slovak
,swedish
,turkish
,world
,vintage FROM Tags_new
--SELECT name FROM PRAGMA table_info(Tags)


--drop new tables
DROP TABLE Authors_new;
DROP TABLE Books_new;
DROP TABLE Tags_new;
DROP TABLE Book_Tags_new;
--DROP TABLE Book_Authors_new;

