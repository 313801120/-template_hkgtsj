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
 

'����function2�ļ�����
function callFunction2()
    dim sType 
    sType = request("stype") 
    if sType = "runScanWebUrl" then
        call runScanWebUrl()          '����ɨ����ַ
    elseif sType = "scanCheckDomain" then
        call scanCheckDomain()        '���������Ч
    elseif sType = "bantchImportDomain" then
        call bantchImportDomain()     '������������
    elseif sType = "scanDomainHomePage" then
        call scanDomainHomePage()     'ɨ��������ҳ
    elseif sType = "scanDomainHomePageSize" then
        call scanDomainHomePageSize() 'ɨ��������ҳ��С�����
    elseif sType = "isthroughTrue" then
        call isthroughTrue()          '�����ȫ��Ϊ��
    elseif sType = "printOKWebSite" then
        call printOKWebSite()         '��ӡ��Ч��ַ
    elseif sType = "printAspServerWebSite" then
        call printAspServerWebSite()  '��ӡasp������վ
    elseif sType = "clearAllData" then
        call fun2_clearAllData()      '���ȫ������
    elseif sType = "function2test" then
        call function2test()          '����
    else 
		call eerr("function2ҳ��û�ж���", request("stype"))
    end if 
end function

'����
function function2test()
    Call openconn() 		
	'��@��jsp��ʾ@��try{							
    rs.Open "select * from " & db_PREFIX & "webdomain where isdomain=true", conn, 1, 1
	call echo("��",rs.recordcount)
    While Not rs.EOF
		call echo(rs("isdomain"),rs("website"))
	rs.movenext:wend:rs.close
	'��@��jsp��ʾ@��}catch(Exception e){}
end function
'���ȫ������
function fun2_clearAllData()
    Call openconn() 
    conn.Execute("delete from " & db_PREFIX & "webdomain") 
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebDomain&addsql=order by id desc&lableTitle=��վ����'>OK</a>") 
end function
'��ӡ��Ч��ַ
function printOKWebSite()	
    Call openconn()
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "webdomain where isdomain=true", conn, 1, 1 
	call echo("��",rs.recordcount)
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebDomain&addsql=order by id desc&lableTitle=��վ����'>OK</a>") 
    While Not rs.EOF
		'call echo(rs("isdomain"),rs("website"))
		call rw(rs("website") & "<br>")
	rs.movenext:wend:rs.close
	'��@��jsp��ʾ@��}catch(Exception e){}
end function
'��ӡasp������վ
function printAspServerWebSite()	
    Call openconn()
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "webdomain where isasp=true and (isaspx=false and isphp=false)", conn, 1, 1 
	call echo("��",rs.recordcount)
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebDomain&addsql=order by id desc&lableTitle=��վ����'>OK</a>") 
    While Not rs.EOF
		'call echo(rs("isdomain"),rs("website"))
		call rw(rs("website") & "<br>")
	rs.movenext:wend:rs.close
	'��@��jsp��ʾ@��}catch(Exception e){}
end function

'�����ȫ��Ϊ��
function isthroughTrue()
    Call openconn() 
    conn.Execute("update " & db_PREFIX & "webdomain set isthrough=true") 
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebDomain&addsql=order by id desc&lableTitle=��վ����'>OK</a>") 
end function

