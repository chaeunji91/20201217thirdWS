--id, name, birth_date, party_type
--login_id, password, gender
--descript
id, name, value, descript, seller_id, composer_id, product_type
create table T_Product



insert into T_Product(id, name, value, descript, seller_id, composer_id, product_type)
	values(seq4Product_id.nextval, 'Dream Main', 10000, '핫한 드림 이루기', 2, null, 'composer');

insert into T_Product(id, name, value, descript, seller_id, composer_id, product_type)
	values(seq4Product_id.nextval, 'Main detail 1', 3000, '핫한 드림 요소1', 2, 1, 'elementary');
insert into T_Product(id, name, value, descript, seller_id, composer_id, product_type)
	values(seq4Product_id.nextval, 'Main detail 2', 7000, '핫한 드림 요소2', 2, 1, 'elementary');
	
	