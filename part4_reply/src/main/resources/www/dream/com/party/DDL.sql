drop sequence seq4Party_id;

drop table T_Accountability;
drop table T_Accountability_Type;
drop table T_ContactPoint;
drop table T_ContactPoint_Type;
drop table T_Party;
drop table T_Party_Type;

create sequence seq4Party_id;

--type_name, descript
create table T_Party_Type (
	type_name			varchar2(100) primary key,
	descript			varchar2(2000),
	--공통 관리 정보
	reg_date			date default sysdate,
	update_date			date default sysdate		
);
insert into T_Party_Type(type_name, descript)
	values('person', '자연인이로다');
insert into T_Party_Type(type_name, descript)
	values('organization', '그룹사, 회사, 조직, 부서 팀, 등등등');
insert into T_Party_Type(type_name, descript)
	values('post', '직책, 트레이너');

--id, name, birth_date, party_type
--login_id, password, gender
--descript
create table T_Party (
	id					numeric(22, 0) primary key,
	name				varchar2(100),
	birth_date			date,
	party_type			varchar2(100),	--Descriminator, 타입 구분자
	--person(자연인)일 경우의 추가적인 정보
	login_id			varchar2(100),
	password			varchar2(100),
	gender				smallInt,
	--organization일 경우의 추가적인 정보
	--post일 경우의 추가적인 정보
	descript			varchar2(2000),
	--공통 관리 정보
	reg_date			date default sysdate,
	update_date			date default sysdate		
);

----- Key Table을 정의 하시오
--type_name, descript, validating_reg_exp, super_name
create table T_ContactPoint_Type (
	type_name			varchar2(100) primary key,
	descript			varchar2(2000),
	validating_reg_exp	varchar2(100),
	super_name			varchar2(100),
	reg_date			date default sysdate,
	update_date			date default sysdate		
);
insert into T_ContactPoint_Type(type_name, descript, validating_reg_exp, super_name)
	values('offline', '물리적인 정보', null, null);
insert into T_ContactPoint_Type(type_name, descript, validating_reg_exp, super_name)
	values('address', '물리적인 우편 체계에 따른 정보', null, 'offline');
insert into T_ContactPoint_Type(type_name, descript, validating_reg_exp, super_name)
	values('online', '전기적인 정보', null, null);
insert into T_ContactPoint_Type(type_name, descript, validating_reg_exp, super_name)
	values('email', '이메일 주소 정보', '/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/', 'online');

--party_id, type_name, contact_point
create table T_ContactPoint (
	party_id			numeric(22, 0),
	type_name			varchar2(100),
	contact_point		varchar2(500),
	reg_date			date default sysdate,
	update_date			date default sysdate,
	primary key(party_id, type_name)		
);

--type_name, descript, super_name
create table T_Accountability_Type (
	type_name			varchar2(100) primary key,
	descript			varchar2(2000),
	super_name			varchar2(100),
	--공통 관리 정보
	reg_date			date default sysdate,
	update_date			date default sysdate		
);
insert into T_Accountability_Type(type_name, descript, super_name)
	values('창업하다', '창업하다', null);
insert into T_Accountability_Type(type_name, descript, super_name)
	values('고용하다', '고용하다', null);
insert into T_Accountability_Type(type_name, descript, super_name)
	values('근무시키다', '근무시키다', '고용하다');
insert into T_Accountability_Type(type_name, descript, super_name)
	values('가입하다', '가입하다', null);

--owner_id, type_name, responsable_id
create table T_Accountability(
	type_name			varchar2(100),
	owner_id			numeric(22, 0),
	responsable_id		numeric(22, 0),
	--공통 관리 정보
	reg_date			date default sysdate,
	update_date			date default sysdate,
	primary key(owner_id, type_name, responsable_id)		
);
create index idx_acc_res2owner on T_Accountability(responsable_id, type_name, owner_id);