'ɨ����ҳ��С
Function scanDomainHomePageSize()
    Dim url, nSetTime, isdomain, htmlDir, txtFilePath,homePageList,nThis,nCount
	dim splstr,s,c,website,nState,longWebSize,content,startTime,webtitle,webkeywords,webdescription
	  
	if request("nThis")="" then
		nThis=0
	else
		nThis=request("nThis")
	end if
	
    nSetTime = 3 
    Call openconn() 
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "webdomain where website<>'' and websize=0 and isdomain=true", conn, 1, 1 
	
	if request("nCount")="" then
		nCount=rs.recordcount
	else
		nCount=request("nCount")
	end if
    While Not rs.EOF
		nThis=nThis+1 
        Call echo(nThis & "/" & nCount, rs("website")) 
        doevents 
        htmlDir = "/../��վUrlScan/������ҳ��С/"
        Call createDirFolder(htmlDir) 
        txtFilePath = htmlDir & "/" & setFileName(rs("website")) & ".txt"
        If checkFile(txtFilePath) = True Then 
            Call echo("����", "����") 
			nSetTime=1
        Else
			website=getwebsite(rs("website"))
			if website="" then
				call eerr("����Ϊ��",website)
			end if
		 	content=getHttpPage(website,rs("charset"))
	        '��PHP��$content=toGB2312Char($content);                                            //��PHP�ã�ת��gb2312�ַ�
			if content="" then
				content=" "
			end if
			
            Call createFile(txtFilePath, content)
            Call echo("����", "����") 
        End If 
		content=getftext(txtFilePath)
		webtitle=getHtmlValue(content,"webtitle")
		webkeywords=getHtmlValue(content,"webkeywords")
		webdescription=getHtmlValue(content,"webdescription")
		
		
		longWebSize=getfsize(txtFilePath)
		call echo("webtitle",webtitle)
        '����д�Ǹ�תPHPʱ����
        conn.Execute("update " & db_PREFIX & "webdomain  set webtitle='"& ADSql(webtitle) &"',webkeywords='"& webkeywords &"',webdescription='"& webdescription &"',websize="& longWebSize &",isthrough=false,updatetime='" & Now() & "'  where id=" & rs("id") & "")

		
		if request("startTime")="" then
			startTime=now()
		else
			startTime=request("startTime")
		end if
		
		call rw(VBRunTimer(startTime) & "<hr>")
        url = getUrlAddToParam(getThisUrl(), "?nThis="& nThis &"&nCount="& nCount &"&startTime="& startTime &"&N=" & getRnd(11), "replace") 
 
        Call rw(jsTiming(url, nSetTime)) 
        Response.End() 
    rs.MoveNext : Wend : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){}
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebDomain&addsql=order by id desc&lableTitle=��վ����'>OK����("& nThis &")��</a>") 
End Function 

'ɨ��������ҳ
Function scanDomainHomePage()
    Dim url, nSetTime, isdomain, htmlDir, txtFilePath,homePageList,nThis,nCount
	dim splstr,s,c,website,nState,startTime
	dim nIsAsp,nIsAspx,nIsPhp,nIsJsp,c2
	nIsAsp=0:nIsAspx=0:nIsPhp=0:nIsJsp=0
 
	if request("nThis")="" then
		nThis=0
	else
		nThis=request("nThis")
	end if
	
    nSetTime = 3 
    Call openconn() 
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "webdomain where website<>'' and homepagelist='' and isdomain=true", conn, 1, 1 
	
	if request("nCount")="" then
		nCount=rs.recordcount
	else
		nCount=request("nCount")
	end if
    While Not rs.EOF
		nThis=nThis+1 
        Call echo(nThis & "/" & nCount, rs("website")) 
        doevents 
        htmlDir = "/../��վUrlScan/������ҳ/"
        Call createDirFolder(htmlDir) 
        txtFilePath = htmlDir & "/" & setFileName(rs("website")) & ".txt"
        If checkFile(txtFilePath) = True Then
            c = phptrim(getFText(txtFilePath))
			nIsAsp=cint(getstrcut(c,"isAsp=",vbcrlf,1))
			nIsAspx=cint(getstrcut(c,"isAspx=",vbcrlf,1))
			nIsPhp=cint(getstrcut(c,"isPhp=",vbcrlf,1))
			nIsJsp=cint(getstrcut(c,"isJsp=",vbcrlf,1))
            Call echo("����", "����") 
			nSetTime=1
        Else
			website=getwebsite(rs("website"))
			if website="" then
				call eerr("����Ϊ��",website)
			end if
			splstr=split("index.asp|index.aspx|index.php|index.jsp|index.htm|index.html|default.asp|default.aspx|default.jsp|default.htm|default.html","|")
			c2=""
			homePageList=""
			for each s in splstr
				url=website & s
				nState=getHttpUrlState(url)
				call echo(url,nState & "   ("& getHttpUrlStateAbout(nState) &")")
				doevents
				if (s="index.asp" or s="default.asp") and (nState=200 or nState=302) then
					nIsAsp=1
				elseif (s="index.aspx" or s="default.aspx") and (nState=200 or nState=302) then
					nIsAspx=1
				elseif (s="index.php" or s="default.php") and (nState=200 or nState=302) then
					nIsPhp=1
				elseif (s="index.jsp" or s="default.jsp") and (nState=200 or nState=302) then
					nIsJsp=1
				end if
				if nState=200 or nState=302 then
					homePageList=homePageList & s & "|"
				end if
				c2=c2 & s & "=" & nState & vbcrlf
			next
			c= "isAsp=" & nIsAsp & vbcrlf
			c= c & "isAspx=" & nIsAspx & vbcrlf
			c= c & "isPhp=" & nIsPhp & vbcrlf
			c= c & "isJsp=" & nIsJsp & vbcrlf & c2
			
			if homePageList="" then
				homePageList="��"
			end if
			
            Call createFile(txtFilePath, c) 
            Call echo("����", "����") 
        End If 
        '����д�Ǹ�תPHPʱ����
        conn.Execute("update " & db_PREFIX & "webdomain  set isasp="& nIsAsp &",isaspx="& nIsAspx &",isphp="& nIsPhp &",isjsp="& nIsJsp &",isthrough=false,homepagelist='"& homePageList &"',updatetime='" & Now() & "'  where id=" & rs("id") & "") 

		if request("startTime")="" then
			startTime=now()
		else
			startTime=request("startTime")		
		end if
		
		call rw(VBRunTimer(startTime) & "<hr>")
        url = getUrlAddToParam(getThisUrl(), "?nThis="& nThis &"&nCount="& nCount &"&startTime="& startTime &"&N=" & getRnd(11), "replace") 
 
        Call rw(jsTiming(url, nSetTime)) 
        Response.End() 
    rs.MoveNext : Wend : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){}
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebDomain&addsql=order by id desc&lableTitle=��վ����'>OK����("& nThis &")��</a>") 
End Function 

