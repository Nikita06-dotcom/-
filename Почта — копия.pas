uses System.Windows.Forms,System.Drawing,GraphABC,System.Net.Mail,System,System.IO;
const 
  SMTPServer = 'smtp.mail.ru'; 
var body, mail, pass, toReceiver: string;
    message: MailMessage;
    filetext, f: text;
    
    i, n: longint;
    h, m, s: integer;
begin
  //ВВЕДЕНИЕ
  assign(f,'C:\PABCWork.NET\baza\Отчёт.txt');
  rewrite(f);
  Writeln( f, 'Это рассылщик писем по интернет почте. Файл, в котором присудствуют все нужные адреса, должен быть отформатирован таким образом: все адреса идут вниз с начала строки, в начале должно стоять одно число, показывающие кол-во этих самых адресов, НЕ ДОЛЖНО БЫТЬ ПУСТЫХ СТРОЧЕК!!!' );
  Writeln( f ); Writeln( f, 'Журнал действий' );
  //НЕИЗМЕНЯЕМАЯ ЧАСТЬ
  mail:='****';//здесь свой логин, то что в адресе до @
  pass:='****';//пароль к своему ящику в mail.ru
  var fromSender := mail + '@mail.ru';
  
  assign(filetext,'C:\PABCWork.NET\baza\4.txt');
  reset(filetext);
  readln(filetext, n);
  //ПОДКЛЮЧЕНИЕ
  var smtp := New SmtpClient(SMTPServer, 587); //Адрес сервера: smtp.mail.ru Использовать аутентификацию: Да Порт с шифрованием: 465 Порт без шифрования: 25, 587, 2525
  smtp.EnableSSL:= True;
 
  smtp.EnableSSL:= True; // использовать SSL
  smtp.DeliveryMethod := SmtpDeliveryMethod.Network; // по сети на smtp
  
  //ИЗМЕНЯЕМАЯ ЧАСТЬ
  for i:= 1 to n do
  begin
    h:= System.DateTime.Now.Hour;   m:= System.DateTime.Now.Minute;   s:= System.DateTime.Now.Second;
    var subject := 'Привет, это моя программа, рассылающая на адреса в интерет почте сообщения. Время, в которое это письмо было отпралено, с моего ПК: ' + h + ':' + m + ':' + s + ' . Кстати, это письмо по счету: ' + i + ' из ' + n + ' . Если прочитал, напиши мне об этом). Это всё, пока пока!))';//это текст сообщения
    readln(filetext, toReceiver);
    
    message := MailMessage.Create(fromSender, toReceiver, subject, body);
    Message.IsBodyHtml:= True;
    smtp.Credentials := New System.Net.NetworkCredential(mail, pass);
    smtp.Send( message );
    message.Dispose;
    Writeln(f); Writeln( f, toReceiver ); Writeln( f, '    Рассылка успешно отправлена в ', System.DateTime.Now );
  end;
  Writeln(f); Writeln( f, '!РАССЫЛКА ПИСЕМ ОКОНЧЕНА!' );
  close(f);
  halt;
end.
