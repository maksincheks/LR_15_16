
const
  N = 10; 
type
  PNode = ^Node;
  Node = record //Это запись, которая содержит два поля: Data (целое число) и Next (указатель на следующий элемент)
    Data: Integer;
    Next: PNode;
  end;
var
  Head, Current: PNode;
  i: Integer;
//Добавляет новый узел с указанным значением в начало списка. Создается новый узел, его данные устанавливаются в переданное значение, а указатель Next направляется
procedure AddNode(var List: PNode; Value: Integer);
var
  newNode: PNode;
begin
  New(newNode);
  newNode^.Data := Value;
  newNode^.Next := List;
  List := newNode;
end;

begin
   Randomize;
  Head := nil;
  for i := 1 to N do
    AddNode(Head,Random(200)-100); 
  write('Числа ---> ');
  Current := Head;
  while Current <> nil do
  begin
    write(Current^.Data, ' ');
    Current := Current^.Next;
  end;
  
  writeln;
  write('Четные числа ---> ');
  Current := Head;
  while Current <> nil do
  begin
    if Current^.Data mod 2 = 0 then
      write(Current^.Data, ' ');
    Current := Current^.Next;
  end;
end.
//Эта программа создает односвязный список из 10 случайных целых чисел, выводит все числа и затем выводит только четные числа из этого списка.