'������������
Function bantchImportDomain()
    Dim content, splStr, url, webSite, nOK 
    content = LCase(Request.Form("bodycontent")) 
    splStr = Split(content, vbCrLf) 
    nOK = 0 
    Call openconn() 
    For Each url In splStr
        webSite = getwebsite(url) 
        If webSite <> "" Then
			'��@��jsp��ʾ@��try{
            rs.Open "select * from " & db_PREFIX & "webdomain where website='" & webSite & "'", conn, 1, 1 
            If rs.EOF Then
                conn.Execute("insert into " & db_PREFIX & "webdomain(website,isthrough,isdomain) values('" & webSite & "',true,false)") 
                Call echo("���ӳɹ�", webSite) 
                nOK = nOK + 1 
            Else
                Call echo("website", webSite) 
            End If : rs.Close 
			'��@��jsp��ʾ@��}catch(Exception e){}
        End If 
    Next 
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebDomain&addsql=order by id desc&lableTitle=��վ����'>OK ��(" & nOK & ")��</a>") 
End Function 

'���������Ч
Function scanCheckDomain()
    Dim url, nSetTime, nIsDomain, htmlDir, txtFilePath, nThis,nCount,startTime
    nSetTime = 3 
	if request("nThis")="" then
		nThis=0
	else
		nThis=request("nThis")
	end if
    Call openconn()
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "webdomain where isthrough=true", conn, 1, 1 
	
	if request("nCount")="" then
		nCount=rs.recordcount
	else
		nCount=request("nCount")
	end if
    While Not rs.EOF
		nThis=nThis+1
        Call echo(nThis & "/" & nCount, rs("website")) 
        doevents 
        htmlDir = "/../��վUrlScan/����/"
        Call createDirFolder(htmlDir) 
        txtFilePath = htmlDir & "/" & setFileName(rs("website")) & ".txt"
        If checkFile(txtFilePath) = True Then
            nIsDomain = cint(phptrim(getFText(txtFilePath)))
            Call echo("����", "����") 
			nSetTime=1
        Else
            nIsDomain = IIF(checkDomainName(rs("website")), 1, 0) 
            Call createFile(txtFilePath, nIsDomain & " ") 			'��ֹPHP��д�벻��ȥ 0 �������
            Call echo("����", "����" & txtFilePath & "("& checkFile(txtFilePath) &")=" & nIsDomain) 
        End If 
        '����д�Ǹ�תPHPʱ����
        conn.Execute("update " & db_PREFIX & "webdomain  set isthrough=false,isdomain=" & nIsDomain & ",updatetime='" & Now() & "'  where id=" & rs("id") & "") 

		if request("startTime")="" then
			startTime=now()
		else
			startTime=request("startTime")
		end if
		
		call rw(VBRunTimer(startTime) & "<hr>")
        url = getUrlAddToParam(getThisUrl(), "?nThis="& nThis &"&nCount="& nCount &"&startTime="& startTime &"&N=" & getRnd(11), "replace") 
		
        Call rw(jsTiming(url, nSetTime)) 
        Response.End() 
    rs.MoveNext : Wend : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){}
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebDomain&addsql=order by id desc&lableTitle=��վ����'>OK����("& nThis &")��</a>") 
End Function 

