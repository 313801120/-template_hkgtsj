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
'Cai�ɼ�����(2014)
 
'��òɼ����� 
function getHttpPage(byVal httpurl, byVal sCharSet)
    getHttpPage = handleGetHttpPage(httpurl, sCharSet)(0)   
end function 
'������òɼ����� 
function handleGetHttpPage(byVal httpurl, byVal sCharSet)
    on error resume next 
    dim startTime, nStatus, nTime, content, sSplType, webFileSize 
    startTime = now() 
    sSplType = "|-*ypia=|" 
    sCharSet = handleStrCharSet(sCharSet) 
    if isNull(httpurl) = true or len(httpurl) < 7 or httpurl = "$False$" then
        handleGetHttpPage = split("" & sSplType & - 1 & sSplType & nTime & sSplType & webFileSize, sSplType) 
        exit function 
    end if 
 
    dim http 
    set http = createObject("MSXML2.XMLHTTP")
        call http.open("GET", httpurl, false) 
        http.send 
        if http.readyState <> 4 then
            set http = nothing 
            handleGetHttpPage = split("" & sSplType & http.readyState & sSplType & nTime & sSplType & webFileSize, sSplType) 
            exit function 
        end if 

        content = bytesToBstr(http.responseBody, sCharSet) 
        nStatus = http.status 
        nTime = dateDiff("s", startTime, now()) 
        webFileSize = strLength(content) 

        handleGetHttpPage = split(content & sSplType & nStatus & sSplType & nTime & sSplType & webFileSize, sSplType) 

    set http = nothing 
end function 
'�������url״̬
function getHttpUrlState(httpurl)
    getHttpUrlState = handleGetHttpPage(httpurl, "")(1) 
end function 
'�������url�ķ���������
function getHttpUrlServerName(httpurl)
    getHttpUrlServerName = ""                                                       '����php���õ�
end function 

'��òɼ����� (����)
function getURLContent(httpurl, sCharSet)
    getURLContent = getHttpPage(httpurl, sCharSet) 
end function 
'��òɼ����� (����)
function getHttpUrl(httpurl, sCharSet)
    getHttpUrl = getHttpPage(httpurl, sCharSet) 
end function 
function bytesToBstr(body, cset)
    dim objStream 
    if isNul(body) then exit function                                               'Ϊ�����˳�
    set objStream = createObject("ADODB.Stream")
        objStream.type = 1 
        objStream.mode = 3 
        objStream.open 
        call objStream.write(body) 
        objStream.position = 0 
        objStream.type = 2 
        objStream.charset = cset 
        bytesToBstr = objStream.readText 
        objStream.close 
    set objStream = nothing 
end function 
'��ȡ�ַ��� ����20160114
'c=[A]abbccdd[/A]
'0=abbccdd
'1=[A]abbccdd[/A]
'3=[A]abbccdd
'4=abbccdd[/A]
'��ȡ�ַ���
function strCut(byVal content, byVal startStr, byVal endStr, byVal nType)
    dim nS1, s1Str, nS2, nS3, c, tempContent, tempStartStr, tempEndStr ,cutType
    tempStartStr = startStr 
    tempEndStr = endStr 
    tempContent = content 
    cutType = "|" & nType & "|" 
    '�����ִ�Сд
    if inStr(cutType, "|lu|") > 0 then
        content = LCase(content) 
        startStr = LCase(startStr) 
        endStr = LCase(endStr) 
    end if 
    if inStr(content, startStr) = false or inStr(content, endStr) = false then
        c = "" 
        exit function 
    end if 
    if inStr(cutType, "|1|") > 0 then
        nS1 = inStr(content, startStr) 
        s1Str = mid(content, nS1 + len(startStr)) 
        nS2 = nS1 + inStr(s1Str, endStr) + len(startStr) + len(endStr) - 1                'ΪʲôҪ��1
    else
        nS1 = inStr(content, startStr) + len(startStr) 
        s1Str = mid(content, nS1) 
        'nS2 = InStr(nS1, content, EndStr)
        nS2 = nS1 + inStr(s1Str, endStr) - 1 
    end if 
    nS3 = nS2 - nS1 
    if nS3 >= 0 then
        c = mid(tempContent, nS1, nS3) 
    else
        c = "" 
    end if 
    if inStr(cutType, "|3|") > 0 then
        c = tempStartStr & c 
    end if 
    if inStr(cutType, "|4|") > 0 then
        c = c & tempEndStr 
    end if 
    strCut = c 
end function 
'��ý�ȡ����,20150305
function getStrCut(byVal content, byVal startStr, byVal endStr, byVal nType)
    getStrCut = strCut(content, startStr, endStr, nType) 
