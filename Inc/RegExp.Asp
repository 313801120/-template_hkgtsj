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
'FSO  VBscript.RegExp���������ȫ (2013,9,29)

'����ַ��Ƿ����,��Сд����
function checkStr(byVal content, byVal serchValue)
    on error resume next 
    dim rep, search 
    checkStr = true 
    set rep = createObject("VBscript.RegExp")
        rep.global = true                                                               '����ȫ�����ʡ�
        rep.ignoreCase = true                                                           '�����Ƿ�������ĸ�Ĵ�Сд��True������Falsh����
        rep.pattern = serchValue 
        set search = rep.execute(content)
            if search.count = 0 then checkStr = false 
        set search = nothing 
    set rep = nothing 
    if err then call doError(err.description, "CheckStr ����ַ��Ƿ���� ����������SerchValue=" & serchValue) 
end function 
'����ַ��Ƿ���� (����)
function regExp_CheckStr(content, serchValue)
    regExp_CheckStr = checkStr(content, serchValue) 
end function 
'����ַ��Ƿ���� (����)
function existsStr(content, serchValue)
    existsStr = checkStr(content, serchValue) 
end function 
'����ַ��Ƿ���� (����)
function regExp_Instr(content, serchValue)
    regExp_Instr = checkStr(content, serchValue) 
end function 

'�滻����,�����ִ�Сд
function regExp_Replace(byVal content, byVal setPattern, byVal tStr)
    on error resume next 
    dim rep 
    set rep = createObject("VBscript.RegExp")
        rep.pattern = setPattern                                                        '����ģʽ��
        rep.ignoreCase = true                                                           '�����Ƿ�������ĸ�Ĵ�Сд��
        rep.global = true                                                               '����ȫ�����ʡ�
        regExp_Replace = rep.replace(content, tStr) 
    set rep = nothing 
    if err then call doError(err.description, "RegExp_Replace �滻���� ����������SetPattern=" & setPattern & " |Str=" & tStr) 
end function 
'�滻�����Զ�����ɫ,�����ִ�Сд
function replaceColor(content, setPattern, tStr, color)
    if color <> "" then tStr = "<font color=" & color & ">" & tStr & "</font>" 
    replaceColor = regExp_Replace(content, setPattern, tStr) 
end function 
'ɾ��HTML��ǩ
function delHtml(byVal strHtml)
    on error resume next 
    dim rep, strOutput 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "(<[a-zA-Z].*?>)|(<[\/][a-zA-Z].*?>)" 
        strOutput = rep.replace(strHtml, "") 
        delHtml = strOutput 
    set rep = nothing 
    if err then call doError(err.description, "DelHtml ɾ��HTML��ǩ ����������") 
end function 

'ɾ��HTML��ǩ (����)
function regExp_DelHtml(strHtml)
    regExp_DelHtml = delHtml(strHtml) 
end function 
'�������������������б�  getAUrlTitleList(Content,"��ַ")
function getAUrlTitleList(byVal content, byVal sType)
    on error resume next 
    dim s, c, setExecute, setValue, rep 
    c = "" 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<a [^>]*href *= *[""']([^""'> ]+)[^>]*>([^<]+)" 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                if sType = "����" or sType = "��ַ" or sType = "0" then
                    s = setValue.subMatches(0) 
                elseIf sType = "����" or sType = "1" then
                    s = setValue.subMatches(1) 
                else
                    s = setValue.subMatches(0) & "$Array$" & setValue.subMatches(1) 
                end if 
                if inStr(vbCrLf & c & vbCrLf, vbCrLf & s & vbCrLf) = false then
                    c = c & s & vbCrLf 
                end if 
            next 
        set setExecute = nothing 
    set rep = nothing 
    if c <> "" then c = left(c, len(c) - 2) 
    getAUrlTitleList = c 
    if err then call doError(err.description, "GetHrefUrlTitleList �������������������б� ����������C=" & c) 
end function 
'�����������ַ (����)
function getAURL(content)
    getAURL = getAUrlTitleList(content, 0) 
end function 
'��������б��� (����)
function getATitle(content)
    getATitle = getAUrlTitleList(content, 1) 
end function 
'�����������ַ�ͱ��� (����)
function getAURLTitle(content)
    getAURLTitle = getAUrlTitleList(content, "���Ӻͱ���") 
end function 