'ɨ����ַ
Function runScanWebUrl()
    Dim nSetTime, setCharSet, httpUrl, url, selectWeb ,nThis,nCount,startTime
    setCharSet = "gb2312"                                                           'gb2312
    'http://www.dfz9.com/
    'http://www.maiside.net/
    'http://sharembweb.com/
    'http://www.ufoer.com/
    httpUrl = "http://sharembweb.com/" 
    'selectWeb="ufoer"
    If selectWeb = "ufoer" Then
        httpUrl = "http://www.ufoer.com/" 
        setCharSet = "utf-8" 
    End If
	 
	if request("nThis")="" then
		nThis=0
	else
		nThis=request("nThis")
	end if
	
    Call openconn() 
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "weburlscan", conn, 1, 1 	
	if request("nCount")="" then
		nCount=rs.recordcount
	else
		nCount=request("nCount")
	end if
    If rs.EOF Then
        conn.Execute("insert into " & db_PREFIX & "weburlscan(httpurl,title,isthrough,charset) values('" & httpUrl & "','home',true,'" & setCharSet & "')") 
    End If : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){} 
    'ѭ��
	'��@��jsp��ʾ@��try{
    rsx.Open "select * from " & db_PREFIX & "weburlscan where isThrough=true", conn, 1, 1 
    If Not rsx.EOF Then
		nThis=nThis+1
        Call echo(nThis,  rsx("httpurl"))  
        doevents 
        nSetTime = scanUrl(rsx("httpurl"), rsx("title"), rsx("charset")) 
        '����д�Ǹ�תPHPʱ����
        conn.Execute("update " & db_PREFIX & "weburlscan  set isthrough=false  where id=" & rsx("id") & "") 

		
		if request("startTime")="" then
			startTime=now()
		else
			startTime=request("startTime")
		end if
		
		call VBRunTimer(startTime)
        url = getUrlAddToParam(getThisUrl(), "?nThis="& nThis &"&nCount="& nCount &"&startTime="& startTime &"&N=" & getRnd(11), "replace") 

        Call rw(jsTiming(url, nSetTime)) 
        Response.End()
    End If : rsx.Close  
	'��@��jsp��ʾ@��}catch(Exception e){}
    Call echo("�������", "<a href='?act=dispalyManageHandle&actionType=WebUrlScan&addsql=order by id desc&lableTitle=��ַɨ��'>OK����("& nThis &")��</a>") 
    '���뱨��
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "weburlscan where webstate=404", conn, 1, 1 
    While Not rs.EOF
        Call echo("<a href='" & rs("httpurl") & "' target='_blank'>" & rs("httpurl") & "</a>", "<a href='" & rs("tohttpurl") & "' target='_blank'>" & rs("tohttpurl") & "</a>") 
    rs.MoveNext : Wend : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){}
