-- Tabla: brands b --
INSERT INTO brands (id,name,description)
VALUES
	(1,'Augustinus Bader','Backed by over 30 years of research in cellular repair and his deep understanding of stem cell biology, tissue engineering and regenerative medicine, Professor Bader has developed the patented technology TFC8® - the renewing complex present in Augustinus Bader skincare line. Launched in 2018, Augustinus Bader is a premium, science-led skincare line backed by the highest caliber of applied science in the industry.'),
	(2,'Briogeo','Briogeo offers a full selection of clean, natural and effective hair care products that are built to treat every hair type and texture. Briogeo is 6-free hair care; meaning formulas are free of sulfates, parabens, phthalates, silicones, DEA and synthetic color. All products are 90 to 100 percent naturally derived and packaged in bottles that are both recycled and recyclable. Briogeo formulas are cruelty-free and mostly vegan and gluten free also.'),
	(3,'Bobbi Brown','Founded in New York in 1991, we helped change the face of beauty with a natural approach to makeup that rallied everyone to not only be who they are—but own how they look. And that is still what we stand for today. Everything starts with skin for a fresh, healthy-looking glow and builds from there with multitasking products, easy how tos, and undertone-correct shades that look like your skin, only better—beauty for every real-life moment.'),
	(4,'Caudalie','Caudalie is a French skincare brand created by Mathilde and Bertrand Thomas in Bordeaux in 1995. All products are developed using natural ingredients from the vine and grapes. Caudalie´s mission? To become the most effective clean and natural brand, and the most environmentally-friendly beauty brand.'),
	(5,'Drunk Elephant','Since 2012, Drunk Elephant has pioneered a philosophy that is as radical as it is simple. Get rid of anything that is irritating, sensitizing, disruptive, or inflammatory, and replace it with smart, biocompatible ingredients that the skin recognizes and embraces. We call the culprits the Suspicious 6—essential oils, drying alcohols, silicones, chemical sunscreens, fragrances/dyes, and SLS—and you will never find any of them in our line.'),
	(6,'Estée Lauder','Estée Lauder is the flagship brand of The Estée Lauder Companies Inc. Founded by Estée Lauder, one of the world’s first female entrepreneurs, the brand today continues her legacy of creating the most innovative, sophisticated, high-performance skin care and makeup products and iconic fragrances — all infused with a deep understanding of women’s needs and desires.'),
	(7,'Glossier','At Glossier, we make products inspired by real life. We believe beauty is about having fun, celebrating freedom and being present, because no matter where you are in your beauty journey - YOU LOOK GOOD.'),
	(8,'The Ordinary','The Ordinary creates clinical formulations with integrity. Rooted in skin science, the brand uses effective ingredients, at optimal concentrations, and at sensible prices. It´s on a mission to make quality ingredients accessible to everyone, while being the voice of clear, transparent beauty for its community.');

-- Tabla: category ca --
INSERT INTO category (id,name)
VALUES
	(1,'Skincare'),
	(2,'Makeup'),
	(3,'Hair'),
	(4,'Fragrance'),
	(5,'Bath & Body');

-- Tabla: subcategory sc --
INSERT INTO subcategory (id,category_id,name)
VALUES
	(1,1,'Cleansers'),
	(2,1,'Treatments'),
	(3,1,'Moisturizer'),
	(4,2,'Face'),
	(5,2,'Cheek'),
	(6,2,'Eye'),
	(7,2,'Lip'),
	(8,3,'Shampoo'),
	(9,3,'Conditioner'),
	(10,3,'Treatments'),
	(11,4,'Women'),
	(12,4,'Men'),
	(13,5,'Bath & Shower'),
	(14,5,'Body Moisturizers');

