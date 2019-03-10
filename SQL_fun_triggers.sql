use BankDB

select * from tbl_customersinfo

select * from tbl_accountinfo

select * from tbl_transactioninfo

alter trigger tgr_transaction_accbal
on tbl_transactioninfo
for insert
as
begin
declare @id int,@amt int,@type varchar(100)
select @id=AccountID,@amt=Amount,@type=TransactionType from inserted
if(@type='Credit')
begin
update tbl_accountinfo set AccountBalance=AccountBalance-@amt where AccountID=@id
end
if(@type='Deposit')
begin
update tbl_accountinfo set AccountBalance=AccountBalance+@amt where AccountID=@id
end
declare @checkamt int
select @checkamt=AccountBalance from tbl_accountinfo where AccountID=@id
if(@checkamt<0)
begin
rollback tran
end
end

insert into tbl_transactioninfo values(10001,'Deposit',1999,GETDATE())

select * from tbl_accountinfo