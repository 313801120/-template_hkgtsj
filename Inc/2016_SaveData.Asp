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
'��������   ?act=saveData
Function saveData(sType)
	
	if getsession("yzm")="" then
		call eerr("��ʾ","��֤��ʧЧ")
	end if
	
	'if instr("|"& getFormFieldList() &"|","|yzm|") then		 
	if getsession("yzm")<>request.Form("yzm") then
		call eerr("��ʾ","��֤�����")
	end if
	call setsession("yzm","")			'�����֤��
	  

    '������������
    If sType = "articlecomment" Then 		
		call autoSavePostData("", "tablecomment", "tablename||ArticleDetail,adddatetime|now,itemid||"& request("itemid") &",adddatetime,ip||"& getip())
    	Call echo("��ʾ", "�����ύ�ɹ����ȴ�����Ա���") 
		
    ElseIf sType = "feedback" Then
		if request.Form("guestname")="" then
			call eerr("��ʾ","����Ϊ��")
		end if
		call autoSavePostData("", "feedback", "isthrough|numb|0,adddatetime|now,ip||"& getip() &",columnid||" & request.QueryString("columnid"))
		Call echo("��ʾ", "�����ύ�ɹ����ȴ�����Ա���") 
    ElseIf sType = "guestbook" Then		
		if request.Form("guestname")="" then
			call eerr("��ʾ","����Ϊ��")
		end if	
		call autoSavePostData("", "guestbook", "isthrough|numb|0,adddatetime|now,ip||"& getip() &",columnid||" & request.QueryString("columnid"))
		Call echo("��ʾ", "�����ύ�ɹ����ȴ�����Ա���")
	
	 ElseIf sType = "articledetail" Then	
		call autoSavePostData("", "articledetail", "title|bodycontent,adddatetime|now,ip||"& getip())
		Call echo("��ʾ", "�����ύ�ɹ�")		
    End If 
	response.End()
End Function  
'�Զ�����POST���ݵ���
function autoSavePostData(sID, tableName, fieldNameList)
	dim sql 
	sql=getPostSql(sID, tableName, fieldNameList)
    '���SQL
    If checksql(sql) = False Then
        Call errorLog("������ʾ��<hr>sql=" & sql & "<br>") 
        Exit Function 
    End If
	'conn.execute(sql)			'checksql��һ�����Ѿ�ִ���˲���Ҫ��ִ����20160410