end function 
'��ȡ�ַ� CutStr(Content,22,"null")
Function cutStr(ByVal content, ByVal nCutValue, ByVal MoreStr)
    Dim i, nS, n 
    n = 0                                                 'ת������������    ׷����20141107
    If MoreStr = "" Then MoreStr = "..." 
    If LCase(MoreStr) = "none" Or LCase(MoreStr) = "null" Then MoreStr = "" 
    cutStr = content 
    For i = 1 To Len(content)
        nS = Asc(Mid(CStr(content), i, 1)) 
        If nS < 0 Then nS = nS + 65536 
        If nS < 255 Then n = n + 1 
        If nS > 255 Then n = n + 2 
        If n >= nCutValue Then cutStr = Left(content, i) & MoreStr : Exit Function 
    Next 
End Function 
'��ȡ���ݣ������ִ�Сд 20150327  C=CutStrNOLU(c,"<heAd",">")
function cutStrNOLU(content, startStr, endStr)
    dim s, LCaseContent, nStartLen, nEndLen, sNewStrStart 
    startStr = LCase(startStr) 
    endStr = LCase(endStr) 
    LCaseContent = LCase(content) 
	cutStrNOLU=""
    if inStr(LCaseContent, startStr) > 0 then
        nStartLen = inStr(LCaseContent, startStr) 
        s = mid(content, nStartLen) 
        LCaseContent = mid(s, len(startStr) + 1) 
        sNewStrStart = mid(s, 1, len(startStr) + 1)                                      '��ÿ�ʼ�ַ�

        LCaseContent = replace(LCaseContent, "<", "&lt;") 
        'Call eerr("111",LCaseContent)

        nEndLen = inStr(LCaseContent, endStr) 
        call echo("nEndLen", nEndLen)  

        s = mid(content, nStartLen, nEndLen + len(startStr)) 
        'Call Echo(nStartLen,nEndLen)
        'Call Echo("S",S)
        cutStrNOLU = s 
    end if 
end function 

'��ȡTD�ַ�
function setCutTDStr(byVal content, byVal TDWidth, byVal moreColor)
    dim i, s, c, n, nEnd, isMore 
    content = CStr(content & "") 
    if content = "" then setCutTDStr = content : exit function 
    if TDWidth = "" then setCutTDStr = content : exit function                      'TDWidthΪ�գ���Ϊ�Զ�
    n = 0 : isMore = false 
    nEnd = int(cint(TDWidth) / 6.3) 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if n >= nEnd then
            isMore = true 
            exit for 
        else
            c = c & s 
        end if 
        if asc(s) < 0 then
            n = n + 2 
        else
            n = n + 1 
        end if 
    next 
    if isMore = true then
        '��Ҫ����Title�����HTML
        c = "<span Title=""" & displayHtml(content) & """ style=""background-color:" & moreColor & ";"">" & c & "</span>" 
    end if 
    setCutTDStr = c 
end function 
'��ȡTD�ַ� (����)
function cutTDStr(content, TDWidth)
    cutTDStr = setCutTDStr(content, TDWidth, "#FBE3EF") 
end function 
'�ָ��ַ�
function getArrayList(byVal content, byVal startStr, byVal endStr, byVal isStart, byVal isEnd, byVal sType)
    'on error resume next
    if isNull(content) = true or isNull(startStr) = true or isNull(endStr) = true then
        getArrayList = "" 
        exit function 
    end if 
    dim c, rep, matches, theMatch 
    content = replace(replace(content, chr(10), "�����С�"), chr(13), "�����С�") '�滻������
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "(" & startStr & ").+?(" & endStr & ")" 
        set matches = rep.execute(content)
            for each theMatch in matches
                c = c & "$Array$" & theMatch.value 
            next 
        set matches = nothing 
        if c = "" then
            getArrayList = "" 
            exit function 
        end if 
        c = right(c, len(c) - 7) 
        if isStart = false then
            rep.pattern = startStr 
            c = rep.replace(c, "") 
        end if 
        if isEnd = false then
            rep.pattern = endStr 
            c = rep.replace(c, "") 
        end if 
    set rep = nothing 
    if sType = "1" or sType = "ȥ���ַ�" or sType = true then
        c = replace(c, """", "") 
        c = replace(c, "'", "") 
        c = replace(c, " ", "") 
        c = replace(c, "(", "") 
        c = replace(c, ")", "") 
    end if 
    getArrayList = c 
end function 



'������20160801
function getArrayNew( byval content, startStr, endStr, isStart, isEnd) 
	dim i,s,listStr,nStartLen,nEndLen
    for  i = 0 to  999 				'30Ϊ��ȡ����
		'echo(content . "=" & instr(content, startStr))
		'call echo(instr(content, startStr) , instr(content, endStr))
        nStartLen=instr(content, startStr)
		nEndLen=instr(content, endStr)
		if nStartLen  > 0 and nEndLen > 0 then 		
			
			s=mid(content,1,nEndLen-1)
			content=mid(content,nEndLen+len(endStr))
			s=mid(s,instr(s,startStr)+len(startStr)) 
			
			if listStr<>"" then
				listStr=listStr & "$Array$"
			end if 
			if isStart=true then
				s=startStr & s
			end if
			if isEnd=true then
				s=s & endStr
			end if
			listStr=listStr & s
			
			
        else
			exit for
		end if
	next    
    getArrayNew = listStr
end function

