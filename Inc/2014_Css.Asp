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
'Css

'��ɾ��.netc start��

'Cssѹ�� cssCompression(Content,0)
function cssCompression(content, level)
    level = cStr(level)                                                             'ת���ַ����ж�
    'Css�߼�ѹ��
    if level = "1" then
        content = regExp_Replace(content, "\/\*(.|" & vbCrLf & ")*?\*\/", "") 
        content = regExp_Replace(content, "\s*([\{\}\:\;\,])\s*", "$1") 
        content = regExp_Replace(content, "\,[\s\.\#\d]*\{", "{") 
        content = regExp_Replace(content, ";\s*;", ";") 
    'Css��ѹ��
    else
        if level >= 2 then
            content = regExp_Replace(content, "\/\*(.|" & vbCrLf & ")*?\*\/", "")           '//ɾ��ע��
        end if 
        content = regExp_Replace(content, "\s*([\{\}\:\;\,])\s*", "$1") 
        content = regExp_Replace(content, "\,[\s\.\#\d]*\{", "{")                  '//�ݴ�����
        content = regExp_Replace(content, ";\s*;", ";")                                 '//��������ֺ�
        content = regExp_Replace(content, ";\s*}", "}")                                 '//���ĩβ�ֺźʹ�����
        content = regExp_Replace(content, "([^\s])\{([^\s])", "$1{$2") 
        content = regExp_Replace(content, "([^\s])\}([^" & vbCrLf & "]s*)", "$1}" & vbCrLf & "$2") 

    end if 
    content = trimVBcrlf(content) 
    cssCompression = content 
end function 

'ɾ��Css��ע��
function deleteCssNote(content)
    deleteCssNote = regExp_Replace(content, "\/\*(.|" & vbCrLf & ")*?\*\/", "")     '//ɾ��ע��
end function 

'Css��ʽ��  չ��CSS
function unCssCompression(content)
    content = regExp_Replace(content, "\s*([\{\}\:\;\,])\s*", "$1") 
    content = regExp_Replace(content, ";\s*;", ";")                                 '//��������ֺ�
    content = regExp_Replace(content, "\,[\s\.\#\d]*{", "{") 
    content = regExp_Replace(content, "([^\s])\{([^\s])", "$1 {" & vbCrLf & "" & vbTab & "$2") 
    content = regExp_Replace(content, "([^\s])\}([^" & vbCrLf & "]*)", "$1" & vbCrLf & "}" & vbCrLf & "$2") 
    content = regExp_Replace(content, "([^\s]);([^\s\}])", "$1;" & vbCrLf & "" & vbTab & "$2") 
    unCssCompression = content 
end function 

'��ɾ��.netc end��

'ȥ���ַ���ͷβ�������Ļس��Ϳո�
function trimVbCrlf(str)
    trimVbCrlf = phpRTrim(phpLTrim(str)) 
end function 

'php��Trim����
function phpTrim(str)
    phpTrim = trimVbCrlf(str) 
end function 

'ȥ���ַ�����ͷ�������Ļس��Ϳո�
function phpLTrim(str)
    dim nPos, isBlankChar 
    nPos = 1 
    isBlankChar = true 
    while isBlankChar
        if mid(str, nPos, 1) = " " or mid(str, nPos, 1) = vbTab then                      '��vbTabҲȥ��
            nPos = nPos + 1 
        elseIf mid(str, nPos, 2) = vbCrLf then
            nPos = nPos + 2 
        else
            isBlankChar = false 
        end if 
    wend 
    phpLTrim = right(str, len(str) - nPos + 1) 
end function 

'ȥ���ַ���ĩβ�������Ļس��Ϳո�
function phpRTrim(str)
    dim nPos, isBlankChar 
    nPos = len(str) 
    isBlankChar = true 
    while isBlankChar and nPos >= 2
        if mid(str, nPos, 1) = " " or mid(str, nPos, 1) = vbTab then                      '��vbTabҲȥ��
            nPos = nPos - 1 
        elseIf mid(str, nPos - 1, 2) = vbCrLf then
            nPos = nPos - 2 
        else
            isBlankChar = false 
        end if 
    wend 
    phpRTrim = rTrim(left(str, nPos)) 
end function 


