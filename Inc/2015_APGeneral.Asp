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
'ASP��PHPͨ�ú���

'��������Ŀ��Ϣ
function handleColumnRoot(byval id)
	dim i,parentid
	for i =1 to 9
		rst.open"select * from " & db_PREFIX & "WebColumn where id="& id &"",conn,1,1
		if not rst.eof then
			parentid=cstr(rst("parentid"))
			if parentid<>"-1" then
				id=rst("parentid")
			else
				glb_columnRootName=rst("columnname")
				glb_columnRootEnName=rst("columnenname")
				glb_columnRootId=rst("id")
				exit for		
			end if
		else
			exit for
		end if:rst.close
	next
end function

'�����Ŀ��id
function getColumnRootId(byval id)
	dim parentid,i
	for i =1 to 9
		rst.open"select * from " & db_PREFIX & "WebColumn where id="& id &"",conn,1,1
		if not rst.eof then
			parentid=cstr(rst("parentid"))
			if parentid<>"-1" then
				id=rst("parentid")
			else
				exit for		
			end if
		else
			exit for
		end if:rst.close
	next
	getColumnRootId=id
end function
'�������Ŀid�б�
function getColumnIdList(byval id, sType)
	dim parentid,c,splstr,s
	if sType="addthis" then
		c=id
	end if
	rsTemp.open"select * from " & db_PREFIX & "WebColumn where parentid="& id &"",conn,1,1
	while not rsTemp.eof 
		if c<>"" then
			c=c & ","
		end if
		id=rsTemp("id")
		c=c & rsTemp("id")
	rsTemp.movenext:wend:rsTemp.close
	splstr=split(c,",")
	for each id in splstr
		if id<>"" then
			s=getColumnIdList(id,"")
			if s<>"" then
				c=c & "," & s
			end if
		end if
	next 
	getColumnIdList=c
end function

