

type
  PNode = ^Node;
  Node = record
    Data: Integer;
    Next: PNode;
  end;

  PDeque = ^Deque; 
  Deque = record // Они определяют структуру deque (двусторонней очереди), основанную на связанном списке. В ней есть указатели на передний и задний узлы deque.
    Front, Rear: PNode;
  end;
// Эта процедура инициализирует deque, выделяя для него память и устанавливая его передний и задний указатели равными нулю.
procedure InitializeDeque(var D: PDeque);
begin
  New(D);
  D^.Front := nil;
  D^.Rear := nil;
end;
//Эта процедура добавляет новый узел с заданным значением в начало deque. 
//Она обрабатывает как случай, когда поле ввода пусто, так и случай, когда его нет, соответствующим образом обновляя передний указатель.

procedure EnqueueFront(var D: PDeque; Value: Integer); //доб эл-та в начало
var
  newNode: PNode;
begin
  New(newNode);
  newNode^.Data := Value;
  newNode^.Next := nil;

  if D^.Front = nil then
  begin
    D^.Front := newNode;
    D^.Rear := newNode;
  end
  else
  begin
    newNode^.Next := D^.Front;
    D^.Front := newNode;
  end;
end;
// Эта процедура добавляет новый узел с заданным значением в заднюю часть поля ввода. 
//Аналогично EnqueueFront, он обрабатывает как пустые, так и непустые случаи удаления.
procedure EnqueueRear(var D: PDeque; Value: Integer); //добавление эл-та в конец
var
  newNode: PNode;
begin
  New(newNode);
  newNode^.Data := Value;
  newNode^.Next := nil;

  if D^.Rear = nil then
  begin
    D^.Front := newNode;
    D^.Rear := newNode;
  end
  else
  begin
    D^.Rear^.Next := newNode;
    D^.Rear := newNode;
  end;
end;
//удаляет и возвращает значение из переднего узла deque.
// Если deque пуст, происходит ошибка, и программа завершается.
// Передний указатель обновляется на следующий узел, если он есть, иначе обновляется и задний указатель.
function DequeueFront(var D: PDeque): Integer;
var
  temp: PNode;
  value: Integer;
begin
  if D^.Front = nil then
  begin
    writeln('ERROR');
    Halt;
  end;

  temp := D^.Front;
  value := temp^.Data;
  D^.Front := temp^.Next;

  if D^.Front = nil then
    D^.Rear := nil;

  Dispose(temp);
  Result := value;
end;
//выполняет обратное чтение из файла и запись в другой файл. 
//Она инициализирует deque, считывает значения из файла, добавляет их в начало deque,
// а затем извлекает и записывает значения в обратном порядке в другой файл.
procedure rev(inputFileName, outputFileName: string);
var
  InputFile, OutputFile: TextFile;
  Value, i: Integer;
  Deque: PDeque;
begin
  InitializeDeque(Deque);

  AssignFile(InputFile, inputFileName);
  Reset(InputFile);
  AssignFile(OutputFile, outputFileName);
  Rewrite(OutputFile);

 while not EOF(InputFile) do
  begin
    Read(InputFile, Value);
    EnqueueFront(Deque, Value);
  end;

  while Deque^.Front <> nil do
  begin
    Value := DequeueFront(Deque);
    Write(OutputFile, Value, ' ');
  end;

  CloseFile(InputFile);
  CloseFile(OutputFile);
end;

begin
  rev('txt2.txt', 'txt22.txt');
end.
