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
'Access (2013,10,22)   ��Ҫ�����£�̫��̫��(20151117)


'===================================== SQl�������� =====================================





'������Access���ݿ�ֵ (20151116)  �÷� conn.execute("update product set content='"& AD(c) &"'")
function handleAccessData(byVal valueStr)
    handleAccessData = replace(valueStr, "'", "''") 
end function 

'�ж����ݿ�����
function checkAccessPass(MDBPath, accessPass)
    on error resume next 
    dim conn 
    checkAccessPass = true 
    set conn = createObject("Adodb.Connection")
        conn.open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & accessPass & "';Data Source = " & MDBPath 
        conn.close 
        if err <> 0 then
            err.clsoe 
            checkAccessPass = false 
        end if 
end function
'�ж�SQl�Ƿ���ȷ
function checkSql(sql)
    on error resume next 
    conn.execute(sql) 
    checkSql = IIF(err = 0, true, false) 
end function 
'������
function createTable(tableName)
    dim sql 
    if checkSql(tableName) = false then
        sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key)" 
        conn.execute(sql) 
        createTable = true 
    else
        createTable = false 
    end if 
end function 
'�жϱ��Ƿ���ʾ ���������
function showIsTable(tableName)
    showIsTable = existsTable(tableName) 
    if showIsTable = false then
        call rw("������[" & tableName & "]�ɹ���<br>") 
    else
        call rw("��[" & tableName & "]�Ѿ�����<br>") 
    end if 
end function 
'��¼���� �ܼ�¼�����ж��Ƿ��м�¼
function getRecordCount(tableName, addSql)
    'Call Eerr("","Select Count(*) From [" & Table & "]" & AddSql)
    call OpenConn() 
    getRecordCount = conn.execute("Select Count(*) From [" & tableName & "] " & addSql)(0) 
end function 
function tableCount(table, addSql)
    tableCount = getRecordCount(table, addSql) 
end function 
'�򿪱�RsOpenTable
function openTable(tableName, addSql)
    rs.open "Select * From [" & tableName & "] " & addSql, conn, 1, 1 
end function 
'�������
function insertTable(tableName, tableFields, values)
    conn.execute("Insert Into[" & tableName & "](" & tableFields & ") Values('" & values & "')") 
end function 
'��ʾ���ֶ�����
function getTableText(tableName, fieldName, addSql)
    on error resume next 
    getTableText = conn.execute("Select " & fieldName & " From [" & tableName & "]" & addSql)(0) 
    if err.number <> 0 then call eerr("������", tableName & "-" & fieldName & "-" & addSql) 