'�������������������б�  GetAUrlTitleList(Content,"��ַ")
function getContentAUrlList(byVal content)
    on error resume next 
    dim s, c, setExecute, setValue, rep 
    c = "" 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<a [^>]*href *= *[""']([^""'> ]+)[^>]*>" 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                s = setValue.subMatches(0) 
                if inStr(vbCrLf & c & vbCrLf, vbCrLf & s & vbCrLf) = false then
                    c = c & s & vbCrLf 
                end if 
            next 
        set setExecute = nothing 
    set rep = nothing 
    if c <> "" then c = left(c, len(c) - 2) 
    getContentAUrlList = c 
    if err then call doError(err.description, "GetHrefUrlTitleList �������������������б� ����������C=" & c) 
end function 


'���ͼƬ����ַ
function regExp_GetImgUrlList(byVal content, byVal sType)
    on error resume next 
    dim setExecute, setValue, rep, imgType, s, c 
    c = "" 
    sType = LCase(sType) 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<img *src *= *[""|'| ]*([^""'> ]+)" 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                s = setValue.subMatches(0) 
                imgType = right(s, len(s) - inStrRev(s, ".")) 
                if sType = imgType or sType = "ȫ��" or sType = "" then
                    if inStr(vbCrLf & c & vbCrLf, vbCrLf & s & vbCrLf) = false then
                        c = c & s & vbCrLf 
                    end if 
                end if 
            next 
        set setExecute = nothing 
    set rep = nothing 
    if c <> "" then c = left(c, len(c) - 2) 
    regExp_GetImgUrlList = c 
    if err then call doError(err.description, "GetIMGUrlList ���ͼƬ����ַ ����������c=" & c) 
end function 
'���ͼƬ����ַ (����)
function getIMG(content)
    getIMG = regExp_GetImgUrlList(content, "ȫ��") 
end function 
'���ͼƬ��JPG��ַ (����)
function getIMGJpg(content)
    getIMGJpg = regExp_GetImgUrlList(content, "JPG") 
end function 
'���ͼƬ��Gif��ַ (����)
function getIMGGif(content)
    getIMGGif = regExp_GetImgUrlList(content, "GIF") 
end function 
'���ͼƬ��Bmp��ַ (����)
function getIMGBmp(content)
    getIMGBmp = regExp_GetImgUrlList(content, "Bmp") 
end function 
'���ASP�Զ������б�����ϻ��ASP���Զ�����(2013,9,30
function getASPFunctionList(byVal content)
    on error resume next 
    dim setExecute, setValue, rep, imgType, s, c 
    c = "" 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "(sub|function) .*?\)" 
        'Rep.Pattern = "\s(sub|function)( .*?)(\(.*)|\s(sub|function)( .*?[ |    ])"            '����׼20150722
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                c = c & setValue & vbCrLf 
            next 
        set setExecute = nothing 
    set rep = nothing 
    if c <> "" then c = left(c, len(c) - 2) 
    getASPFunctionList = c 
    if err then call doError(err.description, "GetASPFunctionList ���ASP�����б� ����������c=" & c) 
end function 
'���ASP�Զ������б�����ϻ��ASP���Զ�����(2013,9,30
function getASPDimFunction(byVal content, funValue, funName, funDim)
    'On Error Resume Next
    content = replace(content, "()", "( )")                                         'Ϊ��ֹ��ȡ��������
    dim setExecute, setValue, rep 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        'Rep.Pattern = "(sub|function) .*?\)"
        content = regExp_Replace(content, "ByVal ", "") 
        rep.pattern = "(sub|function) *([^\(]+) *\(([^\)]+)\)" 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                '{�ַ������ж���JS����
                if inStr(funValue, "{") = false then
                    funValue = funValue & trim(setValue) & vbCrLf 
                    funName = funName & trim(setValue.subMatches(1)) & vbCrLf 
                    funDim = funDim & replace(setValue.subMatches(2), " ", "") & vbCrLf 
                end if 
            next 
        set setExecute = nothing 
    set rep = nothing 
    'If FunDim <> "" Then FunDim = Left(FunDim, Len(FunDim)-2)                '������̫����
    getASPDimFunction = funValue 
    if err then call doError(err.description, "GetASPFunctionList ���ASP�����б� ����������") 