End Function 
'ɨ����ַ
Function scanUrl(httpUrl, toTitle, codeset)
    Dim splStr, i, s, content, PubAHrefList, PubATitleList, splUrl, spltitle, title, url, htmlDir, htmlFilePath, nOK, arrayData, nWebState, u, iniDir, iniFilePath ,longWebSize
    Dim nSetTime, startTime, longOpenSpeed, isLocal, nIsThrough
    htmlDir = "/../��վUrlScan/" & setFileName(getwebsite(httpUrl)) 
    Call createDirFolder(htmlDir) 
    htmlFilePath = htmlDir & "/" & setFileName(httpUrl) & ".html" 
    iniDir = htmlDir & "/conifg" 
    Call createfolder(iniDir) 
    iniFilePath = iniDir & "/" & setFileName(httpUrl) & ".txt" 

    'httpurl="http://maiside.net/"

    nWebState = 0 
    nSetTime = 1 
    longOpenSpeed = 0 
    If checkFile(htmlFilePath) = False Then
        startTime = Now() 
        Call echo("codeset", codeset) 
        arrayData = handleXmlGet(httpUrl, codeset) 
        content = arrayData(0) 
        '��PHP��$content=toGB2312Char($content);                                            //��PHP�ã�ת��gb2312�ַ�

        nWebState = cint(arrayData(1)) 
        longOpenSpeed = DateDiff("s", startTime, Now()) 
        'content=gethttpurl(httpurl,codeset)
        'call createfile(htmlFilePath,content)
        Call writeToFile(htmlFilePath, content, codeset) 
        Call createFile(iniFilePath, nWebState & vbCrLf & longOpenSpeed) 
        nSetTime = 3 
        isLocal = false
    Else
        'content=getftext(htmlFilePath)
        content = readFile(htmlFilePath, codeset) 
		 '��PHP��$content=toGB2312Char($content);                                            //��PHP�ã�ת��gb2312�ַ�
        splStr = Split(getftext(iniFilePath), vbCrLf) 
        nWebState = CInt(splStr(0)) 
        longOpenSpeed = CInt(splStr(0)) 
        isLocal = true 
    End If 
	longWebSize=getFSize(htmlFilePath)
    Call echo("isLocal", isLocal) 
	'��@��jsp��ʾ@��try{
    rs.Open "select * from " & db_PREFIX & "weburlscan where httpurl='" & httpUrl & "'", conn, 1, 1 
    If rs.EOF Then
        conn.Execute("insert into " & db_PREFIX & "weburlscan(httpurl,title,charset) values('" & httpUrl & "','" & toTitle & "','" & codeset & "')") 
    End If : rs.Close 
	'��@��jsp��ʾ@��}catch(Exception e){} 
    conn.Execute("update " & db_PREFIX & "weburlscan  set webstate=" & nWebState & ",websize=" & longWebSize & ",openspeed=" & longOpenSpeed & ",charset='" & codeset & "'  where httpurl='" & httpUrl & "'") 

	'strLen(content)  �������������׼

    s = getContentAHref("", content, PubAHrefList, PubATitleList) 
    s = handleScanUrlList(httpUrl, s) 

    'call echo("httpurl",httpurl)
    'call echo("s",s)
    'call echo("PubATitleList",PubATitleList)
    nOK = 0 
    splUrl = Split(PubAHrefList, vbCrLf) 
    spltitle = Split(PubATitleList, vbCrLf) 
    For i = 1 To UBound(splUrl)
        title = spltitle(i) 
        url = splUrl(i) 
        'ȥ��#�ź�̨���ַ�20160506
        If InStr(url, "#") > 0 Then
            url = Mid(url, 1, InStr(url, "#") - 1) 
        End If 
        If url = "" Then
            If title <> "" Then
                Call echo("��ַΪ��", title) 
            End If 
        Else
            url = handleScanUrlList(httpUrl, url) 
            url = handleWithWebSiteList(httpUrl, url) 
            If url <> "" Then
				'��@��jsp��ʾ@��try{
                rs.Open "select * from " & db_PREFIX & "weburlscan where httpurl='" & url & "'", conn, 1, 1 
                If rs.EOF Then
                    u = LCase(url)
                    If InStr(u, "tools/downfile.asp") > 0 Or InStr(u, "/url.asp?") > 0 Or InStr(u, "/aspweb.asp?") > 0 Or InStr(u, "/phpweb.php?") > 0 Or u = "http://www.maiside.net/qq/" Or InStr(u, "mailto:") > 0 Or InStr(u, "tel:") > 0 Or InStr(u, ".html?replytocom") > 0 Then'.html?replytocom  ��ͨ��վ
                        nIsThrough = 0 
                    Else
                        nIsThrough = 1 '����true ��Ϊд�����ݻ�������
                    End If 
                    conn.Execute("insert into " & db_PREFIX & "weburlscan(tohttpurl,totitle,httpurl,title,isthrough,charset) values('" & httpUrl & "','" & toTitle & "','" & url & "','" & Left(title, 255) & "'," & nIsThrough & ",'" & codeset & "')") 
                    nOK = nOK + 1 
                    Call echo(i, url) 
                Else
                    Call echo(title, url) 
                End If : rs.Close 
				'��@��jsp��ʾ@��}catch(Exception e){} 
            End If 
        End If 
    Next
	
    scanUrl = nSetTime 
End Function 


%>                  
