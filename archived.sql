--	books with no tags
SELECT Books.id, title, tag FROM Books LEFT JOIN Book_Tags ON Books.id = Book_Tags.book_id 
	WHERE book_id IS NULL 
	ORDER BY title;

DROP INDEX Idx_Book_Tags;
CREATE INDEX Idx_Book_Tags ON Book_Tags(book_id,tag);

SELECT * FROM Tags ORDER BY book_id;

INSERT INTO Tags(book_id) SELECT id FROM Books;

UPDATE Tags 
	SET coat = 1 
	WHERE EXISTS (SELECT * FROM Book_Tags WHERE Tags.book_id = Book_Tags.book_id AND Book_Tags.tag = 'coat');
UPDATE Tags 
	SET cardigan = 1 
	WHERE EXISTS (SELECT * FROM Book_Tags WHERE Tags.book_id = Book_Tags.book_id AND Book_Tags.tag = 'cardigan');
UPDATE Tags 
	SET hoodie = 1 
	WHERE EXISTS (SELECT * FROM Book_Tags WHERE Tags.book_id = Book_Tags.book_id AND Book_Tags.tag = 'hoodie');
UPDATE Tags 
	SET clothing = 1 
	WHERE coat OR sweater OR top OR wrap OR dress OR pants OR shorts OR skirt OR underwear OR sleepwear OR swimwear; 
	
	

SELECT *
	FROM Books JOIN Book_Tags ON Books.id = Book_Tags.book_id
	WHERE tag = 'cabled';
	
SELECT * FROM Tags 
	WHERE cabled = 1;

SELECT * FROM Books JOIN Tags ON Books.id = Tags.book_id
	WHERE cabled = 1;

SELECT * FROM Tags JOIN Book_Tags ON Tags.book_id = Book_Tags.book_id
	WHERE tag = 'cabled';

SELECT * FROM Book_Tags LEFT JOIN Tags ON Book_Tags.book_id = Tags.book_id
	WHERE tag = 'crochet';

SELECT Book_Tags.book_id, Book_Tags.tag, Tags.book_id, Tags.cabled FROM Book_Tags JOIN Tags ON Tags.book_id = Book_Tags.book_id 
	WHERE Book_Tags.tag = 'cabled';

SELECT *
	FROM Books JOIN Book_Tags JOIN Tags ON Books.id = Tags.book_id AND Books.id = Book_Tags.book_id
	WHERE tag = 'cabled';
	
ALTER TABLE Authors ADD COLUMN website TEXT;

	
SELECT *
	FROM Authors JOIN Book_Authors JOIN Books ON Books.id = Book_Authors.book_id AND Book_Authors.author_id = Authors.id;
	
	
	
	
	
	
	
	
	
	SELECT Books.id, title, tag FROM Books LEFT JOIN Book_Tags ON Books.id = Book_Tags.book_id 
	WHERE book_id IS NULL 
	ORDER BY title;

SELECT Books.id, title, tag FROM Books LEFT JOIN Book_Tags ON Books.id = Book_Tags.book_id 
	ORDER BY title;

DROP INDEX Idx_Book_tags;
CREATE INDEX Idx_Book_tags ON Book_tags(book_id,tag);

SELECT * FROM Tags ORDER BY book_id;
	
INSERT INTO Tags(book_id) SELECT id FROM Books;

UPDATE Tags 
	SET coat = 1 
	WHERE EXISTS (SELECT * FROM Book_Tags WHERE Tags.book_id = Book_Tags.book_id AND Book_Tags.tag = 'coat');
UPDATE Tags 
	SET cardigan = 1 
	WHERE EXISTS (SELECT * FROM Book_Tags WHERE Tags.book_id = Book_Tags.book_id AND Book_Tags.tag = 'cardigan');
UPDATE Tags 
	SET hoodie = 1 
	WHERE EXISTS (SELECT * FROM Book_Tags WHERE Tags.book_id = Book_Tags.book_id AND Book_Tags.tag = 'hoodie');
UPDATE Tags 
	SET clothing = 1 
	WHERE coat OR sweater OR top OR wrap OR dress OR pants OR shorts OR skirt OR underwear OR sleepwear OR swimwear; 
	
	

SELECT *
	FROM Books JOIN Book_Tags ON Books.id = Book_Tags.book_id
	WHERE tag = 'cabled';
	
SELECT * FROM Tags 
	WHERE cabled = 1;

SELECT * FROM Books JOIN Tags ON Books.id = Tags.book_id
	WHERE cabled = 1;

SELECT * FROM Tags JOIN Book_Tags ON Tags.book_id = Book_Tags.book_id
	WHERE tag = 'cabled';

SELECT Books.*, Tags.* FROM Books JOIN Book_Tags JOIN Tags ON Book_Tags.book_id = Tags.book_id AND Books.id = Tags.book_id
	WHERE tag = 'loom';

SELECT Book_Tags.book_id, Book_Tags.tag, Tags.book_id, Tags.cabled FROM Book_Tags JOIN Tags ON Tags.book_id = Book_Tags.book_id 
	WHERE Book_Tags.tag = 'cabled';

SELECT *
	FROM Books JOIN Book_Tags JOIN Tags ON Books.id = Tags.book_id AND Books.id = Book_Tags.book_id
	WHERE tag = 'cabled';
	
ALTER TABLE Authors ADD COLUMN website TEXT;

	
SELECT *
	FROM Authors JOIN Book_Authors JOIN Books ON Books.id = Book_Authors.book_id AND Book_Authors.author_id = Authors.id;
	
	
	
	
	
	

