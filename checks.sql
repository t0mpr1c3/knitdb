--check for authors without books
SELECT id, name FROM Authors LEFT JOIN Book_Authors ON id=author_id WHERE author_id IS NULL;

--check for books without authors
SELECT author_id, name FROM Book_Authors LEFT JOIN Authors ON id=author_id WHERE id IS NULL;

--check for tags without books
SELECT book_id, title FROM Tags LEFT JOIN Books ON id=book_id WHERE id IS NULL;

--check for books without tags
SELECT id, title FROM Books LEFT JOIN Tags ON id=book_id WHERE book_id IS NULL;
