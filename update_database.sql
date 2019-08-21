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


--view new books without tags
SELECT Books_new.id, title, tag FROM Books_new LEFT JOIN Book_Tags_new ON Books_new.id = Book_Tags_new.book_id 
	WHERE book_id IS NULL 
	ORDER BY title;
	
--check tags and book_tags
SELECT * FROM Tags_new JOIN Book_Tags_new JOIN Books_new ON Tags_new.book_id = Book_Tags_new.book_id AND Tags_new.book_id = Books_new.id ORDER BY Tags_new.book_id;


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


--now run consolidate_tags.sql, update_book_tags.sql, and checks.sql