-- Tabla: products p --
INSERT INTO products (id,name,brand_id,category_id,subcategory_id,price,size,measure_type,description,new,limited_edition,online_only,out_of_stock,loves)
VALUES
	(1,'The Rich Cream with TFC8® Face Moisturizer',1,1,3,300,50,'ml','An intensely hydrating moisturizer powered by patented TFC8® that’s clinically shown to reduce the appearance of fine lines, wrinkles, and hyperpigmentation.',0,0,0,1,3),
	(2,'Don´t Despair, Repair!™ Deep Conditioning Hair Mask',2,3,10,39,8,'oz','A weekly, clinically tested mask that strengthens damaged hair and helps prevent future damage.',0,0,0,0,2),
	(3,'Scalp Revival Charcoal + Coconut Oil Micro-exfoliating Scalp Scrub Shampoo',2,3,8,42,8,'oz','An exfoliating, sulfate-free scrub that lifts away impurities and buildup while balancing and soothing an itchy, irritated scalp (whether oily or dry).',1,0,0,0,3),
	(4,'Vitamin Enriched Face Base Primer Moisturizer',3,1,3,69,50,'ml','A bestselling, multivitamin-enriched primer that nourishes, visibly plumps, and preps skin with healthy hydration to improve the look of foundation.',0,0,0,0,2),
	(5,'Pot Rouge For Lips And Cheeks',3,2,5,36,3.8,'ml','A bestselling, multitasking cream color for lips and cheeks that comes in a mirrored flip-top compact for on-the-spot application.',0,0,0,0,1),
	(6,'Beach Fragrance',3,4,11,85,50,'ml','A light, happy, and nostalgic scent that evokes warm sunshine and the sea breeze.',1,1,0,0,2),
	(7,'Beauty Elixir Prep, Set, Glow Face Mist',4,1,2,33,100,'ml','A natural face mist to prep skin, immediately tighten pores & set makeup for dewy, glowing skin.',0,0,0,0,3),
	(8,'Vinopure Pore Purifying Gel Cleanser',4,1,1,30,150,'ml','A cleanly formulated, nondrying gel cleanser with exfoliating, natural salicylic acid and hydrating grape water to purify skin and absorb excess oil.',1,0,1,0,1),
	(9,'B-Hydra™ Intensive Hydration Serum with Hyaluronic Acid',5,1,2,49,50,'ml','A daily flood of hydration, this hydrating serum replenishes skin while improving long-term hydration, diminishing dullness, dryness, and the look of fine lines.',0,0,0,0,1),
	(10,'Wonderwild Miracle Butter',5,5,14,38,60,'ml','An intensely nourishing salve that rescues and soothes dry, chapped, irritated, or compromised skin, supporting skin’s natural healing abilities.',0,1,1,1,2),
	(11,'Double Wear Sheer Long-Wear Makeup SPF 19',6,2,4,52,1,'oz','A sheer, natural matte foundation with up to 12-hour-wear, SPF, and skincare benefits.',0,0,0,0,0),
	(12,'Lash Slick Lift and Lengthening Mascara',7,2,6,20,8.5,'gr','A long-wearing mascara with a weightless, flexible formula for a lengthening, baby-extensions effect that won’t smudge or flake.',0,0,0,0,4),
	(13,'Glossier You Eau de Parfum',7,4,11,72,50,'ml','Glossier You isn’t a scent you wear to become someone else. Rather, it´s the ultimate personal fragrance that will transform and grow with you no matter where you’re at in life. Glossier You is a skin enhancer that smells like you: soft, warm, and familiar.',1,0,1,0,3),
	(14,'Balm Dotcom Lip Balm and Skin Salve',7,2,7,14,15,'ml','A moisturizing lip balm with antioxidants and emollients that nourishes for smooth, hydrated lips without the shine.',0,0,0,0,3),
	(15,'Niacinamide 10% + Zinc 1% Oil Control Serum ',8,1,2,6,30,'ml','A high-strength vitamin-and-mineral blemish formula with 10 percent pure niacinamide and one percent zinc PCA.',0,0,0,0,2);

-- Tabla: customers c --
INSERT INTO customers (id,first_name,last_name,date_of_birth,gender,country,email,password,created_at,updated_at)
VALUES
	(1,'August','Beber','1998-10-30','Male','Argentina','wolfy_auu@gmail.com','Caromylove98',NOW(),NOW()),
	(2,'Emma','Johnson','1985-04-15','Female','United States','emma.johnson@email.com','Aa#123bc',NOW(),NOW()),
	(3,'Liam','Taylor','1990-07-22','Male','Canada','liam.taylor@email.com','Ll$456mn',NOW(),NOW()),
	(4,'Olivia','Smith','1982-12-10','Female','United Kingdom','olivia.smith@email.com','Oo&789ab',NOW(),NOW()),
	(5,'Ethan','Williams','1995-09-05','Male','United States','ethan.williams@email.com','Ee*012cd',NOW(),NOW()),
	(6,'Ava','Davis','1988-03-28','Female','United States','ava.davis@email.com','Aa@345ef',NOW(),NOW()),
	(7,'Noah','Brown','1992-06-18','Male','United States','noah.brown@email.com','Nn&678gh',NOW(),NOW()),
	(8,'Sophia','Miller','1980-11-03','Female','Canada','sophia.miller@email.com','Ss#901ij',NOW(),NOW()),
	(9,'Mason','Walker','1998-02-14','Female','South Africa','mason.walker@email.com','Mm*234kl',NOW(),NOW()),
	(10,'Isabella','Taylor','1984-05-20','Female','Canada','isabella.taylor@email.com','Ii$567op',NOW(),NOW());