'������ر�ǩ ��  ���Ľ�
function aritcleRelatedTags(relatedTags)
    dim c, splStr, s, url 
    splStr = split(relatedTags, ",") 
    for each s in splStr
        if s <> "" then
            if c <> "" then
                c = c & "," 
            end if 
            url = getColumnUrl(s, "name") 
            c = c & "<a href=""" & url & """ rel=""category tag"" class=""ablue"">" & s & "</a>" & vbCrLf 
        end if 
    next 

    c = "<footer class=""articlefooter"">" & vbCrLf & "��ǩ�� " & c & "</footer>" & vbCrLf 
    aritcleRelatedTags = c 
end function 


'����������id�б�
function getRandArticleId(addSql, nTopNumb)
    dim splStr, s, c, nIndex 
	'��@��jsp��ʾ@��try{	
    rs.open "select * from " & db_PREFIX & "articledetail " & addSql, conn, 1, 1 
    while not rs.EOF
        if c <> "" then c = c & "," 
        c = c & rs("id") 
    rs.moveNext : wend : rs.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
    getRandArticleId = randomShow(c, ",", 4) 
    splStr = split(c, ",") : c = "" : nIndex = 0 
    for each s in splStr
        if c <> "" then c = c & "," 
        c = c & s 
        nIndex = nIndex + 1 
        if nIndex >= nTopNumb then exit for 
    next 
    getRandArticleId = c 
end function 
'�����վ��Ŀ����SQL
function getWebColumnSortSql(id)
    dim sql 
	'��@��jsp��ʾ@��try{
    tempRs2.open "select * from " & db_PREFIX & "webcolumn where id=" & id, conn, 1, 1 
    if not tempRs2.eof then
        sql = cstr(tempRs2("sortsql")) 
    end if : tempRs2.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
    getWebColumnSortSql = sql 
end function 

'��һƪ���� �������sortrank(����)Ҳ���Ը�Ϊid,�����õ�ʱ���Ҫ��id
function upArticle(parentid, lableName, lableValue, ascOrDesc)
    upArticle = handleUpDownArticle("��һƪ��", "uppage", parentid, lableName, lableValue, ascOrDesc) 
end function 
'��һƪ����
function downArticle(parentid, lableName, lableValue, ascOrDesc)
    downArticle = handleUpDownArticle("��һƪ��", "downpage", parentid, lableName, lableValue, ascOrDesc) 
end function 
'��������ҳ
function handleUpDownArticle(lableTitle, sType, parentid, lableName, lableValue, ascOrDesc)
    dim c, url, target, targetStr 

    dim sql 
    if lableName = "adddatetime" then
        lableValue = "#" & lableValue & "#" 
    end if 
    'λ�û���
    if ascOrDesc = "desc" then
        if sType = "uppage" then
            sType = "downpage" 
        else
            sType = "uppage"  
        end if 
    end if 
    if sType = "uppage" then 
        sql = "select * from " & db_PREFIX & "articledetail where parentid=" & parentid & " and " & lableName & "<" & lableValue & " order by " & lableName & " desc" 
    else
        sql = "select * from " & db_PREFIX & "articledetail where parentid=" & parentid & " and " & lableName & ">" & lableValue & " order by " & lableName & " asc" 
    end if 

    'call echo("sql",sql) 
	'��@��jsp��ʾ@��try{
    rsx.open sql, conn, 1, 1 
    if not rsx.EOF then
        target = rsx("target") 
        if target <> "" then
            targetStr = " target=""" & target & """" 
        end if 
        if isMakeHtml = true then
            url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/detail/detail" & rsx("id")) 
        else
            if rsx("customAUrl") = "" then
                url = handleWebUrl("?act=detail&id=" & rsx("id")) 
            else
                url = handleWebUrl(rsx("customAUrl")) 
            end if 
        end if 
        c = "<a href=""" & url & """" & targetStr & ">" & lableTitle & rsx("title") & "</a>" 
    else
        c = lableTitle & "û��" 
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
    handleUpDownArticle = c 
end function 
'���RS��ַ ������һҳ ��һҳ
function getRsUrl(byVal fileName, customAUrl, defaultFileName)
    dim url 
    '��Ĭ���ļ�����
    if fileName = "" then
        fileName = defaultFileName 
    end if 
    '��ַ
    if fileName <> "" then
        fileName = lCase(fileName)                                                      '���ļ�����Сд20160315
        url = fileName 
        if inStr(lCase(url), ".html") = 0 and right(url, 1) <> "/" then
            url = url & ".html" 
        end if 
    end if 
    if trim(customAUrl) <> "" then
        url = trim(customAUrl) 
    end if 
	'׷�������Ϊ�������ɾ�̬�ļ�ʱ�����Ի����ҳ���ļ����ƣ�����index.html#about  ���� 20160728
	if url="/" then
		url="/index.html"
	end if
    if inStr(cfg_flags, "|addwebsite|") > 0 then 
        'url = replaceGlobleVariable(url)   '�滻ȫ�ֱ���
        if inStr(url, "$cfg_websiteurl$") = false and inStr(url, "{$GetColumnUrl ") = false and inStr(url, "{$GetArticleUrl ") = false and inStr(url, "{$GetOnePageUrl ") = false then
            url = urlAddHttpUrl(cfg_webSiteUrl, url) 
        end if 
    end if 
    getRsUrl = url 
end function 
'��ô�����RS��ַ
function getHandleRsUrl(fileName, customAUrl, defaultFileName)
    dim url 
    url = getRsUrl(fileName, customAUrl, defaultFileName) 
    '��ΪURL���Ϊ�Զ��������Ҫ������ȫ�ֱ������������������ֻ���������Ϳ���ʹ������HTML�������������⣬20160308
    url = replaceGlobleVariable(url) 
    getHandleRsUrl = url 
end function 

'��õ�ҳurl 20160114
function getOnePageUrl(title)
    dim url 
	'��@��jsp��ʾ@��try{
    rsx.open "select * from " & db_PREFIX & "onepage where title='" & title & "'", conn, 1, 1 
    if not rsx.EOF then
        if isMakeHtml = true then
            url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/page/page" & rsx("id")) 
        else
            url = handleWebUrl("?act=onepage&id=" & rsx("id")) 
            if rsx("customAUrl") <> "" then
                url = rsx("customAUrl") 
            end if 
        end if 
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}

    getOnePageUrl = url 
end function 
'�������URL
function getArticleUrl(title)
    dim url 
	'��@��jsp��ʾ@��try{
    rsx.open "select * from " & db_PREFIX & "articledetail where title='" & title & "'", conn, 1, 1 
    if not rsx.EOF then
        if isMakeHtml = true then
            url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/detail/" & rsx("id")) 
        else
            url = handleWebUrl("?act=article&id=" & rsx("id")) 
            if rsx("customAUrl") <> "" then
                url = rsx("customAUrl") 
            end if 
        end if 
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}

    getArticleUrl = url 
end function 
'�����ĿURL 20160114 getColumnUrl("��ҳ","type")
function getColumnUrl(columnNameOrId, sType)
    dim url, addSql 

    columnNameOrId = replaceGlobleVariable(columnNameOrId)                          '�������� <a href="{$GetColumnUrl columnname='[$glb_columnName$]' $}" >����ͼƬ</a>

    if sType = "name" then
        addSql = " where columnname='" & replace(columnNameOrId, "'", "''") & "'"       '��'�Ŵ�����Ҫ��Ȼsql��ѯ����20160716
    elseif sType = "type" then
        addSql = " where columntype='"& columnNameOrId &"'"       '��'�Ŵ�����Ҫ��Ȼsql��ѯ����20160716
    else
        addSql = " where id=" & columnNameOrId & "" 
    end if 
	'��@��jsp��ʾ@��try{
    rsx.open "select * from " & db_PREFIX & "webcolumn" & addSql, conn, 1, 1 
    if not rsx.EOF then
        if isMakeHtml = true then
            url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/nav" & rsx("id")) 
			'call echo(rsx("columnName"),url)
        else
            'url = handleWebUrl("?act=nav&columnName=" & rsx("columnname")) 		'�����jquery.mobile���������
            url = handleWebUrl("?act=nav&id=" & rsx("id")) 
            if rsx("customAUrl") <> "" then
                url = rsx("customAUrl") 
            end if 
        end if 
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}

    getColumnUrl = url 
end function 

'������±����Ӧ��id
function getArticleId(title)
    title = replace(title, "'", "")                                                 'ע�⣬���������
    getArticleId = "-1" 
	'��@��jsp��ʾ@��try{
    rsx.open "Select * from " & db_PREFIX & "ArticleDetail where title='" & title & "'", conn, 1, 1 
    if not rsx.EOF then
        getArticleId = rsx("id")
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
end function 

'�����Ŀid
function getColumnId(columnName)
    'columnName = Replace(columnName, "'", "")           'ע�⣬���������  ��Ϊsql���Ѿ������� 20160716 home ����д��Խ��Խ��߼�Խ��
    getColumnId = "-1" 
	'��@��jsp��ʾ@��try{
    rsx.open "Select * from " & db_PREFIX & "webcolumn where columnName='" & columnName & "'", conn, 1, 1 
    if not rsx.EOF then
        getColumnId = rsx("id") 
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
end function

'�����Ŀ����
function getColumnName(sID)
	getColumnName=""
    if sID <> "" then
	'��@��jsp��ʾ@��try{
        rsx.open "Select * from " & db_PREFIX & "webcolumn where id=" & sID, conn, 1, 1 
        if not rsx.EOF then
            getColumnName = rsx("columnName") 
        end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
    end if 
end function 

'�����Ŀ����
function getColumnType(columnID)
	getColumnType=""
	'��@��jsp��ʾ@��try{
    rsx.open "Select * from " & db_PREFIX & "webcolumn where id=" & columnID, conn, 1, 1 
    if not rsx.EOF then
        getColumnType = rsx("columnType") 
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
end function 
 
'�����Ŀ����
function getColumnBodyContent(columnID)
	getColumnBodyContent=""
	'��@��jsp��ʾ@��try{
    rsx.open "Select * from " & db_PREFIX & "webcolumn where id=" & columnID, conn, 1, 1 
    if not rsx.EOF then
        getColumnBodyContent = rsx("bodyContent") 
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
end function 


'��ú�̨�˵����� 
function getListMenuId(title)
    title = replace(title, "'", "")                                                 'ע�⣬���������
    getListMenuId = "-1" 
	'��@��jsp��ʾ@��try{
    rsx.open "Select * from " & db_PREFIX & "listmenu where title='" & title & "'", conn, 1, 1 
    if not rsx.EOF then
        getListMenuId = rsx("id")
    end if : rsx.close 
	'��@��jsp��ʾ@��}catch(Exception e){}
end function 

'��ú�̨�˵�ID 
function getListMenuName(sID) 
	getListMenuName=""
    if sID <> "" then
		'��@��jsp��ʾ@��try{
        rsx.open "Select * from " & db_PREFIX & "listmenu where id=" & sID, conn, 1, 1 
        if not rsx.EOF then
            getListMenuName = rsx("title") 
        end if : rsx.close 
		'��@��jsp��ʾ@��}catch(Exception e){}
    end if 
end function  

'��վͳ��2014
function webStat(folderPath)
    dim sDateTime, content, splStr 
    dim thisUrl, goToUrl, caiShu, c, fileName, co, ie, xp 
	call createDirFolder(folderPath)		'����ͳ��ָ���ļ���
    goToUrl = request.serverVariables("HTTP_REFERER") 
    thisUrl = "http://" & request.serverVariables("HTTP_HOST") & request.serverVariables("SCRIPT_NAME") 
    caiShu = request.serverVariables("QUERY_STRING") 
    if caiShu <> "" then
        thisUrl = thisUrl & "?" & caiShu 
    end if 
    goToUrl = request("GoToUrl") 
    thisUrl = request("ThisUrl") 
    co = request.queryString("co") 
    sDateTime = now() 
    content = request.serverVariables("HTTP_USER_AGENT") 
    content = replace(content, "MSIE", "Internet Explorer") 
    content = replace(content, "NT 5.0", "2000") 
    content = replace(content, "NT 5.1", "XP") 
    content = replace(content, "NT 5.2", "2003") 

    splStr = split(content & ";;;;", ";") 
    ie = splStr(1) 
    xp = trim(splStr(2)) 
    if right(xp, 1) = ")" then xp = mid(xp, 1, len(xp) - 1) 
    c = "����" & goToUrl & vbCrLf 
    c = c & "��ǰ��" & thisUrl & vbCrLf 
    c = c & "ʱ�䣺" & sDateTime & vbCrLf 
    c = c & "IP:" & getIP() & vbCrLf 
    c = c & "IE:" & getBrType("") & vbCrLf 
    c = c & "Cookies=" & co & vbCrLf 
    c = c & "XP=" & xp & vbCrLf 
    c = c & "Screen=" & request("screen") & vbCrLf                                  '��Ļ�ֱ���
    c = c & "�û���Ϣ=" & request.serverVariables("HTTP_USER_AGENT") & vbCrLf       '�û���Ϣ

    c = c & "-------------------------------------------------" & vbCrLf 
    'c=c & "CaiShu=" & CaiShu & vbcrlf
    fileName = folderPath & format_Time(now(), 2) & ".txt" 
    call createAddFile(fileName, c) 
    c = c & vbCrLf & fileName 
    c = replace(c, vbCrLf, "\n") 
    c = replace(c, """", "\""") 
    'Response.Write("eval(""var MyWebStat=\""" & C & "\"""")")

    dim splxx, nIP, nPV, ipList, s, ip 
    '�ж��Ƿ���ʾ���Լ�¼
    if request("stype") = "display" then
        content = getftext(fileName) 
        splxx = split(content, vbCrLf & "-------------------------------------------------" & vbCrLf) 
        nIP = 0 
        nPV = 0 
        ipList = "" 
        for each s in splxx
            if inStr(s, "��ǰ��") > 0 then
                s = vbCrLf & s & vbCrLf 
                ip = aDSql(getStrCut(s, vbCrLf & "IP:", vbCrLf, 0)) 
                nPV = nPV + 1 
                if inStr(vbCrLf & ipList & vbCrLf, vbCrLf & ip & vbCrLf) = false then
                    ipList = ipList & ip & vbCrLf 
                    nIP = nIP + 1 
                end if 
            end if 
        next 
        call rw("document.write('����ͳ�� | ����IP[" & nIP & "] | ����PV[" & nPV & "] ')") 
    end if 
    webStat = c 
