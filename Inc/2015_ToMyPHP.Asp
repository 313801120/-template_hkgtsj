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
'��phpͨ��   �ҵĺ�̨

'�����վ�ײ�����aa 
Function XY_AP_WebSiteBottom(action)
	dim s,url
	If InStr(cfg_webSiteBottom, "[$aoutadd$]") > 0 Then
        cfg_webSiteBottom = getDefaultValue(action)                                     '���Ĭ������
        conn.Execute("update " & db_PREFIX & "website set websitebottom='" & ADSql(cfg_webSiteBottom) & "'") 
    End If 
	
	s=cfg_webSiteBottom
	'��վ�ײ�
	If Request("gl") = "edit" Then 
		s = "<span>" & s & "</span>" 
	End If 
	url = WEB_ADMINURL & "?act=addEditHandle&switchId=2&id=*&actionType=WebSite&lableTitle=վ������&n=" & getRnd(11) 
	s = handleDisplayOnlineEditDialog(url, s, "", "span") 	 
	
    XY_AP_WebSiteBottom = s 
End Function  

'asp��php�汾
function XY_EDITORTYPE(action)
	dim aspValue,phpValue,aspxValue,s
	aspValue = LCase(RParam(action, "asp")) 
	phpValue = LCase(RParam(action, "php")) 
	aspxValue = LCase(RParam(action, "aspx")) 
	if EDITORTYPE="asp" then
		s=aspValue
	elseif EDITORTYPE="aspx" then
		s=aspxValue
	else
		s=phpValue
	end if
	XY_EDITORTYPE=s
end function


'�����ļ�
Function XY_Include(action)
    Dim templateFilePath, Block, startStr, endStr, content 
    templateFilePath = LCase(RParam(action, "File")) 
    Block = LCase(RParam(action, "Block")) 

    Dim findstr, replaceStr                                                         '�����ַ����滻�ַ�
    findstr = moduleFindContent(action, "findstr")                                  '���ҿ�
    replaceStr = moduleFindContent(action, "replacestr")                            '���ҿ�

    templateFilePath = handleFileUrl(templateFilePath)                              '�����ļ�·��
    If checkFile(templateFilePath) = False Then
        templateFilePath = cfg_webTemplate & "/" & templateFilePath 
    End If 
    content = getFText(templateFilePath) 
    If Block <> "" Then
        startStr = "<!--#" & Block & " start#-->" 
        endStr = "<!--#" & Block & " end#-->" 
        If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
            content = strCut(content, startStr, endStr, 2) 
        End If 
    End If 
    '�滻������������
    If findstr <> "" Then
        content = Replace(content, findstr, replaceStr) 
    End If 

    XY_Include = content 
End Function 

'��Ŀ�˵�
Function XY_AP_ColumnMenu(action)
    Dim defaultStr, thisId, parentid,c,s
    parentid = Trim(RParam(action, "parentid"))
	parentid=getColumnId(parentid)
	
    If parentid = "" Then parentid = "-1" 

    thisId = glb_columnId 
    If thisId = "" Then thisId = "-1" 
    defaultStr = getDefaultValue(action)                                            '���Ĭ������
	
	defaultStr=defaultStr & "[topnav]"& parentid &"[/topnav]"
    XY_AP_ColumnMenu = showColumnList( parentid, "webcolumn", "columnname",thisId , 0, defaultStr)
 
End Function 



'��ʾ��Ŀ�б�
Function XY_AP_ColumnList(action)
    Dim sql, flags, addSql, columnname 
    sql = RParam(action, "sql") 
    flags = RParam(action, "flags") 
    addSql = RParam(action, "addSql") 
    columnname = RParam(action, "columnname") 
    If flags <> "" Then
        sql = " where flags like'%" & flags & "%'" 
    End If 
    If columnname <> "" Then
        sql = getWhereAnd(sql, "where parentid=" & getColumnId(columnname)) 
    'call echo(sql,columnName)
    End If 
    '׷��sql
    If addSql <> "" Then
        sql = getWhereAnd(sql, addSql) 
    End If 
    XY_AP_ColumnList = XY_AP_GeneralList(action, "WebColumn", sql) 

End Function 

