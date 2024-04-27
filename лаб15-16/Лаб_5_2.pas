
type
  PNode = ^Node; // указатель на узел
  Node = record //сам узел
    word: string;
    count: Integer;
    next: PNode;
  end;
  
var
  F: Text;
  Head: PNode;
  en:= Encoding.GetEncoding(65001);

//Эта функция создает новый узел с указанным словом и инициализирует его счетчик повторений в 1.
function CreateNode(NewWord: string): PNode;
var
  NewNode: PNode;
begin
  New(NewNode);
  NewNode^.word := NewWord;
  NewNode^.count := 1;
  NewNode^.next := nil;
  Result := NewNode;
end;
//Процедура добавляет новый узел после указанного узла p в связанном списке.
procedure AddAfter(p, NewNode: PNode);
begin
  NewNode^.next := p^.next;
  p^.next := NewNode;
end;
// Процедура добавляет новый узел в начало списка.
procedure AddFirst ( var Head: PNode; NewNode: PNode );
begin
  NewNode^.next := Head;
  Head := NewNode;
end;
// Процедура добавляет новый узел перед указанным узлом p в связанном списке.

procedure AddBefore(var Head: PNode; p, NewNode: PNode);
var pp: PNode;
begin
  pp := Head;
  if p = Head then
    AddFirst ( Head, NewNode )  
  else begin
    while (pp <> nil)  and  (pp^.next <> p) do 
      pp := pp^.next;
    if pp <> nil then
      AddAfter(pp, NewNode); 
  end;
end;


// Эта функция находит место для вставки нового слова в алфавитном порядке. 
//Она возвращает указатель на узел, после которого следует вставить новое слово.
function FindPlace(Head: PNode; NewWord: string): PNode;
var pp: PNode;
begin
  pp := Head;
  while (pp <> nil) and (NewWord > pp^.word) do
    pp := pp^.next;
  Result := pp;
end;
//         Процедура читает слова из файла и строит словарь, поддерживая их упорядоченность по алфавиту. 
//         Если слово уже есть в словаре, увеличивается счетчик повторений. 
//         Иначе создается новый узел и вставляется в соответствующее место в списке.
procedure Dictionary(var Head: PNode; FileName: string);
var
  NewWord: string;
  CurrentNode, Place: PNode;
begin
  Assign(F, FileName);
  Reset(F, en);
  while not Eof(F) do
  begin
    ReadLn(F, NewWord);
    Place := FindPlace(Head, NewWord);
    if (Place = nil) or (Place^.word <> NewWord) then
    begin
      CurrentNode := CreateNode(NewWord);
      AddBefore(Head, Place, CurrentNode);
    end
    else
      Inc(Place^.count);
  end;
  Close(F);
end;

procedure frequency(Head: PNode); //выводит на экран список слов и их частоту повторений из словаря
var
  Current: PNode;
begin
  Current := Head;
  while Current <> nil do
  begin
    writeln(Current^.word, ': ', Current^.count);
    Current:=Current^.next;
  end;
end;

begin
  Head := nil; //так как список ещё не создан, то указываем его как пустой
  Dictionary(Head, 'text1.txt');
  frequency(Head);
end.
