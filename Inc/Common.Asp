<%
'************************************************************
'���ߣ��쳾����(SXY) ����ͨASP/PHP/ASP.NET/VB/JS/Android/Flash������/��������ϵ)
'��Ȩ��Դ������ѹ�����������;����ʹ�á� 
'������2016-09-22
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered by PAAJCMS 
'************************************************************
%>
<% 
'���ú�����ȫ (2013,9,27Option Explicit)
 
'�ɹ���Զ���ǻ����� 2013,10,4,�� 
 
'��ʾ�����Ի���20150312 
sub msgBox(byVal content)    
    content = replace(replace(content, chr(10), "\n"), chr(13), "\n") 
    response.write("<script>alert('" & content & "');</"&"script>")  
end sub 
'��ʾ20150729  
sub MBInfo(title, content) 
    call msgBox(title)   
end sub   
'��Queststring��ֵ  
sub addRq(gookeName, valueStr)  
    response.queryString(gookeName) = valueStr   
end sub  
'ASP�Դ�����ת
sub rr(url)
    response.redirect(url) 
end sub 
'�滻Request.Form����
function rf(str)
    rf = request.form(str) 
end function 
'��ô�ֵ
function rq(str)
    rq = request.queryString(str) 
end function 
'��ô�ֵ
function rfq(str)
    rfq = request(str) 
