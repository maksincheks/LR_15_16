
type
  PNode = ^Node;
  Node = record
    Data: Integer;
    Next: PNode;
  end;

var
  Head, Current: PNode;
  MaxValue,i , MinValue: Integer;

procedure AddNode(var List: PNode; Value: Integer);
var
  newNode: PNode;
begin
  New(newNode);
  newNode^.Data := Value;
  newNode^.Next := List;
  List := newNode;
end;

//Находит максимальное и минимальное значения в списке. Изначально переменные Max и Min устанавливаются равными значению первого узла в списке. 
//Затем происходит перебор списка, и если значение текущего узла больше текущего максимального значения, 
//оно становится новым максимальным значением, а если меньше текущего минимального значения - новым минимальным.

procedure FindMinMaxInList(List: PNode; var Max, Min: Integer);
var
  Current: PNode;
begin
  
  Max := List^.Data;
  Min := List^.Data;

  // Поиск максимума и минимума в списке
  Current := List^.Next;
  while Current <> nil do
  begin
    if Current^.Data > Max then
      Max := Current^.Data
    else if Current^.Data < Min then
      Min := Current^.Data;

    Current := Current^.Next;
  end;
end;

begin
 Randomize;
  Head := nil;
  for i := 1 to 22 do
    AddNode(Head,Random(250)-100); 
  write('Числа ---> ');
  Current := Head;
  while Current <> nil do
  begin
    write(Current^.Data, ' ');
    Current := Current^.Next;
  end;
writeln;

  FindMinMaxInList(Head, MaxValue, MinValue);

  writeln('Максимальный элемент в списке --> ', MaxValue);
  writeln('Минимальный элемент в списке --> ', MinValue);
end.
//Эта программа создает односвязный список из 22 случайных целых чисел, выводит все числа и находит максимальное и минимальное значения в списке.