end function 
'Response.Write(StrLength("�й�121aa"))
'�������ʽ����ַ����� ���Ķ����ַ�
function strLength(str)
    dim rep, lens, i 
    lens = 0 
    set rep = createObject("VBscript.RegExp")
        rep.global = true 
        rep.ignoreCase = true 
        rep.pattern = "[\u4E00-\u9FA5\uF900-\uFA2D]" 
        for each i in rep.execute(str)
            lens = lens + 1 
        next 
    set rep = nothing 
    lens = lens + len(str) 
    strLength = lens 
end function 
'�������ʽ����ַ����� ���Ķ����ַ�
function regExpGetLenght(str)
    regExpGetLenght = strLength(str) 
end function 
'�������ʽ����ַ����� ���Ķ����ַ�
function stringLength(str)
    stringLength = strLength(str) 
end function 
'���HTML��Css
function getCssHref(byVal content)
    on error resume next 
    dim setExecute, setValue, rep, imgType, s, c 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<link .*?href *= *[""|'| ]*([^""'>]+)" 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                if inStr(LCase(setValue), "stylesheet") > 0 then
                    s = setValue.subMatches(0) 
                    c = c & s & vbCrLf 
                end if 
            next 
        set setExecute = nothing 
    set rep = nothing 
    if c <> "" then c = left(c, len(c) - 2) 
    getCssHref = c 
    if err then call doError(err.description, "GetCssHref ���HTML��Css ����������C =" & c) 
end function 
'���HTML��Js
function getJsSrc(byVal content)
    on error resume next 
    dim setExecute, setValue, rep, imgType, s, c 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<script .*?src *= *[""|'| ]*([^""'>]+)" 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                s = setValue.subMatches(0) 
                c = c & s & vbCrLf 
            next 
        set setExecute = nothing 
    set rep = nothing 
    if c <> "" then c = left(c, len(c) - 2) 
    getJsSrc = c 
    if err then call doError(err.description, "GetJsSrc ���HTML��Js ����������C =" & c) 
end function 
'ɾ��HTML��<scirpt
function delHTMLScript(byVal strHtml)
    on error resume next 
    dim rep, strOutput 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<script.*</"&"script>" 
        strOutput = rep.replace(strHtml, "") 
        delHTMLScript = strOutput 
    set rep = nothing 
    if err then call doError(err.description, "ɾ��HTML��<scirpt ����������") 
end function 
'���HTML��keywords
function getMeta(byVal content, sType, nOK)
    on error resume next 
    dim setExecute, setValue, rep, imgType, s, c 
    c = "" 
    sType = LCase(sType) 
    nOK = 0 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<meta .*?content *= *[""|'| ]*([^""'>]+)" 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                if inStr(LCase(setValue), sType) > 0 then
                    s = setValue.subMatches(0) 
                    c = c & s & vbCrLf 
                    nOK = nOK + 1 
                end if 
            next 
        set setExecute = nothing 
    set rep = nothing 
    if c <> "" then c = left(c, len(c) - 2) 
    getMeta = c 
    if err then call doError(err.description, "GetKeyWords ���HTML��keywords ����������C =" & c) 
end function 
'ȥ��HTMLע��
function delHtmlNote(contentStr)
    dim clsTempLoseStr, regex 
    clsTempLoseStr = CStr(contentStr) 
    set regex = createObject("VBscript.RegExp")
        regex.pattern = "<!--\/*[^<>]*-->" 
        regex.ignoreCase = true 
        regex.global = true 
        clsTempLoseStr = regex.replace(clsTempLoseStr, "") 
        delHtmlNote = clsTempLoseStr 
    set regex = nothing 
end function 
'ɾ���Լ������HTMLע��
function delHtmlMyNote(contentStr)
    dim clsTempLoseStr, regex 
    clsTempLoseStr = CStr(contentStr) 
    set regex = createObject("VBscript.RegExp")
        regex.pattern = "<!--#\/*[^<>]*#-->" 
        regex.ignoreCase = true 
        regex.global = true 
        clsTempLoseStr = regex.replace(clsTempLoseStr, "") 
        delHtmlMyNote = clsTempLoseStr 
    set regex = nothing 
