--id, name, birth_date, party_type
--login_id, password, gender
--descript
insert into T_Party (id, name, birth_date, party_type)
	values(seq4Party_id.nextval, '창업자', '1920.01.01', 'person');

insert into T_ContactPoint(party_id, type_name, contact_point)
	values(1, 'address', '서울 용산구 한남동 1번지');
insert into T_ContactPoint(party_id, type_name, contact_point)
	values(1, 'email', 'creator@gmail.com');

insert into T_Party (id, name, birth_date, party_type)
	values(seq4Party_id.nextval, 'Dream The Great', '2020.01.01', 'organization');
insert into T_ContactPoint(party_id, type_name, contact_point)
	values(2, 'address', '서울 강남구 테헤란로 1번지');

insert into T_Accountability(type_name, owner_id, responsable_id)
	values('창업하다', 1, 2);

	
insert into T_Party (id, name, birth_date, party_type)
	values(seq4Party_id.nextval, '홍길동', '1920.01.01', 'person');	--21번
	