'--------------- ���� ��ʱ�����ļ��� ------------------
'ȥ���ַ���ͷβ��������Tab�˸�Ϳո�
function trimVbTab(str)
    trimVbTab = rTrimVBTab(lTrimVbTab(str)) 
end function 


'ȥ���ַ�����ͷ��������Tab�˸�Ϳո�
function lTrimVbTab(str)
    dim nPos, isBlankChar 
    nPos = 1 
    isBlankChar = true 
    while isBlankChar
        if mid(str, nPos, 1) = " " then
            nPos = nPos + 1 
        elseIf mid(str, nPos, 1) = vbTab then
            nPos = nPos + 1 
        else
            isBlankChar = false 
        end if 
    wend 
    lTrimVbTab = right(str, len(str) - nPos + 1) 
end function 

'ȥ���ַ���ĩβ��������Tab�˸�Ϳո�
function rTrimVBTab(str)
    dim nPos, isBlankChar 
    nPos = len(str) 
    isBlankChar = true 
    while isBlankChar and nPos >= 2
        if mid(str, nPos, 1) = " " then
            nPos = nPos - 1 
        elseIf mid(str, nPos - 1, 1) = vbTab then
            nPos = nPos - 1 
        else
            isBlankChar = false 
        end if 
    wend 
    rTrimVBTab = rTrim(left(str, nPos)) 
end function 


'��Htmlҳ��Css Style <style></style> ��css����
function getHtmlCssStyle(byVal content)
    getHtmlCssStyle = handleHtmlStyleCss(content, "", "") 
end function 
'����html���css �滻·��
function handleHtmlStyleCss(content, sType, imgPath)
    dim splStr, s, isStyle, styleStartStr, styleEndStr, styleStr, cssStr, sNewCssStr 
    splStr = split(content, vbCrLf)                                                 '�ָ���
    isStyle = false                                                                'Css��ʽĬ��Ϊ��
	handleHtmlStyleCss=""
    'ѭ������
    for each s in splStr
        if isStyle = false then
            if inStr(lCase(s), "<style") > 0 then
                styleStartStr = mid(s, inStr(lCase(s), "<style")) 
                styleStartStr = mid(styleStartStr, 1, inStr(styleStartStr, ">")) 
                styleEndStr = mid(s, inStr(lCase(s), styleStartStr) + len(styleStartStr)) 
                'HTML�ж����Css��һ��
                if inStr(styleEndStr, "</style>") > 0 then
                    styleStr = mid(styleEndStr, 1, inStr(styleEndStr, "</style>") - 1) 
                    cssStr = cssStr & styleStr & vbCrLf 
                else
                    cssStr = cssStr & styleEndStr & vbCrLf 
                    isStyle = true                                                       '�ռ�CssStyle��ʽ��ʼ
                end if 
                'Call Echo("StyleStartStr",ShowHtml(StyleStartStr))
                'Call Echo("StyleEndStr",ShowHtml(StyleEndStr))
                'Call Echo("StyleStr",ShowHtml(StyleStr))
                'Call Echo("CssStr",ShowHtml(CssStr))
            'Call RwEnd("")
            end if 
        elseIf isStyle = true then
            if inStr(lCase(s), "</style>") > 0 then
                styleStr = mid(s, 1, inStr(lCase(s), "</style>") - 1) 
                cssStr = cssStr & styleStr & vbCrLf 

                if sType = "�滻·��" then
                    sNewCssStr = replaceCssImgPath(cssStr, imgPath) 
                    content = replace(content, phptrim(cssStr), sNewCssStr) 
                end if 

                isStyle = false                                                                '�ռ�CssStyle��ʽ����
            else
                cssStr = cssStr & s & vbCrLf 
            end if 
        end if 
    next 
    if sType = "�滻·��" then
        handleHtmlStyleCss = content 
    else
        handleHtmlStyleCss = cssStr 
    end if 
end function 