end function 
'����Post������ݴ��� д�����ݿ� ��ǿ��20160819
function ADSqlRf(inputName)
	dim s
	s=replace(request.form(inputName), "'", "''")
	if EDITORTYPE="jsp" then
		s=replace(s,"\","\\")
	end if
    ADSqlRf =s  
end function 
'������Access���ݿ�ֵ   ��������   ��ǿ��20160819
Function ADSql(valueStr) 
	dim s
	s=replace(valueStr, "'", "''")
	if EDITORTYPE="jsp" then
		s=replace(s,"\","\\")
	end if
    ADSql =s
End Function 
'�滻Response.Write����
sub rw(str)
    response.write(str) 
end sub 
'������ݼӻ���
sub rwBr(str)
    response.write(str & vbCrLf) 
end sub 
'�滻Response.Write���� + Response.End()
sub rwEnd(str)
    response.write(str) 
    response.end() 
end sub 
'HTML����
sub htmEnd(str)
    call rwEnd(str) 
end sub 
'�滻Response.Write����+Response.End()
sub die(str)
    call rwEnd(str) 
end sub 
'�滻Response.Write����
sub debug(str)
    response.write("<div  style=""border:solid 1px #000000;margin-bottom:2px;"">����" & str & "</div>" & vbCrLf) 
end sub 
'���� 
sub trace(str)
    call debug(str) 
end sub 
'������ʾ��Ϣ
sub echo(word, str)
    call echoPrompt(word, str) 
end sub 
'������ʾ��Ϣ+��ɫ
sub echoRed(word, str)
    response.write("<font color=red>" & word & "</font>��" & str & "<br>") 
end sub 
'������ʾ��Ϣ+��ɫ+��
sub echoRedB(word, str)
    response.write("<b><font color=red>" & word & "</font>��" & str & "</b><br>") 
end sub 
'������ʾ��Ϣ+��ɫ
sub echoYellow(word, str)
    response.write("<font color=#B38704>" & word & "</font>��" & str & "<br>") 
end sub 
'������ʾ��Ϣ+��ɫ+��
sub echoYellowB(word, str)
    response.write("<b><font color=#B38704>" & word & "</font>��" & str & "</b><br>") 
end sub 
'��������
sub echoPrompt(word, str)
    response.write("<font color=Green>" & word & "</font>��" & str & "<br>") 
end sub 
'��������
sub echoStr(word, str)
    call echoPrompt(word, str) 
end sub 
'��ӡ���� ��ӡPHP���õ�  ��ӡ [0] => aa [1] => bb [2] => cc
sub print_R(arrArray)
    dim i, c  
    if typeName(arrArray) = "Variant()" then
        for i = 0 to uBound(arrArray)
            c = c & "[" & i & "] => " & arrArray(i) & vbCrLf 
        next 
    else
        c = arrArray 
    end if 
    response.write(c) 
end sub 
'������ʾ��Ϣ ��ɫ
sub setColorEcho(color, word, str)
    response.write("<font color=" & color & ">" & word & "</font>��" & str & "<br>") 
end sub 
'������ʾ��Ϣ��ͣ
sub eerr(word, str)
    'Response.Write(TypeName(Word) & "-" & TypeName(Str)):Response.End()
    response.write("<font color=red>" & word & "</font>��" & str) 
    response.end() 
end sub 
'������������
sub doEvents()
    response.flush() 
end sub 
'����:ASP���IIF �磺IIF(1 = 2, "a", "b")
function IIF(bExp, sVal1, sVal2)
    if(bExp) then IIF = sVal1 else IIf = sVal2 
end function 
'Hr
sub hr()
    response.write("<hr size='1' color='#666666'> ") 
end sub 
'BR 20160517
sub br()
    response.write("<br/>") 
end sub 

'����ַ��� ���ñ���20141217
'Public Sub Echo(ByVal s) : Response.Write(s) : End Sub
'����ַ�����һ�����з�
sub print(byVal s)
    response.write(s & vbCrLf) : response.flush() 
end sub 
'����ַ�����һ��html���з�
sub println(byVal s)
    response.write(s & "<br />" & vbCrLf) : response.flush() 
end sub 
'����ַ�������HTML��ǩתΪ��ͨ�ַ�
sub printHtml(byVal s)
    response.write(replace(replace(s, "<", "&lt;"), ">", "&gt;") & vbCrLf)  
end sub
sub printlnHtml(byVal s) 
    response.write(replace(replace(s, "<", "&lt;"), ">", "&gt;") & "<br />" & vbCrLf)  
end sub 
'���������ֱ�����Ϊ�ַ���(Json��ʽ)
'Public Sub PrintString(ByVal s) : Response.Write(Str.ToString(s) & VbCrLf) : End Sub
'Public Sub PrintlnString(ByVal s) : Response.Write(Str.ToString(s)) & "<br />" & VbCrLf : End Sub
'���������ʽ�����ַ���
'Public Sub PrintFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & VbCrLf : End Sub
'Public Sub PrintlnFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & "<br />" & VbCrLf : End Sub
'����ַ�������ֹ��������
sub printEnd(byVal s)
    response.write(s) : response.end() 
end sub 
 



'�ж��Ƿ�һ����һ������checked,���߷��ؿ�ֵ
function setIsChecked(byVal str, byVal str2)
	setIsChecked=IIF(str = str2,"checked='checked'","")  
end function 
'�ж��Ƿ�һ����һ������selected,���߷��ؿ�ֵ 
function setIsSelected(byVal str, byVal str2)
	setIsSelected=IIF(str = str2,"selected='selected'","") 
end function  

'����������Ϣ If Err Then doError Err.Description, "Msg"
sub doError(s, msg)
    'On Error Resume Next
    dim nRnd, c 
    randomize 
    nRnd = cint(rnd() * 29252) '29252888
    c = "<br />" 
    c = c & "<div style=""width:100%; font-size:12px;;line-height:150%"">" 
    c = c & "  <label onClick=""ERRORDIV" & nRnd & ".style.display=(ERRORDIV" & nRnd & ".style.display=='none'?'':'none')"">" 
    c = c & "  <span style=""background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer"">�� ���� ��ʾ��Ϣ ERROR ��</span><br />" 
    c = c & "  </label>" 
    c = c & "  <div id=""ERRORDIV" & nRnd & """ style=""width:100%;border:1px solid #820222;padding:5px;overflow:hidden;"">" 
    c = c & " <span style=""color:#FF0000;"">��������</span> " & s & "<br />" 
    c = c & " <span style=""color:#FF0000;"">������Ϣ</span> " & msg & "<br />" 
    c = c & "  </div>" 
    c = c & "</div>" 
    c = c & "<br />" 
    response.write(c) 
    response.end()                                                                  '��ֹ������ֹͣ
end sub 

'ִ��ASP�ű�
function exec(byVal tStr)
    if tStr = "" then exit function : end if 
    on error resume next 
    execute(tStr) 
    on error goto 0 
end function 

%>   