-- Tabla: customer_details cd --
INSERT INTO customer_details (id,customer_id,skin_type,skin_concern,hair_type,hair_concern)
VALUES
	(1,1,'Combination','Acne & Blemishes','Straight','Nourish'),
	(2,2,'Normal','Pores','Curly','Anti-frizz'),
	(3,3,'Combination','Dark Spots','Straight','Volume & Texture'),
	(4,4,'Dry','Anti-Aging','Straight','Curl Enhancing'),
	(5,5,'Oily','Dark Spots','Curly','Nourish'),
	(6,6,'Normal','Dryness','Wavy','Anti-frizz'),
	(7,7,'Oily','Dullness','Curly','Curl Enhancing'),
	(8,8,'Dry','Dark Spots','Straight','Volume & Texture'),
	(9,9,'Combination','Pores','Wavy','Nourish'),
	(10,10,'Dry','Acne & Blemishes','Straight','Volume & Texture');

-- Tabla: loved_products lp --
INSERT INTO loved_products (id,customer_id,product_id)
VALUES
	(1,1,4),
	(2,1,12),
	(3,1,6),
	(4,1,7),
	(5,2,7),
	(6,2,5),
	(7,2,3),
	(8,2,12),
	(9,2,15),
	(10,3,10),
	(11,3,9),
	(12,3,13),
	(13,4,1),
	(14,4,2),
	(15,4,4),
	(16,4,14),
	(17,4,3),
	(18,4,7),
	(19,4,6),
	(20,4,13),
	(21,4,8),
	(22,5,12),
	(23,5,2),
	(24,6,10),
	(25,7,13),
	(26,7,15),
	(27,7,14),
	(28,7,1),
	(29,8,1),
	(30,8,14),
	(31,8,3),
	(32,9,12);

-- Tabla: channel ch --
INSERT INTO channel (id,channel_type)
VALUES
	(1,'In store'),
	(2,'Online');
    
-- Tabla: stores s --
INSERT INTO stores (id,name,address,city,zip_code,state,phone_number)
VALUES
	(1,'Beau at Hollywood & Highland','6801 Hollywood Blvd, Suite 179','Los Angeles',90028,'CA',4626898),
	(2,'Beau Union Square','45 E 17th St','New York',10003,'NY',9958833),
	(3,'Beau Michigan Avenue','605 N Michigan Ave','Chicago',60611,'IL',6499343),
	(4,'Beau South Beach','721 Collins Ave','Miami Beach',33139,'FL',5320904),
	(5,'Beau Bellevue Square','218 Bellevue Square','Bellevue',98004,'WA',4621405),
	(6,'Beau NorthPark Center','8687 N Central Expy, Suite 2232','Dallas',75225,'TX',3617357);

-- Tabla: shopping_history sh --
INSERT INTO shopping_history (id,date,customer_id,total_spent,channel_id,store_id)
VALUES
	(1,'2023-05-12',1,339,1,2),
	(2,'2021-09-28',3,411,1,4),
	(3,'2022-11-03',9,6,1,1),
	(4,'2020-07-15',10,503,2,NULL),
	(5,'2024-01-20',8,85,2,NULL),
	(6,'2023-03-08',2,100,1,5),
	(7,'2022-06-04',3,152,2,NULL);

-- Tabla: shopping_details sd --
INSERT INTO shopping_details (id,shopping_history_id,product_id)
VALUES
	(1,1,1),
	(2,1,2),
	(3,2,3),
	(4,2,4),
	(5,2,1),
	(6,3,15),
	(7,4,6),
	(8,4,9),
	(9,4,1),
	(10,4,4),
	(11,5,7),
	(12,5,11),
	(13,6,10),
	(14,6,3),
	(15,6,12),
	(16,7,14),
	(17,7,13),
	(18,7,8),
	(19,7,5);
