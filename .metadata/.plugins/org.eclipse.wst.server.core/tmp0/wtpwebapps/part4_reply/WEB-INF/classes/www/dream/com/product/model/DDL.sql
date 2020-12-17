drop sequence seq4Product_id;

drop table T_Product;

create sequence seq4Product_id;

--id, name, value, descript, seller_id, composer_id, product_type, reg_date, update_date
create table T_Product (
	id					numeric(22, 0) primary key,
	name				varchar2(100),
	value				numeric(22, 0),
	descript			varchar2(2000),
	seller_id			numeric(22, 0), 
	composer_id			numeric(22, 0),
	product_type		varchar2(100),	--Descriminator, 타입 구분자, composer, elementary
	--공통 관리 정보
	reg_date			date default sysdate,
	update_date			date default sysdate,	
	constraint fk_prod_party foreign key (seller_id) references T_Party (id),	
	constraint fk_prod_prod foreign key (composer_id) references T_Product(id)	
);