end function 

'�жϴ�ֵ�Ƿ����
function checkFunValue(action, funName)
    checkFunValue =IIF(left(action, len(funName)) = funName, true, false) 
end function 
'HTML��ǩ�����Զ�����(target|title|alt|id|class|style|)    ������
function setHtmlParam(content, paramList)
    dim splStr, startStr, endStr, c, paramValue, replaceStartStr 
    endStr = "'" 
    splStr = split(paramList, "|") 
    for each startStr in splStr 
        startStr = trim(startStr) 
        if startStr <> "" then
            '�滻��ʼ�ַ�   ��Ϊ��ʼ�ַ����Ϳɱ� ��ͬ
            replaceStartStr = startStr 
            if left(replaceStartStr, 3) = "img" then
                replaceStartStr = mid(replaceStartStr, 4) 
            elseIf left(replaceStartStr, 1) = "a" then
                replaceStartStr = mid(replaceStartStr, 2) 
            elseIf inStr("|ul|li|", "|" & left(replaceStartStr, 2) & "|") > 0 then
                replaceStartStr = mid(replaceStartStr, 3) 
            end if 
            replaceStartStr = " " & replaceStartStr & "='" 

            startStr = " " & startStr & "='" 
            if inStr(content, startStr) > 0 and inStr(content, endStr) > 0 then
                paramValue = strCut(content, startStr, endStr, 2) 
                paramValue = handleInModule(paramValue, "end")                       '�����ڲ�ģ��
                c = c & replaceStartStr & paramValue & endStr 
            end if 
        end if 
    next 
    setHtmlParam = c 
end function 
%>       
