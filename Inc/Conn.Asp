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
Public MDBPath, accessPass                                     '���ݿ�·�������� 


'���SqlServer�����Ƿ�ɹ�
function checkSqlServer(byval connStr)
	dim conn
	checkSqlServer=true
	on error resume next
	Set conn = CreateObject("Adodb.Connection")  
	conn.Open connStr 
	if err<>0 then
		checkSqlServer=false
	end if
end function

'�����ݿ�
Public Sub openConn()
    Dim connStr 
    If Request("MDBPath") <> "" And isNul(Request("MDBPath")) = False Then
        MDBPath = handlePath(Request("MDBPath")) 
    End If 
    'call eerr("",MDBPath)
	
	'����sqlserver���ݿ�
	if databaseType = "sqlserver" then
        connStr = " Password = " & sqlServerPassword & "; user id =" & sqlServerUsername & "; Initial Catalog =" & sqlServerDatabaseName & "; data source =" & sqlServerHostIP & ";Provider = sqloledb;" 
		if checkSqlServer(connStr)=false then
			call eerr("SqlServer���ݿ����ӳ���", "<a href='/inc/install.asp'>����������ݿ�</a>")
		end if
        Set conn = CreateObject("Adodb.Connection")
		conn.Open connStr 
	
    '����MMD���ݿ�
	else
		if MDBPath="" or checkFile(MDBPath)=false then
			call eerr("Access���ݿⲻ����", "<a href='/inc/install.asp'>����������ݿ�</a>")
		end if
        If InStr(MDBPath, ":") = 0 Then MDBPath = Server.MapPath(Replace(MDBPath, "//", "/")) 
		 
		
        Set conn = CreateObject("Adodb.Connection")
		'call eerr("MDBPath",MDBPath)
        conn.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & accessPass & "';Data Source = " & MDBPath 
    End If

    '�Ӹ��ж�Ŀ����Ϊ���ظ����ã�����ʱ����� ��GetRecordCount(Table, AddSql)   20150313
    If TypeName(rs) <> "Recordset" Then
		Set rs = CreateObject("Adodb.RecordSet")
		Set rsx = CreateObject("Adodb.RecordSet")
		Set rss = CreateObject("Adodb.RecordSet")
		Set rst = CreateObject("Adodb.RecordSet")
		Set rsd = CreateObject("Adodb.RecordSet")
		Set tempRs = CreateObject("Adodb.RecordSet")
		Set tempRs2 = CreateObject("Adodb.RecordSet")
		Set rsTemp = CreateObject("Adodb.RecordSet")
    End If
End Sub 
'�ر����ݿ�
Function closeConn()
    On Error Resume Next 
    conn.Close 
    Set conn = Nothing 
End Function 
'������ݿ���  ThisConn=GetAccessConn(ThisConn,ThisMDBPath,"")
Function getAccessConn(accessConn, thisMDBPath, thisAccessPass)
    thisMDBPath = handlePath(Request("ThisMDBPath")) 
    Set accessConn = CreateObject("Adodb.Connection")
        accessConn.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & thisAccessPass & "';Data Source = " & thisMDBPath 
        getAccessConn = accessConn 
End Function
%> 
