
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

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE loom = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE loom = 1 ORDER BY book_id), 
    (SELECT "loom" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE clothing = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE clothing = 1 ORDER BY book_id), 
    (SELECT "clothing" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE coat = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE coat = 1 ORDER BY book_id), 
    (SELECT "coat" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cardigan = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cardigan = 1 ORDER BY book_id), 
    (SELECT "cardigan" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE hoodie = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE hoodie = 1 ORDER BY book_id), 
    (SELECT "hoodie" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE sweater = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE sweater = 1 ORDER BY book_id), 
    (SELECT "sweater" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE tunic = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE tunic = 1 ORDER BY book_id), 
    (SELECT "tunic" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE vest = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE vest = 1 ORDER BY book_id), 
    (SELECT "vest" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE henley = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE henley = 1 ORDER BY book_id), 
    (SELECT "henley" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE tank = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE tank = 1 ORDER BY book_id), 
    (SELECT "tank" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE tee = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE tee = 1 ORDER BY book_id), 
    (SELECT "tee" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE top = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE top = 1 ORDER BY book_id), 
    (SELECT "top" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cape = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cape = 1 ORDER BY book_id), 
    (SELECT "cape" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE kimono = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE kimono = 1 ORDER BY book_id), 
    (SELECT "kimono" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE poncho = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE poncho = 1 ORDER BY book_id), 
    (SELECT "poncho" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE robe = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE robe = 1 ORDER BY book_id), 
    (SELECT "robe" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE shawl = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE shawl = 1 ORDER BY book_id), 
    (SELECT "shawl" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE shrug = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE shrug = 1 ORDER BY book_id), 
    (SELECT "shrug" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE wrap = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE wrap = 1 ORDER BY book_id), 
    (SELECT "wrap" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE dress = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE dress = 1 ORDER BY book_id), 
    (SELECT "dress" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE pants = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE pants = 1 ORDER BY book_id), 
    (SELECT "pants" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE shorts = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE shorts = 1 ORDER BY book_id), 
    (SELECT "shorts" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE skirt = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE skirt = 1 ORDER BY book_id), 
    (SELECT "skirt" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE bodice = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE bodice = 1 ORDER BY book_id), 
    (SELECT "bodice" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE bra = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE bra = 1 ORDER BY book_id), 
    (SELECT "bra" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cami = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cami = 1 ORDER BY book_id), 
    (SELECT "cami" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE panty = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE panty = 1 ORDER BY book_id), 
    (SELECT "panty" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE underwear = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE underwear = 1 ORDER BY book_id), 
    (SELECT "underwear" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE nighty = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE nighty = 1 ORDER BY book_id), 
    (SELECT "nighty" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE pajamas = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE pajamas = 1 ORDER BY book_id), 
    (SELECT "pajamas" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE sleepwear = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE sleepwear = 1 ORDER BY book_id), 
    (SELECT "sleepwear" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE swimwear = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE swimwear = 1 ORDER BY book_id), 
    (SELECT "swimwear" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE accessory = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE accessory = 1 ORDER BY book_id), 
    (SELECT "accessory" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE bag = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE bag = 1 ORDER BY book_id), 
    (SELECT "bag" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE purse = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE purse = 1 ORDER BY book_id), 
    (SELECT "purse" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE tote = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE tote = 1 ORDER BY book_id), 
    (SELECT "tote" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE legwear = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE legwear = 1 ORDER BY book_id), 
    (SELECT "legwear" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE socks = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE socks = 1 ORDER BY book_id), 
    (SELECT "socks" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE stocking = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE stocking = 1 ORDER BY book_id), 
    (SELECT "stocking" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE legwarmers = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE legwarmers = 1 ORDER BY book_id), 
    (SELECT "legwarmers" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE booties = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE booties = 1 ORDER BY book_id), 
    (SELECT "booties" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE slippers = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE slippers = 1 ORDER BY book_id), 
    (SELECT "slippers" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE beanie = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE beanie = 1 ORDER BY book_id), 
    (SELECT "beanie" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE beret = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE beret = 1 ORDER BY book_id), 
    (SELECT "beret" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cap = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cap = 1 ORDER BY book_id), 
    (SELECT "cap" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cloche = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cloche = 1 ORDER BY book_id), 
    (SELECT "cloche" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE earflap = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE earflap = 1 ORDER BY book_id), 
    (SELECT "earflap" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE hat = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE hat = 1 ORDER BY book_id), 
    (SELECT "hat" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE headband = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE headband = 1 ORDER BY book_id), 
    (SELECT "headband" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE hood = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE hood = 1 ORDER BY book_id), 
    (SELECT "hood" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE neckwear = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE neckwear = 1 ORDER BY book_id), 
    (SELECT "neckwear" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cowl = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cowl = 1 ORDER BY book_id), 
    (SELECT "cowl" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE necktie = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE necktie = 1 ORDER BY book_id), 
    (SELECT "necktie" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE scarf = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE scarf = 1 ORDER BY book_id), 
    (SELECT "scarf" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE armwear = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE armwear = 1 ORDER BY book_id), 
    (SELECT "armwear" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE gloves = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE gloves = 1 ORDER BY book_id), 
    (SELECT "gloves" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE mittens = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE mittens = 1 ORDER BY book_id), 
    (SELECT "mittens" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE wristbands = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE wristbands = 1 ORDER BY book_id), 
    (SELECT "wristbands" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE afghan = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE afghan = 1 ORDER BY book_id), 
    (SELECT "afghan" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE blanket = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE blanket = 1 ORDER BY book_id), 
    (SELECT "blanket" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE block = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE block = 1 ORDER BY book_id), 
    (SELECT "block" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cushion = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cushion = 1 ORDER BY book_id), 
    (SELECT "cushion" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE dishcloth = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE dishcloth = 1 ORDER BY book_id), 
    (SELECT "dishcloth" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE home = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE home = 1 ORDER BY book_id), 
    (SELECT "home" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE quilt = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE quilt = 1 ORDER BY book_id), 
    (SELECT "quilt" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE teacosy = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE teacosy = 1 ORDER BY book_id), 
    (SELECT "teacosy" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE throw = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE throw = 1 ORDER BY book_id), 
    (SELECT "throw" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE animal = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE animal = 1 ORDER BY book_id), 
    (SELECT "animal" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE doll = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE doll = 1 ORDER BY book_id), 
    (SELECT "doll" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE gift = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE gift = 1 ORDER BY book_id), 
    (SELECT "gift" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE halloween = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE halloween = 1 ORDER BY book_id), 
    (SELECT "halloween" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE toy = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE toy = 1 ORDER BY book_id), 
    (SELECT "toy" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE valentine = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE valentine = 1 ORDER BY book_id), 
    (SELECT "valentine" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE wedding = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE wedding = 1 ORDER BY book_id), 
    (SELECT "wedding" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE xmas = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE xmas = 1 ORDER BY book_id), 
    (SELECT "xmas" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE adult = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE adult = 1 ORDER BY book_id), 
    (SELECT "adult" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE baby = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE baby = 1 ORDER BY book_id), 
    (SELECT "baby" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE boy = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE boy = 1 ORDER BY book_id), 
    (SELECT "boy" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE child = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE child = 1 ORDER BY book_id), 
    (SELECT "child" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE girl = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE girl = 1 ORDER BY book_id), 
    (SELECT "girl" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE man = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE man = 1 ORDER BY book_id), 
    (SELECT "man" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE toddler = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE toddler = 1 ORDER BY book_id), 
    (SELECT "toddler" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE woman = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE woman = 1 ORDER BY book_id), 
    (SELECT "woman" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE colourwork = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE colourwork = 1 ORDER BY book_id), 
    (SELECT "colourwork" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE doubleknit = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE doubleknit = 1 ORDER BY book_id), 
    (SELECT "doubleknit" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE intarsia = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE intarsia = 1 ORDER BY book_id), 
    (SELECT "intarsia" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE mosaic = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE mosaic = 1 ORDER BY book_id), 
    (SELECT "mosaic" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE stranded = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE stranded = 1 ORDER BY book_id), 
    (SELECT "stranded" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE striped = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE striped = 1 ORDER BY book_id), 
    (SELECT "striped" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE bottomup = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE bottomup = 1 ORDER BY book_id), 
    (SELECT "bottomup" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE edging = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE edging = 1 ORDER BY book_id), 
    (SELECT "edging" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE entrelac = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE entrelac = 1 ORDER BY book_id), 
    (SELECT "entrelac" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE motif = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE motif = 1 ORDER BY book_id), 
    (SELECT "motif" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE raglan = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE raglan = 1 ORDER BY book_id), 
    (SELECT "raglan" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE seamless = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE seamless = 1 ORDER BY book_id), 
    (SELECT "seamless" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE sideways = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE sideways = 1 ORDER BY book_id), 
    (SELECT "sideways" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE stitches = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE stitches = 1 ORDER BY book_id), 
    (SELECT "stitches" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE techniques = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE techniques = 1 ORDER BY book_id), 
    (SELECT "techniques" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE toeup = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE toeup = 1 ORDER BY book_id), 
    (SELECT "toeup" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE topdown = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE topdown = 1 ORDER BY book_id), 
    (SELECT "topdown" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE beaded = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE beaded = 1 ORDER BY book_id), 
    (SELECT "beaded" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE brioche = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE brioche = 1 ORDER BY book_id), 
    (SELECT "brioche" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cabled = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cabled = 1 ORDER BY book_id), 
    (SELECT "cabled" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE chunky = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE chunky = 1 ORDER BY book_id), 
    (SELECT "chunky" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE eyelet = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE eyelet = 1 ORDER BY book_id), 
    (SELECT "eyelet" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE lace = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE lace = 1 ORDER BY book_id), 
    (SELECT "lace" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE lacy = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE lacy = 1 ORDER BY book_id), 
    (SELECT "lacy" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE mesh = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE mesh = 1 ORDER BY book_id), 
    (SELECT "mesh" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE patterned = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE patterned = 1 ORDER BY book_id), 
    (SELECT "patterned" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE reversible = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE reversible = 1 ORDER BY book_id), 
    (SELECT "reversible" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE ribbed = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE ribbed = 1 ORDER BY book_id), 
    (SELECT "ribbed" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE smocked = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE smocked = 1 ORDER BY book_id), 
    (SELECT "smocked" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE textured = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE textured = 1 ORDER BY book_id), 
    (SELECT "textured" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE folk = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE folk = 1 ORDER BY book_id), 
    (SELECT "folk" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE american = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE american = 1 ORDER BY book_id), 
    (SELECT "american" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE andean = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE andean = 1 ORDER BY book_id), 
    (SELECT "andean" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE aran = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE aran = 1 ORDER BY book_id), 
    (SELECT "aran" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE british = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE british = 1 ORDER BY book_id), 
    (SELECT "british" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE celtic = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE celtic = 1 ORDER BY book_id), 
    (SELECT "celtic" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE chinese = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE chinese = 1 ORDER BY book_id), 
    (SELECT "chinese" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE cowichan = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE cowichan = 1 ORDER BY book_id), 
    (SELECT "cowichan" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE english = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE english = 1 ORDER BY book_id), 
    (SELECT "english" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE estonian = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE estonian = 1 ORDER BY book_id), 
    (SELECT "estonian" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE fairisle = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE fairisle = 1 ORDER BY book_id), 
    (SELECT "fairisle" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE finnish = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE finnish = 1 ORDER BY book_id), 
    (SELECT "finnish" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE french = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE french = 1 ORDER BY book_id), 
    (SELECT "french" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE german = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE german = 1 ORDER BY book_id), 
    (SELECT "german" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE guernsey = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE guernsey = 1 ORDER BY book_id), 
    (SELECT "guernsey" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE icelandic = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE icelandic = 1 ORDER BY book_id), 
    (SELECT "icelandic" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE indian = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE indian = 1 ORDER BY book_id), 
    (SELECT "indian" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE irish = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE irish = 1 ORDER BY book_id), 
    (SELECT "irish" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE italian = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE italian = 1 ORDER BY book_id), 
    (SELECT "italian" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE japanese = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE japanese = 1 ORDER BY book_id), 
    (SELECT "japanese" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE latvian = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE latvian = 1 ORDER BY book_id), 
    (SELECT "latvian" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE maltese = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE maltese = 1 ORDER BY book_id), 
    (SELECT "maltese" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE nordic = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE nordic = 1 ORDER BY book_id), 
    (SELECT "nordic" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE norwegian = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE norwegian = 1 ORDER BY book_id), 
    (SELECT "norwegian" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE russian = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE russian = 1 ORDER BY book_id), 
    (SELECT "russian" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE scottish = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE scottish = 1 ORDER BY book_id), 
    (SELECT "scottish" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE shetland = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE shetland = 1 ORDER BY book_id), 
    (SELECT "shetland" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE slovak = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE slovak = 1 ORDER BY book_id), 
    (SELECT "slovak" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE swedish = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE swedish = 1 ORDER BY book_id), 
    (SELECT "swedish" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE turkish = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE turkish = 1 ORDER BY book_id), 
    (SELECT "turkish" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE world = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE world = 1 ORDER BY book_id), 
    (SELECT "world" AS tag);

INSERT INTO Book_Tags_new
SELECT * FROM 
    (SELECT 
        (SELECT COUNT(*) + (SELECT COUNT(*) FROM Book_Tags_new) FROM Tags AS t2 WHERE vintage = 1 AND t2.book_id <= t1.book_id) AS id, book_id
        FROM Tags AS t1 WHERE vintage = 1 ORDER BY book_id), 
    (SELECT "vintage" AS tag);