'�滻css������ͼƬ·�� 20160718home
function replaceCssImgPath(byval cssStr, byval imgPath)
    dim content, splStr, s, c, fileName, toImgPath, lCaseS 
    content = getArray(cssStr, "\(", "\)", false, false) 
    splStr = split(content, "$Array$") 
    for each s in splStr
        if s <> "" then
			'�ԵȺ�ǰ�治��������   filter:progid:DXImageTransform.Microsoft.AlphaImageLoader (enabled=true, sizingMethod=scale, src='../images/ad-gallery/opa75.png');}
			if instr(s,"=")>0 then
				s=mid(s,instrrev(s,"=")+1) 
			end if
            lCaseS = lcase(s) 
            fileName = trim(getFileAttr(s, "2")) 
			'call echo("css s",s)
			'call echo("css filename",fileName)
            '����ͼƬ �����жϷ������д��Ľ����Ľ�Ҳ�ǳɳ���һ����20160719
            if instr(lCaseS, "data:image") = 0 and(instr(lCaseS, ".jpg") > 0 or instr(lCaseS, ".gif") > 0 or instr(lCaseS, ".png") > 0 or instr(lCaseS, ".bmp") > 0) then
                '�޸���20160719
                if instr(""",", left(fileName, 1)) > 0 then
                    fileName = mid(fileName, 2) 
                end if 
                if instr(""",", right(fileName, 1)) > 0 then
                    fileName = mid(fileName, 1, len(fileName) - 1) 
                end if 
                'call echo(s,imgPath  & " and " & fileName)
                cssStr = replace(cssStr, "(" & s & ")", "(" & imgPath & fileName & ")") 
            'fileName="data:image/" & fileName
            end if 

        end if 
    next 
    replaceCssImgPath = cssStr 
end function 

'�����ɸɾ���Css����  CSS��ʽ��
function handleCleanCss(byVal content)
    dim splStr, s, c, isAddStr, customS 
    content = replace(content, "{", vbCrLf & "{" & vbCrLf) 
    content = replace(content, "}", vbCrLf & "}" & vbCrLf) 
    content = replace(content, ";", ";" & vbCrLf) 

    splStr = split(content, vbCrLf) 
    isAddStr = false                                                               '׷���ַ�Ĭ��Ϊ��
    for each s in splStr
        s = trimVbCrlf(s) 
        customS = ""                                                                    '�Զ���Sֵ
        if s <> "" then
            if inStr(s, "{") > 0 and inStr(s, "}") = 0 then
                isAddStr = true 
                customS = s 
            elseIf inStr(s, "}") > 0 then
                isAddStr = false 
            end if 
            if left(s, 1) <> "{" then c = c & vbCrLf 
            if isAddStr = true then s = "    " & s 
            if customS <> "" then s = customS                                               '�Զ���ֵ��Ϊ�������Զ�������
            c = c & s 

        end if 
    next 
    c = trimVbCrlf(c) 
    c = replace(c, "    ;" & vbCrLf, "")                                            '������ڵķֺ�
    c = replace(c, ";" & vbCrLf & "}", vbCrLf & "}")                                '���һ��������Ҫ�ֺ�
    handleCleanCss = c 
end function 



'�Ƴ������ж����
function removeExcessRow(content)
    dim splStr, s, c, tempS 
    splStr = split(content, vbCrLf)                                                 '�ָ���
    for each s in splStr
        tempS = replace(replace(s, " ", ""), vbTab, "") 
        if tempS <> "" then
            c = c & s & vbCrLf 
        end if 
    next 
    if c <> "" then c = left(c, len(c) - 2) 
    removeExcessRow = c 
end function 


'2014 11 30
'��Css��׷����ʽ  a=CssAddToStyle(GetFText("1.html")," .test {color:#FF0f000; font-size:10px; float:left}")
function cssAddToStyle(content, addToStyle)
    dim styleName, yunStyleStr, replaceStyleStr, c 
    if inStr(addToStyle, "{") > 0 then
        styleName = trim(mid(addToStyle, 1, inStr(addToStyle, "{") - 1)) 
    end if 
    yunStyleStr = findCssStyle(content, styleName) 
    replaceStyleStr = cssStyleAddToParam(yunStyleStr, addToStyle)                   'Css��ʽ�ۼӲ���
    content = replace(content, yunStyleStr, replaceStyleStr) 
    'C = C & "<hr>Content=" & Content
    cssAddToStyle = content 
    'CssAddToStyle = YunStyleStr
'CssAddToStyle = "StyleName=" & StyleName & "<hr>YunStyleStr=" & YunStyleStr & "<hr>ReplaceStyleStr=" & ReplaceStyleStr
end function 

'���Css�������Ƿ���ָ����ʽ
function checkCssStyle(content, styleStr)
    dim styleName 
    checkCssStyle = true 
    if inStr(styleStr, "{") > 0 then
        styleName = trim(mid(styleStr, 1, inStr(styleStr, "{") - 1)) 
    end if 
    if styleName = "" then
        checkCssStyle = false 
    elseIf findCssStyle(content, styleName) = "" then
        checkCssStyle = false 
    end if 
end function 


'Css��ʽ�ۼӲ���
function cssStyleAddToParam(byVal cssStyleStr, byVal cssStyleStrTwo)
    dim splStr, cssStr, s, paramList, paramName, cssStyleName 
    cssStyleName = mid(cssStyleStr, 1, inStr(cssStyleStr, "{")) 
    if inStr(cssStyleStr, "{") > 0 then
        cssStyleStr = mid(cssStyleStr, inStr(cssStyleStr, "{") + 1) 
    end if 
    if inStr(cssStyleStr, "}") > 0 then
        cssStyleStr = mid(cssStyleStr, 1, inStr(cssStyleStr, "}") - 1) 
    end if 
    if inStr(cssStyleStrTwo, "{") > 0 then
        cssStyleStrTwo = mid(cssStyleStrTwo, inStr(cssStyleStrTwo, "{") + 1) 
    end if 
    if inStr(cssStyleStrTwo, "}") > 0 then
        cssStyleStrTwo = mid(cssStyleStrTwo, 1, inStr(cssStyleStrTwo, "}") - 1) 
    end if 
    splStr = split(replace(cssStyleStr & ";" & cssStyleStrTwo, vbCrLf, ""), ";") 
    for each s in splStr
        s = trim(s) 
        if inStr(s, ":") > 0 and s <> "" then
            paramName = trim(mid(s, 1, inStr(s, ":") - 1)) 
            if inStr("|" & paramList & "|", "|" & paramName & "|") = 0 then
                paramList = paramList & paramName & "|" 
                'Call Echo("ParamName",ParamName)
                cssStr = cssStr & "    " & s & ";" & vbCrLf 
            end if 
        end if 
    next 
    if cssStyleName <> "" then
        cssStr = cssStyleName & vbCrLf & cssStr & "}" 
    end if 
    cssStyleAddToParam = cssStr 
'Call Echo(CssStyleStr,CssStyleStrTwo)
end function 

'����Css�����ҵ���ӦCss��
function findCssStyle(byVal content, byVal styleName)
    dim splStr, s, tempS, findStyleName 
    'CAll Echo("StyleName",StyleName)
    'CAll Echo("Content",Content)
	findCssStyle=""
    styleName = trim(styleName) 
    splStr = split(content, vbCrLf) 
    for each s in splStr
        if inStr(s, styleName) > 0 then
            findStyleName = trim(s) 
            if inStr(findStyleName, "{") > 0 then
                findStyleName = trim(mid(findStyleName, 1, inStr(findStyleName, "{") - 1)) 
            end if 
            if findStyleName = styleName then
                'Call Eerr( FindStyleName , StyleName)
                if inStr(s, "}") > 0 then
                    findCssStyle = mid(s, 1, inStr(s, "}") + 1) 
                    'Call EErr(s,FindCssStyle)
                    exit function 
                else
                    tempS = mid(content, inStr(content, s & vbCrLf) + 1) 
                    tempS = mid(tempS, 1, inStr(tempS, "}") + 1) 
                    findCssStyle = tempS 
                    exit function 
                end if 
            'Call Eerr("temps",Temps)
            end if 
        'Call Echo(FindStyleName,StyleName)
        end if 
    next 
end function 

'================================================
'������վǰ��Ҫ�õ�
'================================================
'������ȡ����Css
function handleCutCssCode(dirPath, cssStr)
    dim content, startStr, endStr, splStr, imageFile, fileName, listStr 
    startStr = "url\(" : endStr = "\)" 
    content = getArray(cssStr, startStr, endStr, false, false) 
    splStr = split(content, "$Array$") 
    for each imageFile in splStr
        if imageFile <> "" and inStr(imageFile, ".") > 0 and inStr(vbCrLf & listStr & vbCrLf, vbCrLf & imageFile & vbCrLf) = 0 then'���ظ�ʹ�õ�ͼƬ����
            listStr = listStr & imageFile & vbCrLf 
            fileName = replace(replace(replace(imageFile, """", ""), "'", ""), "\", "/") 
            if inStr(fileName, "/") > 0 then
                fileName = mid(fileName, inStrRev(fileName, "/") + 1) 
            end if 
            cssStr = replace(cssStr, imageFile, dirPath & fileName) 
        end if 
    next 
    handleCutCssCode = cssStr 
end function 

'������ȡ����HtmlDiv
function handleCutDivCode(dirPath, divStr)
    dim content, startStr, endStr, splStr, imageFile, toImageFile, fileName, isHandle 
    startStr = "url\(" : endStr = "\)" 
    content = getArray(divStr, startStr, endStr, false, false) 
    splStr = split(content, "$Array$") 
    for each imageFile in splStr

        if imageFile <> "" and inStr(imageFile, ".") > 0 and inStr(imageFile, "{$#") = 0 then
            '�ж��Ƿ������� 20150202
            if getWebSite(imageFile) = "" then
                fileName = replace(replace(replace(imageFile, """", ""), "'", ""), "\", "/") 
                if inStr(fileName, "/") > 0 then
                    fileName = mid(fileName, inStrRev(fileName, "/") + 1) 
                end if 
                divStr = replace(divStr, imageFile, dirPath & imageFile) 
            end if 
        end if 
    next 
    'ͼƬ����
    'Content = GetIMG(DivStr) & vbCrlf & GetHtmlBackGroundImgList(DivStr)        '�ټӸ�Html����ͼƬ
    content = getImgJsUrl(divStr, "���ظ�") & vbCrLf & getHtmlBackGroundImgList(divStr) '�ټӸ�Html����ͼƬ  ��ǿ��20150126
    splStr = split(content, vbCrLf) 
    for each imageFile in splStr
        if imageFile <> "" then                                                         '�����ӵ�ַ��ǰΪHTTP:ʱ�򲻴���20150313
            isHandle = false 

            if left(imageFile, 1) = "\" then
            '�ȴ���20150817
            elseIf inStr(imageFile, ".") > 0 and left(imageFile, 5) <> "HTTP:" and inStr(imageFile, "{$#") = 0 then
                isHandle = true 
            end if 
            if isHandle = true then
                toImageFile = dirPath & removeFileDir(imageFile)                                '�Ƴ��ļ�·��Ŀ¼
                'html��ͼƬ·���滻
                divStr = replace(divStr, """" & imageFile & """", """" & toImageFile & """") 
                divStr = replace(divStr, "'" & imageFile & "'", """" & toImageFile & """") 
                divStr = replace(divStr, "=" & imageFile & " ", """" & toImageFile & """") 
                divStr = replace(divStr, "=" & imageFile & ">", """" & toImageFile & """") 
            end if 
        end if 
    next 
    handleCutDivCode = divStr 
end function 

'���HTMl�ﱳ��ͼƬ 20150116  �磺 <td width="980" height="169" background="kslx3bg.jpg">
function getHtmlBackGroundImgList(byVal content)
    content = getArray(content, " background=""", """", false, false) 
    content = replace(content, "$Array$", vbCrLf) 
    getHtmlBackGroundImgList = content 
end function 


'����html��link css���� Content = getHandleWebHtmlLink("/aa/bb/",Content)  �ⲿ����
function getHandleWebHtmlLink(rootPath, content)
    dim startStr, endStr, imgList, splStr, c, cssUrl, sNewCssUrl, cssStr 
    startStr = "<link " 
    cssStr = "" 
    endStr = ">" 
    imgList = getArray(content, startStr, endStr, false, false) 
    'Call RwEnd(ImgList)
    splStr = split(imgList, "$Array$") 
    for each cssUrl in splStr
        if cssUrl <> "" and inStr(lCase(cssUrl), "stylesheet") > 0 then
            '���Css��ǿ�棬����20141125
            cssUrl = lCase(replace(replace(replace(cssUrl, """", ""), "'", ""), ">", " ")) & " " 
            startStr = "href=" : endStr = " " 
            if inStr(cssUrl, startStr) > 0 and inStr(cssUrl, endStr) > 0 then
                cssUrl = strCut(cssUrl, startStr, endStr, 2) 
            end if 
            sNewCssUrl = handleHttpUrl(cssUrl) 
            if inStr(sNewCssUrl, "/") > 0 then
                sNewCssUrl = mid(sNewCssUrl, inStrRev(sNewCssUrl, "/") + 1) 
            end if 
            if lCase(sNewCssUrl) <> "common.css" and lCase(sNewCssUrl) <> "public.css" then
                sNewCssUrl = rootPath & sNewCssUrl 
                cssStr = cssStr & "<link href=""" & sNewCssUrl & """ rel=""stylesheet"" type=""text/css"" />" & vbCrLf 
            end if 
        end if 
    next 
    if cssStr <> "" then cssStr = left(cssStr, len(cssStr) - 2) 
    getHandleWebHtmlLink = cssStr 
end function 


'���css���ӵ�ַ�б�(20150824)  ��<link>
function getCssListUrlList(content)
    dim startStr, endStr, imgList, splStr, c, cssUrl, cssStr, urlList 
    startStr = "<link " 
    cssStr = "" 
    endStr = ">" 
    imgList = getArray(content, startStr, endStr, false, false) 
    'Call RwEnd(ImgList)
    splStr = split(imgList, "$Array$") 
    for each cssUrl in splStr
        if cssUrl <> "" and inStr(lCase(cssUrl), "stylesheet") > 0 then
            '���Css��ǿ�棬����20141125
            cssUrl = lCase(replace(replace(replace(cssUrl, """", ""), "'", ""), ">", " ")) & " " 
            startStr = "href=" : endStr = " " 
            if inStr(cssUrl, startStr) > 0 and inStr(cssUrl, endStr) > 0 then
                cssUrl = strCut(cssUrl, startStr, endStr, 2) 
            end if 
            if inStr(vbCrLf & urlList & vbCrLf, vbCrLf & cssUrl & vbCrLf) = 0 then
                if urlList <> "" then urlList = urlList & vbCrLf 
                urlList = urlList & cssUrl & vbCrLf 
            end if 
        end if 
    next 
    getCssListUrlList = urlList 
end function 
'call rw(handleHtmlStyle(getftext("1.html")))
'ѹ��html���style��ʽ (20151008)
function handleHtmlStyle(content)
    dim serchS, replaceS, nLength 
    serchS = content 
    nLength = inStr(lCase(serchS), "</style>") + 7 
    serchS = mid(serchS, 1, nLength) 

    nLength = inStrRev(lCase(serchS), "<style") 
    if nLength > 0 then
        serchS = mid(serchS, nLength) 
    end if 
    replaceS = serchS 
    replaceS = cssCompression(replaceS, 0) & vbCrLf                                 '��ʽ��CSS
    replaceS = removeBlankLines(replaceS) 

    content = replace(content, serchS, replaceS) 
    handleHtmlStyle = content 
end function 



'��Css�ļ����ݲ�����(20150824) �������¼��ǩ   ������
'��call rwend(handleReadCssContent("E:\E��\WEB��վ\��ǰ��վ\DataDir\VBģ��\������\Template\ģ�鹦���б�\Bվҳ�����\home\home.css","aa",true))
function handleReadCssContent(cssFilePath, labelName, isHandleCss)
    dim c, startStr, endStr 
    c = getFText(cssFilePath) 
    '��ȡCSS
    startStr = "/*CssCodeStart*/" 
    endStr = "/*CssCodeEnd*/" 
    if inStr(c, startStr) > 0 and inStr(c, endStr) > 0 then
        c = strCut(c, startStr, endStr, 2) 
    end if 
    '����CSS
    if isHandleCss = true then
        c = cssCompression(c, 0) 
    end if 
    if labelName <> "" then
        c = "/*" & labelName & " start*/" & c & "/*" & labelName & " end*/" 
    end if 
    handleReadCssContent = c 
end function 

'����Css��ʽ��PX��%
function handleCssPX(byVal sValue)
    sValue = lCase(trim(sValue)) 
    if right(sValue, 1) <> "%" and right(sValue, 2) <> "px" then
        sValue = sValue & "px" 
    end if 
    handleCssPX = sValue 
end function 

%>   