end function
'���Post���ͱ�������SQL��� 20160309
Function getPostSql(sID, tableName, fieldNameList)
    Dim valueStr, editValueStr, sql
    Dim splStr, splxx, s, fieldList 
    Dim fieldName, defaultFieldValue                                                '�ֶ�����
    Dim fieldSetType                                                                '�ֶ���������
    Dim fieldValue                                                                  '�ֶ�ֵ

    Dim systemFieldList                                                             '���ֶ��б�
    systemFieldList = getHandleFieldList(db_PREFIX & tableName, "�ֶ������б�") 

    Dim postFieldList                                                               'post�ֶ��б�
    Dim splPost, fieldContent, fieldConfig 
    postFieldList = getFormFieldList()  
	'�Ժ��ٰ����������������ִ��������³�һ�ֿ����в���
    splPost = Split(postFieldList, "|") 
    For Each fieldName In splPost
        fieldContent = Request.Form(fieldName)  
        If InStr(systemFieldList, "," & fieldName & "|") > 0 And InStr("," & fieldList & ",", "," & fieldName & ",") = 0 Then
            'Ϊ�Զ����
            If InStr(fieldNameList, "," & fieldName & "|") > 0 Then
                fieldConfig = Mid(fieldNameList, InStr(fieldNameList, "," & fieldName & "|") + 1) 
            Else
                fieldConfig = Mid(systemFieldList, InStr(systemFieldList, "," & fieldName & "|") + 1) 
            End If 
            fieldConfig = Mid(fieldConfig, 1, InStr(fieldConfig, ",") - 1) 
            'call echo("config",fieldConfig)
            'call echo(fieldName,fieldContent)
			'call echo("fieldConfig",fieldConfig)
            splxx = Split(fieldConfig & "|||", "|") 
            fieldName = splxx(0)                                                            '�ֶ�����
			fieldSetType="":defaultFieldValue=""
			'��@��jsp��ʾ@��try{
            fieldSetType = splxx(1)                                                         '�ֶ���������
            defaultFieldValue = splxx(2)                                                    'Ĭ���ֶ�ֵ			
			'��@��jsp��ʾ@��}catch(Exception e){}
            fieldValue = ADSqlRf(fieldName)                                                 '�������棬��Ϊ��������'����
            'call echo("fieldValue",fieldValue)
			'�������벻����
			if fieldValue<>"#NO******NO#" then
				'md5����
				If fieldSetType = "md5" Then
					fieldValue = myMD5(fieldValue) 
				End If 
	
				If fieldSetType = "yesno" Then
					If fieldValue = "" Then
						fieldValue = defaultFieldValue 
					End If 
				'��Ϊ�������ͼӵ�����
				ElseIf fieldSetType = "numb" Then
					If fieldValue = "" Then
						fieldValue = defaultFieldValue 
					End If 
	
				ElseIf fieldName = "flags" Then
					'PHP���÷�
					If EDITORTYPE = "php" Then
						If fieldValue <> "" Then									'��@����php����@��
							fieldValue = "|" & arrayToString(fieldValue, "|") '��@����php����@��
						End If '��@����php����@��
					Else
						fieldValue = "|" & arrayToString(Split(fieldValue, ", "), "|") 
					End If 
	
	
					fieldValue = "'" & fieldValue & "'" 
	
				'Ϊʱ��
				ElseIf fieldSetType = "time" or fieldSetType = "now" Then
					If fieldValue = "" Then
						fieldValue = cstr(now())	'��.net�� 
					End If 
					fieldValue = "'" & fieldValue & "'" 
				'Ϊʱ��
				ElseIf fieldSetType = "date" Then
					If fieldValue = "" Then
						fieldValue = Date() 
					End If 
					fieldValue = "'" & fieldValue & "'" 
	
				Else
					fieldValue = "'" & fieldValue & "'" 
				End If 
				if EDITORTYPE <> "asp" then
					fieldValue=unescape(fieldValue)			'����20160418   ��+��������ΪΪʲôҪ���룿������php��get��ʽ����ʱ(20160810) 
				end if
				If valueStr <> "" Then 
					valueStr = valueStr & "," 
					editValueStr = editValueStr & "," 
				End If  
				valueStr = valueStr & fieldValue 
				editValueStr = editValueStr & fieldName & "=" & fieldValue 
			end if
			If fieldList <> "" Then
				fieldList = fieldList & ","  
			End If 
			fieldList = fieldList & fieldName 
			
			
        End If 
    Next  
    '�Զ����ֶ��Ƿ���Ҫд��Ĭ��ֵ  �е�
    splStr = Split(fieldNameList, ",") 
    For Each s In splStr
        If InStr(s, "|") > 0 Then
            splxx = Split(s & "|||", "|") 
            fieldName = splxx(0)                                                            '�ֶ�����
			fieldSetType="":fieldValue="" 
			'��@��jsp��ʾ@��try{
            fieldSetType = splxx(1)                                                         '�ֶ���������
            fieldValue = splxx(2)                                                           'Ĭ���ֶ�ֵ
			'��@��jsp��ʾ@��}catch(Exception e){}

            If InStr(systemFieldList, "," & fieldName & "|") > 0 And InStr("," & fieldList & ",", "," & fieldName & ",") = False Then
			  
                if fieldSetType = "date" and fieldValue="" then
                    fieldValue = Date() 
                elseif (fieldSetType = "time" or fieldSetType = "now") and fieldValue="" then
                    fieldValue =cstr(Now())			'��.net�� 
				end if
				If fieldSetType <> "yesno" And fieldSetType <> "numb" Then
                    fieldValue = "'" & fieldValue & "'" 
                End If 
                If fieldList <> "" Then
                    fieldList = fieldList & "," 
                    valueStr = valueStr & "," 
                    editValueStr = editValueStr & "," 
                End If 
                fieldList = fieldList & fieldName 
                valueStr = valueStr & fieldValue 
                editValueStr = editValueStr & fieldName & "=" & fieldValue 
            'call echo(fieldName,fieldSetType)
            End If 
        End If 
    Next 

    If sID = "" Then
        sql = "insert into " & db_PREFIX & "" & tableName & " (" & fieldList & ",updatetime) values(" & valueStr & ",'" & Now() & "')" 
    Else
		'call echo("editValueStr",editValueStr)
        sql = "update " & db_PREFIX & "" & tableName & " set " & editValueStr & ",updatetime='" & Now() & "' where id=" & sID 
    End If 
    getPostSql = sql 
End Function 
%> 