end function 
'����Mdb
function createMdb(accessPath)
    dim conn 
    accessPath = handlePath(accessPath) 
    set conn = createObject("ADOX.Catalog")
        conn.create("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & accessPath) 
        createMdb = "�������ݿ�[" & accessPath & "]�ɹ���<br>" & vbCrLf 
    set conn = nothing 
end function 
'ɾ����
function deleteTable(tableName)
    tableName = trim(tableName) 
    deleteTable = false 
    if tableName = "" then
        exit function 
    end if 
    if checkTable(tableName) then
        deleteTable = true 
    end if 
    'Conn.Execute("Drop Table [" & Table & "]")
'End If
end function 
'ɾ��ȫ����
function deleteAllTable(tableList)
    dim splStr, tableName, c 
    splStr = split(tableList, vbCrLf) 
    for each tableName in splStr
        if c <> "" then c = c & vbCrLf 
        c = c & "ɾ������" & tableName & "��" & deleteTable(tableName) 
    next 
    deleteAllTable = c 
end function 

'�жϱ�
function checkTable(tableName)
    on error resume next 
    conn.execute("Select * From [" & tableName & "]") 
    if not err.number = 0 then
        err.clear                                                                       '����ô���
        checkTable = false 
    else
        checkTable = true 
    end if 
end function
'�жϱ�������ʾ�Ƿ���ڷ�
function checkTable_show(tableName)
	checkTable_show=checkTable(tableName)
	if checkTable_show=true then
        call rw("��[" & tableName & "]�Ѿ�����<br>")		
	else
        call rw("������[" & tableName & "]�ɹ���<br>")
	end if
end function

'�������� (����)
function existsTable(table)
    existsTable = checkTable(table) 
end function 
'�޸ı���
function editTable(db, tableName, newTable)
    dim connStr, oCat, oTbl 
    editTable = false 
    if checkTable(tableName) and checkTable(newTable) = false then
        connStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & db 
        set oCat = createObject("ADOX.Catalog")
            oCat.activeConnection = connStr 
            set oTbl = createObject("ADOX.Table")
                set oTbl = oCat.tables(tableName)                                               'Ҫ�������ı�����OldTable
                    oTbl.name = newTable                                                            '�±���
                set oCat = nothing 
            set oTbl = nothing 
            editTable = true 
        set oCat = nothing 
    end if 
end function 
'�ж��ֶ�
function checkField(tableName, fieldName)
    checkField = false 
    if checkTable(tableName) then
        on error resume next 
        conn.execute("Select " & fieldName & " From [" & tableName & "]") 
        if not err.number = 0 then
            err.clear                                                                       '����ô���
            checkField = false 
        else
            checkField = true 
        end if 
        err.clear 
    end if 
end function 
'�������� (����)
function existsField(table, fieldName)
    existsField = checkField(table, fieldName) 
end function 
'�޸��ֶ�,
function editField(tableName, fieldName, toFieldName)
    'On Error Resume Next
    dim fieldType 
    editField = false 
    if checkTable(tableName) then
        if checkField(tableName, toFieldName) = false and checkField(tableName, fieldName) then
            fieldType = getFieldAlt(tableName, fieldName) 
            if fieldType <> "" then
                'MsgBox (tableName & vbCrLf & FieldName & vbCrLf & ToFieldName & "����" & FieldType)
                conn.execute("Alter Table [" & tableName & "] Add [" & toFieldName & "] " & fieldType & "") '�����ֶ�
                conn.execute("Update [" & tableName & "] Set " & toFieldName & "=[" & fieldName & "]") '��A�ֶ����ݸ��Ƶ�B�ֶ�������
                conn.execute("Alter Table [" & tableName & "] Drop [" & fieldName & "]") 'ɾ���ֶ�
            end if 
            if err.number <> 0 then msgBox(tableName & vbCrLf & fieldName & vbCrLf & toFieldName & "����" & fieldType) 
        end if 
    end if 
end function
'׷���ַ�
function addField(tableName,fieldName,fieldType)
	if fieldType="" then
		fieldType="VarChar"
	end if
	if checkField(tableName,fieldName) = false then
		conn.execute("Alter Table [" & tableName & "] Add [" & fieldName & "] " & fieldType & "") '�����ֶ�
	end if

end function
'����ֶ�����
function getFieldAlt(tableName, fieldName)
    dim n, fn, fld, rs 
    set rs = createObject("Adodb.RecordSet")
        rs.open "Select * From [" & tableName & "]", conn, 1, 1 
        fn = rs.fields.count 
        for n = 1 to fn - 1
            set fld = rs.fields.item(n)
                if lcase(fieldName) = lcase(fld.name) then
                    'MsgBox (FieldName & vbCrLf & Rs.Fields(N).Type)
                    select case rs.fields(n).type
                        case "202"
                            getFieldAlt = "VarChar" 
                        case "203"
                            getFieldAlt = "Text" 
                        case "7"
                            getFieldAlt = "DateTime" 
                        case "3"
                            getFieldAlt = "Int" 
                        case "11"
                            getFieldAlt = "YesNo" 
                        case "5"
                            getFieldAlt = "float" 
                        case else
                            msgBox(rs.fields(n).type & vbCrLf & fieldName & "û������") 
                            getFieldAlt = "û����" & rs.fields(n).type 
                    end select
                    exit for 
                end if 
            set fld = nothing 
        next : rs.close 
end function
'���ָ�����ݿ�����б�
function getTableList_Conn(conn)
    dim s, c, rs 
    set rs = conn.openSchema(20)
        rs.moveFirst 
        do until rs.EOF
            if rs("TABLE_TYPE") = "TABLE" then
                s = rs("TABLE_NAME") 
                if c <> "" then c = c & vbCrLf 
                c = c & s 
            end if 
            rs.moveNext 
        loop 
        getTableList_Conn = c 
end function
'������ݿ���б�
function getTableList()
    getTableList = getTableList_Conn(conn) 
end function 
'��ñ��ֶ��б�
function getFieldList(tableName)
    dim fn, c, fld, n 
    on error resume next 
    '�ֶ�
    tempRs.open "Select * From [" & tableName & "]", conn, 1, 1 
    if tempRs.fields.count = 0 then exit function                                   'Ϊ���˳�
    fn = tempRs.fields.count 
    if err <> 0 then call eerr("�ֶ�", tempRs.fields.count) 
    c = "," 
    for n = 1 to fn - 1
        set fld = tempRs.fields.item(n)
            c = c & fld.name & "," 
        set fld = nothing 
    next : tempRs.close 
    getFieldList = c 
end function 
'��ñ��ֶ������б�20160226
function getFieldConfigList(tableName)
    dim fn, c, fld, n, s 
    on error resume next 
    '�ֶ�
    tempRs.open "Select * From [" & tableName & "]", conn, 1, 1 
    if tempRs.fields.count = 0 then exit function                                   'Ϊ���˳�
    fn = tempRs.fields.count 
    if err <> 0 then call eerr("�ֶ�", tempRs.fields.count) 
    c = "," 
    for n = 1 to fn - 1
        set fld = tempRs.fields.item(n)
            'call echo(fld.name,Fld.Type)
            '5ΪFloat
            if fld.type = 3 or fld.type = 5 or fld.type = 11 then                           '201Ϊsqlserver
                s = "|numb|0" 
            elseif fld.type = 7 or fld.type = 135 then                                      '135Ϊsqlserver
                s = "|time|" 
            elseif fld.type = 203 or fld.type = 201 then                                    '201Ϊsqlserver
                s = "|textarea|" 
            else
                s = "||" 
            end if 
            c = c & fld.name & s & "," 

        set fld = nothing 
    next : tempRs.close 
    getFieldConfigList = c 
end function 
'��ò�ͬ���ݿ���ֶ��б� (.mdb Or .xls)
function getDifferentTableFieldList(connObj, table)
    dim fn, c, fld, n 
    '�ظ���������ݿ�
    if typeName(connObj) = "Connection" then
        set conn = createObject("Adodb.Connection")
            conn.open(connObj) 
    end if
    '�ֶ�
    rs.open "Select * From [" & table & "]", conn, 1, 1 
    fn = rs.fields.count 
    c = "," 
    for n = 1 to fn - 1
        set fld = rs.fields.item(n)
            c = c & fld.name & "," 
        set fld = nothing 
    next : rs.close 
    getDifferentTableFieldList = c 
end function 
'Call Echo("ѹ�����ݿ�", CompactDB("D:\��������\html1\Admin\Data\Data.mdb", False))
'=====================ѹ������========================= boolIs97 �������û��ʲô��
'ѹ�����ݿ�
function compactDB(dBPath, boolIs97)
    dim fso, engine, strDBPath, JET_3X 
    dBPath = handlePath(dBPath) 
    strDBPath = left(dBPath, inStrRev(dBPath, "\")) 
    set fso = createObject("Scripting.FileSystemObject")
        if fso.fileExists(dBPath) then
            fso.copyFile dBPath, strDBPath & "temp.mdb" 
            set engine = createObject("JRO.JetEngine")
                if boolIs97 = true then
                    engine.compactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp.mdb", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp1.mdb;" & "Jet OLEDB:Engine Type=" & JET_3X 
                else
                    engine.compactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp.mdb", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp1.mdb" 
                end if 
                fso.copyFile strDBPath & "temp1.mdb", dBPath 
                fso.deleteFile(strDBPath & "temp.mdb") 
                fso.deleteFile(strDBPath & "temp1.mdb") 
            set engine = nothing 
            compactDB = "<font color=#FF0000><b>������ݿ�, " & dBPath & ", �Ѿ�ѹ���ɹ�!</b></font>" & vbCrLf 
        else
            compactDB = "<font color=#FF0000><b>���ݿ����ƻ�·������ȷ. ������!</b></font>" & vbCrLf 
        end if 
    set fso = nothing 
end function 
'�޸����ݿ���������
function editAccessPassWord(dBPath, oldPass, newPass)
    dim path, miJRO 
    set miJRO = createObject("JRO.JetEngine")
        call handlePath(dBPath)                                                         '�������·��
        path = "Test_News.Mdb" 
        call handlePath(path)                                                           '�������·��
        call deleteFile(path) 
        on error resume next 
        miJRO.compactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dBPath & ";Jet OLEDB:Database Password=" & oldPass, "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & path & ";Jet OLEDB:Database Password=" & newPass 
        if err.number <> 0 then editAccessPassWord = "�������" : err.clear : exit function 
        call deleteFile(dBPath)                                                         'ɾ�����ݿ�
        call MoveFile(path, dBPath)                                                     '�ƶ������ݿ�
        editAccessPassWord = "�޸ĳɹ���������Ϊ[" & newPass & "]" 
    set miJRO = nothing 
end function 

'====================================================================
'���ݿ� ���뵼������ Call ExportToExcel(GetDataTableList("Product","")) �ѱ�����xls��Ϸ���


'Excel�������� Call ExportToExcel("�����б�")
sub exportToExcel(tableContent)
    response.contentType = "application/vnd.ms-Excel" 
    response.addHeader "Content-Disposition", "attachment;Filename=Results.xls" 
    response.write("<body>" & vbCrLf) 
    response.write(tableContent & vbCrLf) 
    response.write("</body>" & vbCrLf) 
    response.write("</html>" & vbCrLf) 
end sub 
'���뵽���ݿ��� ������
sub importToDatabase()
    '��XML
    dim xlsFile, xmlConn, xmlRs 
    xlsFile = server.mapPath("1.xls") 
    set xmlConn = createObject("Adodb.Connection")
        xmlConn.open "Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=Excel 8.0;Data Source=" & xlsFile 
        set xmlRs = createObject("Adodb.RecordSet")
            '��MDB
            dim mdbFile, mdbConn, mdbRs 
            mdbFile = server.mapPath("" & adminDir & "Data/Data.mdb") 
            set mdbConn = createObject("Adodb.Connection")
                mdbConn.open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '';Data Source = " & mdbFile 
                set mdbRs = createObject("Adodb.RecordSet")

                    '���xlsȫ���ֶ�
                    dim fn, n, fld, xlsFieldList 
                    xmlRs.open "Select * From [Excel$]", xmlConn, 1, 1 
                    fn = xmlRs.fields.count 
                    for n = 1 to fn - 1
                        set fld = xmlRs.fields.item(n)
                            xlsFieldList = xlsFieldList & fld.name & "," 
                        set fld = nothing 
                    next : xmlRs.close 
                    call echo("xlsFieldList", xlsFieldList) 
                    '��xls���ݵ���mdb
                    dim splStr, fieldName 
                    splStr = split(xlsFieldList, ",") 
                    xmlRs.open "Select * From [Excel$]", xmlConn, 1, 1 
                    call echo("xls��������", xmlRs.recordCount) 
                    'On Error Resume Next
                    while not xmlRs.EOF
                        mdbRs.open "Select * From [Product]", mdbConn, 1, 3 
                        mdbRs.addNew 
                        for each fieldName in splStr
                            fieldName = trim(fieldName) 
                            if fieldName <> "" then
                                call echo("��ʾ�ֶ�", fieldName) 
                                doevents 
                                mdbRs(fieldName) = xmlRs(fieldName) 
                            end if 
                        next 
                        call echo("���Ӽ�¼", "") 
                        'Call Rw("<hr>")
                        mdbRs.update : mdbRs.close 
                    xmlRs.moveNext : wend : xmlRs.close 
end sub
'������ݱ��б� GetDataTableList("Product")
function getDataTableList(tableName, addSql)
    dim dataFieldList, splStr, i, c, fieldName 
    c = c & "<table width=""100%"" border=""1"" cellspacing=""0"" cellpadding=""0"">" & vbCrLf 
    'Call OpenConn()         '�����ݿ�
    dataFieldList = getFieldList(tableName) 
    'Call Echo(TableName & "�ַ��б�",DataFieldList)
    splStr = split(dataFieldList, ",") 
    c = c & "  <tr>" & vbCrLf 
    for i = 1 to uBound(splStr) - 1
        c = c & "    <td>" & splStr(i) & "</td>" & vbCrLf 
    next 
    c = c & "  </tr>" & vbCrLf 

    rs.open "Select * From [" & tableName & "] " & addSql, conn, 1, 1 
    while not rs.EOF
        c = c & "  <tr>" & vbCrLf 
        for each fieldName in splStr
            if fieldName <> "" then
                c = c & "    <td>" & rs(fieldName) & "</td>" & vbCrLf 
            end if 
        next 
        c = c & "  </tr>" & vbCrLf 
    rs.moveNext : wend : rs.close 
    c = c & "</table>" & vbCrLf 
    getDataTableList = c 
end function 
'����׷���ֶ�   �� Call Echo("׷���ֶ�",SetTableField("Admin,aa,Int Default 1|Admin,bb,VarChar(255) Default 'str'|"))
function setTableField(conn, content)
    dim splStr, splxx, i, s, c, tableName, fieldName, sql 
    splStr = split(content, "|") 
    for i = 0 to uBound(splStr)
        s = splStr(i) 
        if s <> "" then
            splxx = split(s, ",") 
            tableName = splxx(0) 
            fieldName = splxx(1) 
            on error resume next 
            sql = "alter table " & tableName & " add column " & fieldName & " " & splxx(2) & "" 
            conn.execute sql 
            if err.number = 0 then
                c = c & "[��" & tableName & "]���ֶ�" & fieldName & "���������ֶγɹ�<hr>" & vbCrLf 
            else
                err.close 
                c = c & "[��" & tableName & "]���ֶ�" & fieldName & "������ʧ��<hr>" & vbCrLf 
            end if 
        end if 
    next 
    setTableField = c 
end function 

'�˺����Ὣ recordset ��λ���ʹ���ת��Ϊ�׶���Ӣ��ʶ���� �������ù�������Ӧ��
function getTypeString(typeId)
    select case typeId
        case 0 : getTypeString = "Empty"
        case 16 : getTypeString = "TinyInt"
        case 2 : getTypeString = "SmallInt"
        case 3 : getTypeString = "Int"
        case 20 : getTypeString = "BigInt"
        case 17 : getTypeString = "UnsignedTinyInt"
        case 18 : getTypeString = "UnsignedSmallInt"
        case 19 : getTypeString = "UnsignedInt"
        case 21 : getTypeString = "UnsignedBigInt"
        case 4 : getTypeString = "Single"
        case 5 : getTypeString = "Double"
        case 6 : getTypeString = "Currency"
        case 14 : getTypeString = "Decimal"
        case 131 : getTypeString = "Numeric"
        case 11 : getTypeString = "Bit"
        case 10 : getTypeString = "Error"
        case 132 : getTypeString = "UserDefined"
        case 12 : getTypeString = "Variant"
        case 9 : getTypeString = "IDispatch"
        case 13 : getTypeString = "IUnknown"
        case 72 : getTypeString = "GUID"
        case 7 : getTypeString = "Date"
        case 133 : getTypeString = "DBDate"
        case 134 : getTypeString = "DBTime"
        case 135 : getTypeString = "Datetime"
        case 8 : getTypeString = "BSTR"
        case 129 : getTypeString = "Char"
        case 200 : getTypeString = "VarChar"
        case 201 : getTypeString = "LongVarChar"
        case 130 : getTypeString = "WChar"
        case 202 : getTypeString = "Text"
        case 203 : getTypeString = "Memo"
        case 128 : getTypeString = "Binary"
        case 204 : getTypeString = "VarBinary"
        case 205 : getTypeString = "LongVarBinary"
        case else : getTypeString = "Unknown Type"
    end select
end function 
'��ò�Ʒָ���������ID�б�
function getProductRndIdList(rs, nItem)
    dim nCount, i, j, rndIdList, pidList, nOK, id, splxx 
    'ִ�м���
    nCount = rs.recordCount 
    nItem = CInt(nItem)                                                             'ת����������
    nOK = 0 
    randomize timer                                                                 '��ʼ�������������
    'ѭ������
    for j = 1 to 3
        for i = 1 to nCount
            id = int(rnd * nCount + 1) 
            if inStr("," & rndIdList & ",", "," & id & ",") = false then
                rndIdList = rndIdList & id & "," 
                nOK = nOK + 1 
                if nOK >= nItem then
                    'Call Eerr(RndIdList &"nOK=" & nOK,"nItem=" & nItem)
                    exit for 
                end if 
            end if 
        next 
        if nOK >= nItem then exit for 
    next 
    '��ò�ƷID
    splxx = split(rndIdList, ",") 
    for i = 1 to nCount
        if inStr("," & rndIdList & ",", "," & i & ",") > 0 then
            pidList = pidList & rs(0) & "," 
        end if 
    rs.moveNext : next 
    if pidList <> "" then pidList = left(pidList, len(pidList) - 1) 
    getProductRndIdList = pidList 
'Call Eerr(RndIdList,PidList)
end function 
'���ĳ�ֶ����� 20150129  ����getFieldValue("WebSite","WebTitle","")     '�����վ����
function getFieldValue(tableName, fieldName, addSql)
    dim rs 
    call OpenConn() 
    set rs = createObject("Adodb.RecordSet")
        rs.open "Select * From [" & tableName & "] " & addSql, conn, 1, 1 
        if not rs.EOF then
            getFieldValue = rs(fieldName) 
        end if : rs.close 
end function
'���ָ���ֶ����ݡ�ָ��Conn����
function getConnFieldValue(objConn, tableName, fieldName, addSql)
    on error resume next 
    dim rs 
    set rs = createObject("Adodb.RecordSet")
        rs.open "Select * From [" & tableName & "] " & addSql, objConn, 1, 1 
        if not rs.EOF then
            'Call Echo(TableName, FieldName):Doevents
            getConnFieldValue = rs(fieldName) 
        end if : rs.close 
        if err <> 0 then call eerr(tableName, fieldName) 
end function
'��ĳ�ֶ�д���� 20150129  ����Call setFieldValue("WebSite","WebTitle","�й���","")     '������վ����
function setFieldValue(tableName, fieldName, writeValue, addSql)
    dim rs 
    call OpenConn() 
    setFieldValue = false 
    set rs = createObject("Adodb.RecordSet")
        rs.open "Select * From [" & tableName & "] " & addSql, conn, 1, 3 
        if not rs.EOF then
            rs(fieldName) = writeValue 
            rs.update 
            setFieldValue = true 
        end if : rs.close 
end function

'�ļ�������д�����ݿ�20150312 Call FileBinaryAddAccess(Conn,"Admin","test1","","","UploadFiles\testimages2015_source.jpg")
function fileBinaryAddAccess(conn, tableName, fieldName, id, addSql, filePath)
    dim sql, rs 
    set rs = createObject("Adodb.RecordSet")
        sql = "Select " & fieldName & " From [" & tableName & "]" 
        sql = getWhereAnd(sql, addSql) 
        if id <> "" then
            sql = getWhereAnd(sql, "Where Id=" & id) 
        end if 
        rs.open sql, conn, 1, 3 
        if not rs.EOF then
            rs(fieldName).appendChunk getFileBinaryContent(filePath) 
            'Call eerr(sql,filepath):Doevents
            rs.update 
        end if : rs.close 
end function
'��ʾ���ݿ�ָ���ֶ�����������20150312 Call ShowAccessStream(Conn,"Admin","test1","","")
function showAccessStream(conn, tableName, fieldName, id, addSql)
    dim sql, rs 
    set rs = createObject("Adodb.RecordSet")
        sql = "Select " & fieldName & " From [" & tableName & "]" 
        sql = getWhereAnd(sql, addSql) 
        if id <> "" then
            sql = getWhereAnd(sql, "Where Id=" & id) 
        end if 
        rs.open sql, conn, 1, 3 
        if not rs.EOF then
            'Response.ContentType = "img/*"
            response.binaryWrite rs(fieldName).getChunk(7500000) 
        end if : rs.close 
end function
%>      