end function 
'���������ͼƬ�б�
function getStrImgList(byVal content)
    content = replace(content, "'", """") 
    dim result, result1, m, n, regex 
    result = "" : result1 = "" 
    set regex = createObject("VBscript.RegExp")
        'Set regEx = CreateObject("VBscript.RegExp")
        regex.ignoreCase = true 
        regex.global = true 
        regex.pattern = "<img [^>]*src=""([^"">]+)[^>]+>" 
        set m = regex.execute(content)
            for each n in m
                result = result & n & "|" 
                result1 = result1 & n.subMatches(0) & "|" 
            next 
        set m = nothing 
    set regex = nothing 
    if result <> "" then
        result = left(result, len(result) - 1) 
        result1 = left(result1, len(result1) - 1) 
    end if 
    'result=split(result,"|") '�洢<img>
    'result1=split(result1,"|") '�洢ͼ���ַ
    getStrImgList = result1 
end function 
'��������б�
function getEMailList(content)                                          'patrn:��Ҫ���ҵ��ַ� strng:�����ҵ��ַ���
    dim regex, match, matches, retStr                                               '����������
    set regex = createObject("VBscript.RegExp")                                     '�����������ʽ��
        regex.pattern = "\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"    '����ģʽ��"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
        regex.ignoreCase = true                                                         '�����Ƿ����ִ�Сд��
        regex.global = true                                                             '����ȫ��ƥ�䡣
        retStr = "" 
        set matches = regex.execute(content)                                            'ִ��������
            for each match in matches                                      'ѭ������Matches���ϡ�
                if inStr("," & retStr & ",", "," & match.value & ",") = 0 then
                    retStr = retStr & match.value & "," 
                end if 
            next 
        set matches = nothing 
    set regex = nothing 
    if retStr <> "" then retStr = left(retStr, len(retStr) - 1) 
    getEMailList = retStr 
end function 
'��html���ݴ�����ı�ǩ��дת����Сд
function oflink_lcasetag(content)
    dim regex, match, matches                                                       '����������
    set regex = createObject("VBscript.RegExp")                                     '�����������ʽ��
        regex.pattern = "<.+?\>"                                                     '����ģʽ��
        regex.ignoreCase = true                                                         '�����Ƿ������ַ���Сд��
        regex.global = true                                                             '����ȫ�ֿ����ԡ�
        set matches = regex.execute(content)                                            'ִ��������
            content = content 
            for each match in matches                                      '����ƥ�伯�ϡ�
                content = replace(content, match.value, LCase(match.value)) 
            next 
            oflink_lcasetag = content 
        set matches = nothing 
    set regex = nothing 
end function 
'==================================================
'��������ScriptHtml
'��  �ã�����html���
'��  ����ConStr ------ Ҫ���˵��ַ���   1Ϊɾ����ʼ���  3Ϊɾ��ǰ������� 2Ϊ������Ч��
'==================================================
function scriptHtml(byVal conStr, tagName, FType)
    dim re 
    set re = createObject("VBscript.RegExp")
        re.ignoreCase = true 
        re.global = true 
        select case FType
            case 1
                re.pattern = "<" & tagName & "([^>])*>" 
                conStr = re.replace(conStr, "") 
            case 2
                re.pattern = "<" & tagName & "([^>])*>.*?</" & tagName & "([^>])*>" 
                conStr = re.replace(conStr, "") 
            case 3
                re.pattern = "<" & tagName & "([^>])*>" 
                conStr = re.replace(conStr, "") 
                re.pattern = "</" & tagName & "([^>])*>" 
                conStr = re.replace(conStr, "") 
        end select
        scriptHtml = conStr 
    set re = nothing 
end function 


'��ȡ���ݣ���ָ��3��ƥ����� [$Array$]Ϊ�� [$Split$]Ϊ��    2014 12 10
'����һ
'Content = " tablename='ListMenu' bigclassname='ϵͳ����' smallclassname='Robots�����޸�' sort='3' url='Robots.Asp' display='1' "
'Call Rw(GetRegExp(" (.*?)\=.*?'(.*?)'", Content, 0,1,""))'
function getRegExp(patrn, strng, nSplit1, nSplit2, nSplit3)
    dim regex, match, matches, c, splitYes, s 
    c = "" 
    if nSplit1 <> "" then nSplit1 = CInt(nSplit1)                                   '��ǰ�ָ���
    if nSplit2 <> "" then nSplit2 = CInt(nSplit2)                                   '��ǰ�ָ���
    if nSplit3 <> "" then nSplit3 = CInt(nSplit3)                                   '��ǰ�ָ���
    splitYes = false                                                                '�ָ��Ƿ�Ϊ
    if nSplit1 <> "" or nSplit2 <> "" or nSplit3 <> "" then splitYes = true 
    set regex = createObject("VBscript.RegExp")                                     '�����������ʽ��
        regex.pattern = patrn                                                           '����ģʽ��
        regex.ignoreCase = true                                                         '�����Ƿ������ַ���Сд��
        regex.global = true                                                             '����ȫ�ֿ����ԡ�
        set matches = regex.execute(strng)                                              'ִ��������
            for each match in matches                                      '����ƥ�伯�ϡ�
                if splitYes = true then
                    s = "" 
                    if nSplit1 <> "" then
                        s = s & match.subMatches(nSplit1) 
                    end if 
                    if nSplit2 <> "" then
                        if s <> "" then s = s & "[$Split$]" 
                        s = s & match.subMatches(nSplit2) 
                    end if 
                    if nSplit3 <> "" then
                        if s <> "" then s = s & "[$Split$]" 
                        s = s & match.subMatches(nSplit3) 
                    end if 
                    if s <> "" then c = c & s & "[$Array$]" 
                else
                    c = c & match & "[$Array$]" 
                end if 
            next 
            if c <> "" then c = left(c, len(c) - 9) 
            getRegExp = c 
end function



'���������Img��Js������  SType=1Ϊ���ظ�   20150126
function getImgJsUrl(content, sType)
    dim s, c, splStr, url, urlList 
    sType = LCase(sType)                                                            '����ת��Сд�������ַ�����
    c = regExpGetStr("<[img|script][^<>]*src[^<>]*[\/]?>", content, 2) 
    splStr = split(c, "[$Array$]") 
    urlList = "" 
    for each s in splStr
        url = regExpGetStr("src=[""|']?([^""' ]*)([""|']?).*[\/]?>", s, 1) 
        if sType = "1" or sType = "���ظ�" then
            if inStr(vbCrLf & urlList & vbCrLf, vbCrLf & url & vbCrLf) then
                url = "" 
            end if 
        end if 
        if url <> "" then
            urlList = urlList & url & vbCrLf 
        end if 
    next 
    if urlList <> "" then urlList = left(urlList, len(urlList) - 2) 
    getImgJsUrl = urlList 
end function 
'�������ʽ����20150126
'��ȡ��վ�б��⡢�ؼ��ʡ�����
'WebTitle = RegExpGetStr("<TITLE>(.*)</TITLE>", Content, 1)                    '��һ��
'WebTitle = RegExpGetStr("<TITLE>([^<>]*)</TITLE>", Content, 1)                    '�ڶ��� ����
'WebDes = RegExpGetStr("<meta[^<>]*description[^<>]*[\/]?>", Content, 0)
'WebDes = RegExpGetStr("content=[""|']?([^""' ]*)([""|']?).*[\/]?>", WebDes, 1)
'WebKey = RegExpGetStr("<meta[^<>]*keywords[^<>]*[\/]?>", Content, 0)
'WebKey = RegExpGetStr("content=[""|']?([^""' ]*)([""|']?).*[\/]?>", WebKey, 1)
function regExpGetStr(patternStr, content, sType)
    dim re, remoteFileurl, remoteFile, c 
    sType = cstr(sType) 
    set re = createObject("VBscript.RegExp")
        re.ignoreCase = true 
        re.global = true 
        re.pattern = patternStr 
        set remoteFile = re.execute(content)
            for each remoteFileurl in remoteFile
                if sType = "1" then
                    remoteFileurl = re.replace(remoteFileurl, "$1") 
                elseIf sType = "2" then
                    c = c & remoteFileurl & "[$Array$]" 
                end if 
                regExpGetStr = remoteFileurl 
            next 
        set remoteFile = nothing 
    set re = nothing 
    if sType = "2" then
        if c <> "" then c = left(c, len(c) - 9) 
        regExpGetStr = c 
    end if 
end function 

'���IP��ַ
function newGetPingIP(httpurl)
    dim cmdPath, content, splStr 
    dim remoteUrl, url, startStr, endStr 
    newGetPingIP = "" 
    cmdPath = "/����/cmd.exe" 
    'HttpUrl="www.intcochina.com.cn"
    content = getPingInfo(cmdPath, httpurl) 
    splStr = split(content, "Request timed out.") 
    'Call Rw(Content & "," & Ubound(SplStr))
    if uBound(splStr) >= 4 then
        url = trim(replace(replace(replace(httpurl, "http://", ""), "www.", ""), "/", "")) 
        remoteUrl = "http://whois.www.net.cn/whois/api_webinfo?host=" & url & "&_=" & getRnd(9) 
        content = getHttpPage(remoteUrl, "utf-8") 
        startStr = """ip"":""" : endStr = """" 
        if inStr(content, startStr) > 0 and inStr(content, endStr) > 0 then
            newGetPingIP = strCut(content, startStr, endStr, 2) 
        end if 
    else
        startStr = " [" : endStr = "]" 
        if inStr(content, startStr) > 0 and inStr(content, endStr) > 0 then
            newGetPingIP = strCut(content, startStr, endStr, 2) 
        else
            newGetPingIP = "NO" 
        'Call Eerr("S",S)
        end if 
    end if 
end function 
'��Cmd��Ping�����ַIP �÷���Response.Write(GetPingIP("/cmd.exe", "www.shuyate.cn"))
function getPingIP(cmdPath, httpurl)
    dim s, startStr, endStr 
    'StartStr = HttpUrl & " [" : EndStr="]"
    startStr = " [" : endStr = "]" 
    s = getPingInfo(cmdPath, httpurl) 
    if inStr(s, startStr) > 0 and inStr(s, endStr) > 0 then
        getPingIP = strCut(s, startStr, endStr, 2) 
    else
        getPingIP = "NO" 
    'Call Eerr("S",S)
    end if 
end function 
'���ping��Ϣ  getPingInfo("C:\Windows\winsxs\wow64_microsoft-windows-commandprompt_31bf3856ad364e35_6.1.7601.17514_none_f387767e655cd5ab\cmd.exe", " 10.10.10.2")
function getPingInfo(cmdPath, httpurl)
    dim wS, dD 
    set wS = createObject("WScript.Shell")
        call handlePath(cmdPath)                                                        '�������·��
        set dD = wS.exec(cmdPath & " /c ping " & httpurl)
            getPingInfo = dD.stdout.readall 
end function
'��ʾ����� ����
function regExpTest(str, s_Pattern)
    dim re 
    set re = createObject("VBscript.RegExp")
        re.ignoreCase = true 
        re.global = true 
        re.pattern = s_Pattern 
        regExpTest = re.test(str) 
    set re = nothing 
end function 

'�������ʽ������� ��aspתphp����
function getRegExpStr(byVal content, byVal patternStr, byVal replaceStr)
    on error resume next 
    dim s, c, setExecute, setValue, rep, sNew 
    c = "" 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = patternStr 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                sNew = replace(replaceStr, "\S1\", setValue.subMatches(0)) 
                sNew = replace(sNew, "\S2\", setValue.subMatches(1)) 
                sNew = replace(sNew, "\S3\", setValue.subMatches(2)) 
                sNew = replace(sNew, "\S4\", setValue.subMatches(3)) 
                sNew = replace(sNew, "\S5\", setValue.subMatches(4)) 
                content = replace(content, setValue, sNew) 
            next 
        set setExecute = nothing 
    set rep = nothing 
    getRegExpStr = content 
end function 



'�滻CSSĿ¼ ��20150814��  call rwend(regExpReplaceCssDir("<link rel=""stylesheet"" href=""Images/jquery.mobile-1.4.5.min.css"">", "css/"))
function regExpReplaceCssDir(byVal content, addToDir)
    dim setExecute, setValue, rep, replaceStr 
    dim filePath, fileName 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<link .*?href *= *[""|'| ]*([^""'>]+)" 
        set setExecute = rep.execute(content)
            for each setValue in setExecute
                if inStr(LCase(setValue), "stylesheet") > 0 then
                    filePath = setValue.subMatches(0) 
                    fileName = getStrFileName(filePath) 
                    replaceStr = replace(setValue, filePath, addToDir & fileName) 
                    content = replace(content, setValue, replaceStr) 
                end if 
            next 
        set setExecute = nothing 
    set rep = nothing 
    regExpReplaceCssDir = content 
end function 


'ɾ������
function deleteNullRow(byVal content)
    deleteNullRow = regExp_Replace(content, "\r\n\s*\r\n", "")                      'ɾ������
end function 

'�����Ӽ�Ĭ������ 20160405  ������
function nullLinkAddDefaultName(content)
    dim rep 
    set rep = createObject("VBscript.RegExp")
        rep.ignoreCase = true 
        rep.global = true 
        rep.pattern = "<a [^>]*href *= *[""'][""'][^>]*>" 
        content = rep.replace(content, "<a href='index.html'>") 
    set rep = nothing 
    nullLinkAddDefaultName = content 
end function 
%>   