'�ָ��ַ� �������ַ� (����)
function getArray(content, startStr, endStr, isStart, isEnd)
    getArray = getArrayList(content, startStr, endStr, isStart, isEnd, "") 
end function 
'�ָ��ַ� ȥ���ַ� (����)
function getArray1(content, startStr, endStr, isStart, isEnd)
    getArray1 = getArrayList(content, startStr, endStr, isStart, isEnd, "ȥ���ַ�") 
end function 
'��ȡָ���ָ�ֵ
function getSplit(byVal content, byVal sSplit, byVal n)
    dim splxx 
    splxx = split(content, sSplit) 
    getSplit = splxx(n) 
end function  
'��÷�������
function getSplitCount(byVal content, byVal sSplit)
    dim splxx 
    splxx = split(content, sSplit) 
	getSplitCount=0
    getSplitCount = uBound(splxx) 
    if getSplitCount > 0 then getSplitCount = getSplitCount + 1                     '��Ϊ�ռ�һ
	
end function 

'���� ��Ϊ��������VB��������
function agent(byVal httpurl)
    'On Error Resume Next
    server.scriptTimeout = 999 
    '----------
    '��ȡԶ������
    dim http 
    set http = createObject("WinHttp.WinHttpRequest.5.1")

        http.open "GET", httpurl, false 
        if request.serverVariables("HTTP_REFERER") <> "" then
            http.setRequestHeader "Referer", request.serverVariables("HTTP_REFERER") 
        end if 
        if request.cookies <> "" then
            http.setRequestHeader "Cookie", request.cookies 
        end if 
        http.setRequestHeader "User-Agent", request.serverVariables("HTTP_USER_AGENT") 
        http.setRequestHeader "X-Forwarded-For", request.serverVariables("REMOTE_ADDR") & ", " & request.serverVariables("LOCAL_ADDR") 
        http.setRequestHeader "Connection", "Close" 
        http.setRequestHeader "Nuclear-Atk", "http://" & request.serverVariables("HTTP_HOST") & request.serverVariables("SCRIPT_NAME") & "?" & request.queryString 
        http.setRequestHeader "Nuclear-Atk-Host", request.serverVariables("HTTP_HOST") 
        http.send 

        response.status = http.status & " " & http.statusText                           '�հ�Զ��HTTP״̬����״̬�����ı�
        response.contentType = http.getResponseHeader("Content-Type")                   '�հ�Զ����������
        response.binaryWrite http.responseBody                                          '�������������
end function



'��XML.ASP����

'����ע����ַ�����û����վע����ַ
function handlUrlCanShu(httpurl)
    dim url, splStr, i, s, s1, s2 
    splStr = split(httpurl, "=") 
    for i = 0 to uBound(splStr)
        s = splStr(i) 
        if url <> "" then url = url & "=" 
        if inStr(s, "&")>0 then
            s1 = mid(s, 1, inStr(s, "&") - 1) 
            s2 = mid(s, inStr(s, "&")) 
            s = escape(s1) & s2 
        elseIf i = uBound(splStr) then
            s = escape(s) 
        end if 
        url = url & s 
    next 
    handlUrlCanShu = url 
end function 


'�����ַ����� 20150723
function handleStrCharSet(sSetChar)
    if sSetChar = "1" or uCase(sSetChar) = "GB2312" or sSetChar = "" then
        sSetChar = "GB2312" 
    elseIf sSetChar = "0" or uCase(sSetChar) = "UTF-8" then
        sSetChar = "UTF-8" 
    elseIf sSetChar = "2" or uCase(sSetChar) = "UNICODE" then
        sSetChar = "UNICODE" 
    end if 
    handleStrCharSet = sSetChar 
end function 


'URL����  �Լ�д�ò���ʹ�ã�UTF8_urlEncodingû��������
function urlEncoding(str)
    '׷�ӿɲ�Ҫ
    str = replace(str, "1", "%31") 
    str = replace(str, "0", "%30") 
    str = replace(str, "A", "%41") 
    str = replace(str, "��", "%CE%D2") 
    str = replace(str, "#", "%23") 
    'ԭʼ
    str = replace(str, "a", "%61") 
    str = replace(str, "n", "%6E") 
    str = replace(str, "d", "%64") 
    str = replace(str, " ", "%20") 
    str = replace(str, "=", "%3D") 
    str = replace(str, "e", "%65") 
    str = replace(str, "x", "%78") 
    str = replace(str, "i", "%69") 
    str = replace(str, "s", "%73") 
    str = replace(str, "t", "%74") 
    str = replace(str, "(", "%28") 
    str = replace(str, ")", "%29") 
    str = replace(str, "l", "%6C") 
    str = replace(str, "c", "%63") 
    str = replace(str, "*", "%2A") 
    str = replace(str, "f", "%66") 
    str = replace(str, "r", "%72") 
    str = replace(str, "o", "%6F") 
    str = replace(str, "m", "%6D") 
    str = replace(str, "w", "%77") 
    str = replace(str, "h", "%68") 
    urlEncoding = str 
end function 

%>     