'��ʾ�����б�
Function XY_AP_ArticleList(action)
    Dim sql, addSql, columnName, columnId, nTopNumb, idRand, splStr, s, columnIdList 
    action = replaceGlobleVariable(action)                                          '�������滻��ǩ
    sql = RParam(action, "sql") 
    s = RParam(action, "topNumb")
	nTopNumb=IIF(s="",0,cInt(s))


    'id���
    idRand = LCase(RParam(action, "rand")) 
    If idRand = "true" Or idRand = "1" Then
        sql = sql & " where id in(" & getRandArticleId("", nTopNumb) & ")" 
    End If 

    '��Ŀ���� ����Ŀ���鴦���� ģ���������[Array]CSS3[Array]HTML5
    s = RParam(action, "columnName") 
    If s = "" Then
        s = RParam(action, "did") 
    End If 
    If s <> "" Then
        splStr = Split(s, "[Array]") 
        For Each columnName In splStr
            columnId = getColumnId(columnName) 
            If columnId <> "" Then
                If columnIdList <> "" Then
                    columnIdList = columnIdList & "," 
                End If 
                columnIdList = columnIdList & columnId 
            End If 
        Next 
    End If 
    If columnIdList <> "" Then
        sql = getWhereAnd(sql, "where parentId in(" & columnIdList & ")") 
    End If 
    '׷��sql
    addSql = RParam(action, "addSql") 
	'call echo("addsql",addsql)
    If addSql <> "" Then
        sql = getWhereAnd(sql, addSql) 
    End If 
    sql = replaceGlobleVariable(sql) 
    'call echo(RParam(action, "columnName") ,sql)
    XY_AP_ArticleList = XY_AP_GeneralList(action, "ArticleDetail", sql) 
End Function 

'��ʾ�����б�
Function XY_AP_CommentList(action)
    Dim itemID, sql, addSql 
    addSql = RParam(action, "addsql") 
    itemID = RParam(action, "itemID") 
    itemID = replaceGlobleVariable(itemID) 

    If itemID <> "" Then
        sql = " where itemID=" & itemID 
    End If 
    '׷��sql
    If addSql <> "" Then
        sql = getWhereAnd(sql, addSql) 
    End If 
    XY_AP_CommentList = XY_AP_GeneralList(action, "TableComment", sql) 
End Function 

'��ʾ����ͳ��
Function XY_AP_SearchStatList(action)
    Dim addSql 
    addSql = RParam(action, "addSql") 
    XY_AP_SearchStatList = XY_AP_GeneralList(action, "SearchStat", addSql) 
End Function 
'��ʾ��������
Function XY_AP_Links(action)
    Dim addSql 
    addSql = RParam(action, "addSql") 
    XY_AP_Links = XY_AP_GeneralList(action, "FriendLink", addSql) 
End Function 
 
function XY_GetColumnId(action)
	dim columnName
	columnName=RParam(action, "columnName")
	XY_GetColumnId=getColumnId(columnName)
end function
'ͨ����Ϣ�б�
Function XY_AP_GeneralList(action, byval tableName, addSql)
    Dim title, topNumb, nTop, isB, sql ,tempS
    Dim columnName, columnEnName, aboutcontent, bodyContent, showTitle 
    Dim bannerImage, smallImage, bigImage, id 
    Dim defaultStr, i, j, s, c, startStr, endStr, url 
    Dim sNoFollow                                                                    '��׷�� 20141222
    defaultStr = getDefaultValue(action)                                            '���Ĭ������
    Dim nModI                                                                        '��ѭ��20150112
    sNoFollow = Trim(LCase(RParam(action, "noFollow")))                              '��׷��
    Dim lableTitle                                                                  '�������
    Dim target                                                                      'a���Ӵ�Ŀ�귽ʽ
    Dim adddatetime                                                                 '����ʱ��
    Dim isFocus 
    Dim fieldNameList                                                               '�ֶ��б�
    Dim abcolorStr                                                                  'A�Ӵֺ���ɫ
    Dim atargetStr                                                                  'A���Ӵ򿪷�ʽ
    Dim atitleStr                                                                   'A���ӵ�title20160407
    Dim anofollowStr                                                                'A���ӵ�nofollow
    Dim splFieldName, fieldName, replaceStr, nI2,idPage 
	dim member_followIdList,nRecordCount
	
    member_followIdList = RParam(action, "member_followIdList")  				'��Ա��עid�б�
	
	tableName=lcase(tableName)		'תСд
    fieldNameList = getHandleFieldList(db_PREFIX & tableName, "�ֶ��б�") 
    splFieldName = Split(fieldNameList, ",") 

    topNumb = RParam(action, "topNumb")  
    If topNumb <> "" Then
        nTop = CInt(topNumb) 
    Else
        nTop = 999 
    End If
    If sql = "" Then
        If topNumb <> "" Then
            topNumb = " top " & topNumb & " " 
        End If 
        sql = "Select " & topNumb & "* From " & db_PREFIX & tableName 
    End If
    '׷��sql
    If addSql <> "" Then
        sql = getWhereAnd(sql, addSql) 
    End If 
	if member_followIdList="1" or member_followIdList="true" then
		tempS="-1," & getsession("member_followIdList")
		sql = getWhereAnd(sql, " id in("& tempS &")") 
	end if
    sql = replaceGlobleVariable(sql)                                                '�滻ȫ�ֱ���
     
    '���SQL
    If checksql(sql) = False Then
        Call errorLog("������ʾ��<br>action=" & action & "<hr>sql=" & sql & "<br>") 
        Exit Function 
    End If 
	'��@��jsp��ʾ@��try{
    rs.Open sql, conn, 1, 1 
	'��PHP��ɾ��rs
	nRecordCount=rs.recordCount
	'��@��jsp��ʾ@��rs = Conn.executeQuery(handleSqlTop(sql));
    For i = 1 To nRecordCount
		startStr = "" : endStr = ""
        'call echo(sql,i & "," & nTop)
        If i > nTop Then
            Exit For 
        End If 
        '��PHP��$rs=mysql_fetch_array($rsObj);                                      //��������ΪҪ���jsp���recrodcount�����ó���������
		 '��@��.netc��ʾ@��rs.Read();
		 '��@��jsp��ʾ@��rs.next();
        isFocus = False                                                                 '����Ϊ��
        id = rs("id") 
        '��������
        If tableName = "webcolumn" Then
            If isMakeHtml = True Then
                url = getRsUrl(rs("fileName"), rs("customAUrl"), "/nav" & rs("id")) 
            Else
                url = handleWebUrl("?act=nav&columnName=" & rs("columnname"))               '��׷��gl�Ȳ���
                If rs("customAUrl") <> "" Then
                    url = rs("customAUrl") 
                    url = replaceGlobleVariable(url) 
                End If 
            End If 
            'ȫ����Ŀ����Ϊ����Ϊ�Զ���λ��ҳ ׷��(20160128)
            If glb_columnName = "" And rs("columnType") = "��ҳ" Then
                glb_columnName = rs("columnName") 
            End If 
            If rs("id") = glb_columnId or rs("id")=glb_columnRootId Then
                isFocus = True 
            End If 
        '�����¡�
        ElseIf tableName = "articledetail" Then
            If isMakeHtml = True Then
                url = getRsUrl(rs("fileName"), rs("customAUrl"), "detail/detail" & rs("id")) 
            Else
                url = handleWebUrl("?act=detail&id=" & rs("id"))                            '��׷��gl�Ȳ���
                If rs("customAUrl") <> "" Then
                    url = rs("customAUrl") 
                End If 
            End If 
        '����
        ElseIf tableName = "tablecomment" Then

        End If 

        'A����������ɫ
        abcolorStr = "" 
        If InStr(fieldNameList, ",titlecolor,") > 0 Then
            'A������ɫ 
            If rs("titlecolor") <> "" Then
                abcolorStr = "color:" & rs("titlecolor") & ";" 
            End If 
		elseif inStr(fieldNameList, ",fontcolor,") > 0 then
			'A������ɫ
			if rs("fontcolor") <> "" then
				abcolorStr = "color:" & rs("fontcolor") & ";" 
			end if 
        End If 
        If InStr(fieldNameList, ",flags,") > 0 Then
            'A���ӼӴ�
            If InStr(rs("flags"), "|b|") > 0 Then
                abcolorStr = abcolorStr & "font-weight:bold;" 
            End If 
        End If 
        If abcolorStr <> "" Then
            abcolorStr = " style=""" & abcolorStr & """" 
        End If 

        '�򿪷�ʽ2016
        If InStr(fieldNameList, ",target,") > 0 Then
            atargetStr = IIF(rs("target") <> "", " target=""" & rs("target") & """", "") 
        End If 

        'A��title
        If InStr(fieldNameList, ",title,") > 0 Then
            atitleStr = IIF(rs("title") <> "", " title=""" & rs("title") & """", "") 
        End If 

        'A��nofollow
        If InStr(fieldNameList, ",nofollow,") > 0 Then
            anofollowStr = IIF(cint(rs("nofollow")) <> 0, " rel=""nofollow""", "") 
        End If 

        '�����ж�(����Ŀ�����õ�)
        If isFocus = True Then
            startStr = "[list-focus]" : endStr = "[/list-focus]" 
		elseIf InStr(defaultStr, "[list-start]")>0 and InStr(defaultStr, "[/list-start]")>0 Then
            startStr = "[list-start]" : endStr = "[/list-start]" 
        Else
            startStr = "[list-" & i & "]" : endStr = "[/list-" & i & "]" 
        End If 

        '�����ʱ����ǰ����20160202
        If i = nTop And isFocus = False Then
			If InStr(defaultStr, "[list-end]")>0 and InStr(defaultStr, "[/list-end]")>0 Then
            	startStr = "[list-end]" : endStr = "[/list-end]" 
			end if
        End If 

        '��[list-mod2]  [/list-mod2]    20150112
        For nModI = 6 To 2 Step - 1
            If InStr(defaultStr, startStr) = False And i Mod nModI = 0 Then
                startStr = "[list-mod" & nModI & "]" : endStr = "[/list-mod" & nModI & "]" 
                If InStr(defaultStr, startStr) > 0 Then
                    Exit For 
                End If 
            End If 
        Next 

        'û������Ĭ��
        If InStr(defaultStr, startStr) = False Then
            startStr = "[list]" : endStr = "[/list]" 
        End If 

        If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
		
            s = strCut(defaultStr, startStr, endStr, 2) 

            s = replaceValueParam(s, "i", i)                                                'ѭ�����
            s = replaceValueParam(s, "���", i)                                             'ѭ�����
            s = replaceValueParam(s, "id", rs("id"))                                        'id��� ��Ϊ����ֶ��������id
            s = replaceValueParam(s, "url", url)                                            '��ַ
            s = replaceValueParam(s, "aurl", "href=""" & url & """")                        '��ַ
            s = replaceValueParam(s, "abcolor", abcolorStr)                                 'A���Ӽ���ɫ��Ӵ�
            s = replaceValueParam(s, "atitle", atitleStr)                                   'A����title
            s = replaceValueParam(s, "anofollow", anofollowStr)                             'A����nofollow
            s = replaceValueParam(s, "atarget", atargetStr)                                 'A���Ӵ򿪷�ʽ



            For nI2 = 0 To UBound(splFieldName)
                If splFieldName(nI2) <> "" Then
                    fieldName = splFieldName(nI2) 
                    replaceStr = rs(fieldName) & "" 
                    s = replaceValueParam(s, fieldName, replaceStr) 
                End If 
            Next 


            '��ʼλ�ü�Dialog����
            startStr = "[list-" & i & " startdialog]" : endStr = "[/list-" & i & " startdialog]"
			if i=nRecordCount then			
            	startStr = "[list startdialog]" : endStr = "[/list startdialog]"
			end if
            If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
                s = strCut(defaultStr, startStr, endStr, 2) & s 
			else 
					 
				For nModI = 6 To 2 Step - 1
					If InStr(defaultStr, startStr) = False And (i-1) Mod nModI = 0 Then
						startStr = "[list-mod" & nModI & " startdialog]" : endStr = "[/list-mod" & nModI & " startdialog]" 
						If InStr(defaultStr, startStr) > 0 Then
							s = strCut(defaultStr, startStr, endStr, 2) & s 
							Exit For 
						End If 
					End If 
				Next 
				 
            End If 
            '����λ�ü�Dialog����
            startStr = "[list-" & i & " enddialog]" : endStr = "[/list-" & i & " enddialog]" 
			if i=nRecordCount then			
            	startStr = "[list enddialog]" : endStr = "[/list enddialog]"
			end if
            If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
                s = s & strCut(defaultStr, startStr, endStr, 2) 
                's = strCut(defaultStr, startStr, endStr, 2) & s 
			else
				For nModI = 6 To 2 Step - 1
					If InStr(defaultStr, startStr) = False And i Mod nModI = 0 Then
						startStr = "[list-mod" & nModI & " enddialog]" : endStr = "[/list-mod" & nModI & " enddialog]" 
						If InStr(defaultStr, startStr) > 0 Then
							s = s & strCut(defaultStr, startStr, endStr, 2) 
							Exit For 
						End If 
					End If 
				Next 
            End If 

            '�ӿ���
			'jsp��û�п��ƣ���Ϊjsp�ﲻ֧��ͬʱ�������ݿ�
			if EDITORTYPE<>"jsp" then
            '��������
            If tableName = "webcolumn" Then
                url = WEB_ADMINURL & "?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&id=" & rs("id") & "&n=" & getRnd(11) 
            
			'�����ۡ�
			elseif tableName="tablecomment" then		
				idPage=getThisIdPage(db_PREFIX & tableName ,rs("id"),10) 
				url = WEB_ADMINURL & "?act=addEditHandle&actionType=TableComment&lableTitle=����&nPageSize=10&parentid=&searchfield=bodycontent&keyword=&addsql=&page="& idPage &"&id=" & rs("id") & "&n=" & getRnd(11)
			
			'�����¡�
            ElseIf tableName = "articledetail" Then 
				idPage=getThisIdPage(db_PREFIX & tableName ,rs("id"),10)
                url = WEB_ADMINURL & "?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page="& idPage &"&parentid="& rs("parentid") &"&id=" & rs("id") & "&n=" & getRnd(11) 
				
				
                s = replaceValueParam(s, "columnurl", getColumnUrl(rs("parentid"), ""))         '���¶�Ӧ��ĿURL 20160304
                s = replaceValueParam(s, "columnname", getColumnName(rs("parentid")))           '���¶�Ӧ��Ŀ���� 20160304 
            End If  
            s = handleDisplayOnlineEditDialog(url, s, "", "div|li|span")                    '�����Ƿ����������޸Ĺ�����
			end if
            c = c & s 
        End If 
    rs.MoveNext : Next : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){} 

    '��ʼ���ݼ�Dialog����
    startStr = "[dialog start]" : endStr = "[/dialog start]" 
    If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
        c = strCut(defaultStr, startStr, endStr, 2) & c 
    End If 
    '�������ݼ�Dialog����
    startStr = "[dialog end]" : endStr = "[/dialog end]" 
    If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
        c = c & strCut(defaultStr, startStr, endStr, 2) 
    End If 
    XY_AP_GeneralList = c 
End Function 


'������ñ�����
Function XY_handleGetTableBody(action, tableName, fieldParamName, defaultFileName, adminUrl)
    Dim url, content, id, sql, addSql, fieldName, fieldParamValue, fieldNameList, sLen, delHtmlYes, trimYes,defaultStr
	dim snoisonhtml,intoFieldStr,valuesStr
    fieldName = RParam(action, "fieldname")                                         '�ֶ�����	
    snoisonhtml = RParam(action, "noisonhtml") 					'������html
	'dim nonull nonull=RParam(action, "noisonhtml")							'���ݲ���Ϊ��20160716 home
	 
	if snoisonhtml="true" then
		intoFieldStr=",isonhtml"
		valuesStr=",0"
	end if

    fieldNameList = getHandleFieldList(db_PREFIX & tableName, "�ֶ��б�") 
    '�ֶ����Ʋ�Ϊ�գ�����Ҫ�ڱ��ֶ���
    If fieldName = "" Or InStr(fieldNameList, "," & fieldName & ",") = False Then
        fieldName = defaultFileName 
    End If 
    fieldName = LCase(fieldName)                                                    'תΪСд����Ϊ��PHP����ȫСд��

    fieldParamValue = RParam(action, fieldParamName)                                '��ȡ�ֶ�����
    id = handleNumber(RParam(action, "id"))                                         '���ID
    addSql = " where " & fieldParamName & "='" & fieldParamValue & "'" 
    If id <> "" Then
        addSql = " where id=" & id 
    End If 

    content = getDefaultValue(action)   :defaultStr=content                                            '���Ĭ������
    sql = "select * from " & db_PREFIX & tableName & addSql 
	'��@��jsp��ʾ@��try{
    rs.Open sql, conn, 1, 1 
    If not rs.EOF Then 
        id = rs("id") 
        content = rs(fieldName)
		if len(content)<=0 then
			content=defaultStr
			conn.execute("update " &  db_PREFIX & tableName & " set " & fieldName & "='"& content &"' where id=" & rs("id"))
		end if
	else	
        '�Զ����� 20160113
        If RParam(action, "autoadd") = "true" Then
            conn.Execute("insert into " & db_PREFIX & tableName & " (" & fieldParamName & "," & fieldName & intoFieldStr & ") values('" & fieldParamValue & "','" & ADSql(content) & "'"& valuesStr &")") 
        End If 
    End If : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){} 

    'ɾ��Html
    delHtmlYes = RParam(action, "delHtml")                                          '�Ƿ�ɾ��Html
    If delHtmlYes = "true" Then content = Replace(delHtml(content), "<", "&lt;") 'HTML����
    'ɾ�����߿ո�
    trimYes = RParam(action, "trim")                                                '�Ƿ�ɾ�����߿ո�
    If trimYes = "true" Then content = trimVbCrlf(content) 

    '��ȡ�ַ�����
    sLen = RParam(action, "len")                                                    '�ַ�����ֵ
    sLen = handleNumber(sLen) 
    'If sLen<>"" Then ReplaceStr = CutStr(ReplaceStr,sLen,"null")' Left(ReplaceStr,sLen)
    If sLen <> "" Then content = cutStr(content, cint(sLen), "...")                       'Left(ReplaceStr,sLen)


    If id = "" Then
        id = XY_AP_GetFieldValue("", sql, "id") 
    End If 
    url = adminUrl & "&id=" & id & "&n=" & getRnd(11) 
    If Request("gl") = "edit" Then
        content = "<span>" & content & "</span>" 
    End If 

    'call echo(sql,url)
    content = handleDisplayOnlineEditDialog(url, content, "", "span") 
    XY_handleGetTableBody = content 

End Function 

'��õ�ҳ����
Function XY_AP_GetOnePageBody(action)
    Dim adminUrl 
    adminUrl = WEB_ADMINURL & "?act=addEditHandle&actionType=OnePage&lableTitle=��ҳ&nPageSize=10&page=&switchId=2" 
    XY_AP_GetOnePageBody = XY_handleGetTableBody(action, "onepage", "title", "bodycontent", adminUrl) 
End Function 

'��õ�������
Function XY_AP_GetColumnBody(action)
    Dim adminUrl 
    adminUrl = WEB_ADMINURL & "?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&switchId=2" 
    XY_AP_GetColumnBody = XY_handleGetTableBody(action, "webcolumn", "columnname", "bodycontent", adminUrl) 
End Function 

'��ʾ��������
Function XY_AP_GetArticleBody(action)
    Dim adminUrl 
    adminUrl = WEB_ADMINURL & "?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&switchId=2" 
    XY_AP_GetArticleBody = XY_handleGetTableBody(action, "articledetail", "title", "bodycontent", adminUrl) 
End Function 


'�����ĿURL
Function XY_GetColumnUrl(action)
    Dim columnName, url 
    columnName = RParam(action, "columnName") 
    url = getColumnUrl(columnName, "name") 
    'handleWebUrl  �ж�gl����
	
    'If Request("gl") <> "" Then
    '    url = url & "&gl=" & Request("gl") 
    'End If 
    XY_GetColumnUrl = url 
End Function 
'��õ���url ����֮ǰ��վ����ʱ�õ� 20160722  ����ɾ��
function XY_GetNavUrl(action)  
    Dim columnName, url,did,sid
    did = RParam(action, "did") 
    sid = RParam(action, "sid") 
	columnName=did
	if sid<>"" then
		columnName=sid
	end if
    url = getColumnUrl(columnName, "name") 
    'handleWebUrl  �ж�gl����
	
    'If Request("gl") <> "" Then
    '    url = url & "&gl=" & Request("gl") 
    'End If 
    XY_GetNavUrl = url 
end function

'�������URL
Function XY_GetArticleUrl(action)
    Dim title, url 
    title = RParam(action, "title") 
    url = getArticleUrl(title) 
    'If Request("gl") <> "" Then
    '    url = url & "&gl=" & Request("gl") 
    'End If 
    XY_GetArticleUrl = url 
End Function 

'��õ�ҳURL
Function XY_GetOnePageUrl(action)
    Dim title, url 
    title = RParam(action, "title") 
    url = getOnePageUrl(title) 
    'If Request("gl") <> "" Then
    '    url = url & "&gl=" & Request("gl") 
    'End If 
    XY_GetOnePageUrl = url 
End Function 


'��õ����ֶ�����
Function XY_AP_GetFieldValue(action, sql, fieldName)
    Dim title, content 
	'��@��jsp��ʾ@��try{
    rs.Open sql, conn, 1, 1 
    If Not rs.EOF Then
        content = rs(fieldName) 
    End If : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){} 
    XY_AP_GetFieldValue = content 
End Function 


'Js����վͳ��
Function XY_JsWebStat(action)
    Dim s, fileName, sType 
    sType = RParam(action, "stype") 
    fileName = Trim(RParam(action, "fileName")) 
    If fileName = "" Then
        fileName = "[$WEB_VIEWURL$]?act=webstat&stype=" & sType 
    End If 
    fileName = Replace(fileName, "/", "\/") 
    s = "<script>document.writeln(""<script src=\'" & fileName & "&GoToUrl=""" 
    s = s & "+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)" 
    s = s & "+""&co=""+escape(document.cookie)"                                 '�ռ�cookie ����Ҫ�����ε�
    s = s & "+"" \'><\/script>"");</"&"script>" 
    XY_JsWebStat = s 
End Function 



'��ͨ����A
Function XY_HrefA(action)
    Dim content, Href, c, AContent, AType, url, title 
    action = handleInModule(action, "start") 
    content = RParam(action, "Content") 
    AType = RParam(action, "Type") 
    If AType = "�ղ�" Then
        '��һ�ַ���
        'Url = "window.external.addFavorite('"& WebUrl &"','"& WebTitle &"')"
        url = "shoucang(document.title,window.location)" 
        c = "<a href='javascript:;' onClick=""" & url & """ " & setHtmlParam(action, "target|title|alt|id|class|style") & ">" & content & "</a>" 
    ElseIf AType = "��Ϊ��ҳ" Then
        '��һ�ַ���
        'Url = "var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& WebUrl &"');"
        url = "SetHome(this,window.location)" 
        c = "<a href='javascript:;' onClick=""" & url & """" & setHtmlParam(action, "target|title|alt|id|class|style") & ">" & content & "</a>" 
    Else
        content = RParam(action, "Title") 
    End If 

    content = handleInModule(content, "end") 
    If c = "" Then c = "<a" & setHtmlParam(action, "href|target|title|alt|id|class|rel|style") & ">" & content & "</a>" 

    XY_HrefA = c 
End Function 



'����20151231
Function XY_Layout(action)
    Dim layoutName, s, c, sourceStr, replaceStr, splSource, splReplace, i 

    layoutName = RParam(action, "layoutname") 
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "weblayout where layoutname='" & layoutName & "'", conn, 1, 1 
    If Not rs.EOF Then
        c = rs("bodycontent") 

        sourceStr = rs("sourceStr")                                                     'Դ���� ���滻����
        replaceStr = rs("replaceStr")                                                   '�滻����
        splSource = Split(sourceStr, "[Array]")                                    'Դ��������
        splReplace = Split(replaceStr, "[Array]")                                  '�滻��������

        For i = 0 To UBound(splSource)
            sourceStr = splSource(i) 
            replaceStr = splReplace(i) 
            If sourceStr <> "" Then
                c = Replace(c, sourceStr, replaceStr) 
                'call echo(sourceStr,replaceStr)
            'call echo(c,instr(c,sourcestr))
            End If 
        Next 
    'call rwend(c)
    End If : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){} 
    XY_Layout = c 
End Function 

'ģ��20151231
Function XY_Module(action)
    Dim moduleName, s, c, sourceStr, replaceStr, splSource, splReplace, i 
    moduleName = RParam(action, "modulename") 
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "webmodule where modulename='" & moduleName & "'", conn, 1, 1 
    If Not rs.EOF Then
        c = rs("bodycontent") 

        sourceStr = RParam(action, "sourceStr")                                         'Դ���� ���滻����
        replaceStr = RParam(action, "replaceStr")                                       '�滻����

        splSource = Split(sourceStr, "[Array]")                                    'Դ��������
        splReplace = Split(replaceStr, "[Array]")                                  '�滻��������

        For i = 0 To UBound(splSource)
            sourceStr = splSource(i) 
            replaceStr = splReplace(i) 
            If sourceStr <> "" Then
                c = Replace(c, sourceStr, replaceStr) 
                'call echo(sourceStr,replaceStr)
            'call echo(c,instr(c,sourcestr))
            End If 
        Next 
    'call rwend(c)
    End If : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){} 
    XY_Module = c 
End Function 

'��ʾ������20160127
Function XY_DisplayWrap(ByVal action)
    Dim content 
    content = getDefaultValue(action) 
    XY_DisplayWrap = content 
End Function 




'Ƕ�ױ��� ����
Function XY_getLableValue(action)
    Dim title, content, c 
    'call echo("Action",Action)
    title = RParam(action, "title") 
    content = RParam(action, "content") 
    c = c & "title=" & getContentRunStr(title) & "<hr>" 
    c = c & "content=" & getContentRunStr(content) & "<hr>" 
    XY_getLableValue = c 
    Call echo("title", title) 
    XY_getLableValue = "��title=����" & title & "��" 
End Function 
'���������������������б�
Function XY_TitleInSearchEngineList(action)
    Dim title, sType,divclass,spanclass,s,c
	
    title = RParam(action, "title") 
    sType = RParam(action, "sType") 
    divclass = RParam(action, "divclass") 
    spanclass = RParam(action, "spanclass")
	 
	s="<strong>������ڡ�" & title & "��</strong>"
	if divclass<>"" then
		s="<div class="""& divclass &""">"& s &"</div>"
	elseif spanclass<>"" then
		s="<span class="""& spanclass &""">"& s &"</span>" & "<br>"
	else
		s=s & "<br>"
	end if
    c = c & s & vbCrLf 
    c = c & "<ul class=""list""> " & vbCrLf 
    c = c & "<li><a href=""https://www.baidu.com/s?ie=gb2312&word=" & title & """ rel=""nofollow"" target=""_blank"">��baidu�������ڰٶ�������(" & title & ")</a></li>" & vbCrLf 
    c = c & "<li><a href=""http://www.haosou.com/s?ie=gb2312&q=" & title & """ rel=""nofollow"" target=""_blank"">��haosou�������ں���������(" & title & ")</a></li>" & vbCrLf 
    c = c & "<li><a href=""https://search.yahoo.com/search;_ylt=A86.JmbkJatWH5YARmebvZx4?toggle=1&cop=mss&ei=gb2312&fr=yfp-t-901&fp=1&p=" & title & """ rel=""nofollow"" target=""_blank"">��yahoo���������Ż�������(" & title & ")</a></li>" & vbCrLf 

    c = c & "<li><a href=""https://www.sogou.com/sogou?ie=utf8&query=" & toUTFChar(title) & """ rel=""nofollow"" target=""_blank"">��sogou���������ѹ�������(" & title & ")</a></li>" & vbCrLf 
    c = c & "<li><a href=""http://www.youdao.com/search?ue=utf8&q=" & toUTFChar(title) & """ rel=""nofollow"" target=""_blank"">��youdao���������е�������(" & title & ")</a></li>" & vbCrLf 
    c = c & "<li><a href=""http://search.yam.com/Search/Web/DefaultKSA.aspx?SearchType=web&l=0&p=0&k=" & toUTFChar(title) & """ rel=""nofollow"" target=""_blank"">��yam����(google�ṩ����)����ެ����������(" & title & ")</a></li>" & vbCrLf 
	
	
    c = c & "<li><a href=""http://cn.bing.com/search?q=" & toUTFChar(title) & """ rel=""nofollow"" target=""_blank"">��bing�������ڱ�Ӧ������(" & title & ")</a></li>" & vbCrLf 
    c = c & "</ul>" & vbCrLf 

    XY_TitleInSearchEngineList = c 
End Function 

'URL����
Function XY_escape(action)
    Dim content 
    content = RParam(action, "content") 
    XY_escape = escape(content) 
End Function 
'URL����
Function XY_unescape(action)
    Dim content 
    content = RParam(action, "content") 
    XY_unescape = escape(content) 
End Function 
'�����ַ
function XY_getUrl(action)
    Dim stype 
    stype = RParam(action, "stype") 
	XY_getUrl=getThisUrlNoParam()
end function



'Forѭ������
function XY_ForArray(action)
    dim sListArray, sSplitStr, defaultStr, splStr, nForI, title, s, c, sNLoop 
    sListArray = atRParam(action, "arraylist")                             'atRParam��ý�����������������滻��������
    sSplitStr = rParam(action, "splitstr") 
    sNLoop = rParam(action, "nloop")                                       'ѭ����

    if sListArray = "" and sNLoop<>"" then
        sListArray = copyStr("ѭ��" & sSplitStr, cint(sNLoop)) 
    end if 

    defaultStr = getDefaultValue(action) 

    splStr = split(sListArray, sSplitStr) 
    for nForI = 0 to uBound(splStr)
        title = splStr(nForI) 
        if title <> "" then
            s = defaultStr 
            s = replaceValueParam(s, "fortitle", title) 
            s = replaceValueParam(s, "forid", nForI+1) 
            s = replaceValueParam(s, "fori", nForI) 
            s = replaceValueParam(s, "forcount", uBound(splStr) + 1) 
            c = c & s 
        end if 
    next 
    XY_ForArray = c 
end function 

'����λ����ʾ��Ϣ{}Ϊ�ж�����
function XY_detailPosition(action)
    Dim c,stype,splitS,id,i,parentid,cList
	stype = rParam(action, "stype") 
	stype="|"& stype &"|"
	splitS=rParam(action, "splitS")
	if splitS="" then
		splitS=" >> "
	end if
	
	
    c = "<a href="""& getColumnUrl("��ҳ","type") &""">��ҳ</a>" 
	'call echo("type",getColumnUrl("��ҳ","type"))
    If glb_columnName <> "" Then
		'call eerr(glb_columnId,glb_columnName)
		id=glb_columnId
		for i =1 to 9
			rsTemp.open"select * from " & db_PREFIX & "WebColumn where id="& id &"",conn,1,1
			if not rsTemp.eof then
				id=rsTemp("parentid")
				parentid=cstr(rsTemp("parentid"))
				cList = splitS & "<a href=""" & getColumnUrl(rsTemp("columnname"), "name") & """>" & rsTemp("columnname") & "</a>" & cList
			end if:rsTemp.close
			if parentid="-1" then
				exit for
			end if
		next
		c=c & cList
    End If 
    '20160330
    If glb_locationType = "detail" Then
		if instr(stype,"|��ʾ���±���|")>0 then
			c = c & splitS & glb_detailTitle 
		elseif instr(stype,"|�������±���|")>0 then
		else
	        c = c & splitS & "�鿴����"  
		end if
    End If
    'β��׷������
	
	XY_detailPosition=c
end function

%>           

