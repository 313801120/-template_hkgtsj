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
'��̬����̬(2013,12,17)

'================ ���ٻ����վ���� ==================
'�����޸� �޸ĵ��ı�
'MainStr = DisplayOnlineED2(WEB_ADMINURL &"MainInfo.Asp?act=ShowEdit&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainStr, "<li|<a ")
'�����޸� ��Ʒ����
'DidStr = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditBigClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), DidStr, "<li|<a ")
'�����޸� ��ƷС��
'SidStr = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), SidStr, "<li|<a ")
'�����޸� ��Ʒ����
'S = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), S, "<li|<a ")
'�����޸�  ����
'ProStr = DisplayOnlineED2(WEB_ADMINURL &"Product.Asp?act=ShowEditProduct&Id=" & TempRs("Id") & "&n=" & GetRnd(11), ProStr, "<li|<a ")
'�����޸� ��������
'NavDidStr = DisplayOnlineED2(WEB_ADMINURL &"NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), NavDidStr, "<li|<a ")
'�����޸� ����С��
'NavSidStr = DisplayOnlineED2(WEB_ADMINURL &"NavManage.Asp?act=EditNavSmall&Id=" & TempRs("Id") & "&n=" & GetRnd(11), NavSidStr, "<li|<a ")

'-------------------------------- ����Ϊ��վ��̨���ÿ�ݱ�ǩ������ -------------------------------------------

'����������ɫ
function infoColor(str, color)
    if color <> "" then str = "<font color=" & color & ">" & str & "</font>" 
    infoColor = str 
end function 
'ͼƬ����ʧ����ʾĬ��ͼƬ
function imgError()
    imgError = " onerror=""this.src='/UploadFiles/NoImg.jpg'""" 
end function 
'���target��ʽ
function handleTargetStr(byVal sType)
	handleTargetStr=""
    if sType <> "" then
        handleTargetStr = " target='" & sType & "'" 
    end if 
end function 
'�򿪷�ʽ  (����)
function aTarget(sType)
    aTarget = handleTargetStr(sType) 
end function 
'�������Title��ʽ
function aTitle(byVal title)
	aTitle=""
    if title <> "" then
        aTitle = " Title='" & title & "'" 
    end if 
end function 
'�������Title
function imgAlt(byVal alt)
	imgAlt=""
    if alt <> "" then
        imgAlt = " alt='" & alt & "'" 
    end if 
end function 
'ͼƬ������Alt
function imgTitleAlt(byVal str)
	imgTitleAlt=""
    if str <> "" then
        imgTitleAlt = " alt='" & str & "' title='" & str & "'" 
    end if 
end function 
'���A Relֵ
function aRel(byVal isType)
	aRel=""
    if isType = true then
        aRel = " rel='nofollow'" 
    end if 
end function 
'���target��ʽ
function styleClass(byVal className)
	styleClass=""
    if className <> "" then
        styleClass = " class='" & className & "'" 
    end if 
end function 
'�ı��Ӵ�
function textFontB(byVal text, isFontB)
    if isFontB = true then
        text = "<strong>" & text & "</strong>" 
    end if 
    textFontB = text 
end function 
'�ı�����ɫ
function textFontColor(byVal text, color)
    if color <> "" then
        text = "<font color='" & color & "'>" & text & "</font>" 
    end if 
    textFontColor = text 
end function 
'�����ı���ɫ��Ӵ�
function fontColorFontB(title, isFontB, fontColor)
    fontColorFontB = textFontColor(textFontB(title, isFontB), fontColor) 
end function 
'���Ĭ��������Ϣ�ļ�����
function getDefaultFileName()
    getDefaultFileName = format_Time(now(), 6) 
end function 
'�������  ����'"<a " & AHref(Url, TempRs("BigClassName"), TempRs("Target")) & ">" & TempRs("BigClassName") & "</a>"
function aHref(url, title, target)
    url = handleHttpUrl(url)                                                        '����һ��URL ��֮����
    aHref = "href='" & url & "'" & aTitle(title) & aTarget(target) 
end function 
'���ͼƬ·��
function imgSrc(url, title, target)
    url = handleHttpUrl(url)                                                        '����һ��URL ��֮����
    imgSrc = "src='" & url & "'" & aTitle(title) & imgAlt(title) & aTarget(target) 
end function 

'============== ��վ��̨ʹ�� ==================

'ѡ��Target�򿪷�ʽ
function selectTarget(target)
    dim c, sel 
    c = c & "<select name=""Target"" id=""Target"">" & vbCrLf 
    c = c & "  <option value=''>���Ӵ򿪷�ʽ</option>" & vbCrLf 
    if target = "" then sel = " selected" else sel = "" 
    c = c & "  <option" & sel & " value=''>��ҳ��</option>" & vbCrLf 
    if target = "_blank" then sel = " selected" else sel = "" 
    c = c & "  <option value=""_blank""" & sel & ">��ҳ��</option>" & vbCrLf 
    if target = "Index" then sel = " selected" else sel = "" 
    c = c & "  <option value=""Index""" & sel & ">Indexҳ��</option>" & vbCrLf 
    if target = "Main" then sel = " selected" else sel = "" 
    c = c & "  <option value=""Main""" & sel & ">Mainҳ��</option>" & vbCrLf 
    c = c & "</select>" & vbCrLf 
    selectTarget = c  
end function 
'ѡ���ı���ɫ
function selectFontColor(fontColor)
    dim c, sel 
    c = c & "  <select name=""FontColor"" id=""FontColor"">" & vbCrLf 
    c = c & "    <option value=''>�ı���ɫ</option>" & vbCrLf 
    if fontColor = "Red" then sel = " selected" else sel = "" 
    c = c & "    <option value=""Red"" class=""FontColor_Red""" & sel & ">��ɫ</option>" & vbCrLf 
    if fontColor = "Blue" then sel = " selected" else sel = "" 
    c = c & "    <option value=""Blue"" class=""FontColor_Blue""" & sel & ">��ɫ</option>" & vbCrLf 
    if fontColor = "Green" then sel = " selected" else sel = "" 
    c = c & "    <option value=""Green"" class=""FontColor_Green""" & sel & ">��ɫ</option>" & vbCrLf 
    if fontColor = "Black" then sel = " selected" else sel = "" 
    c = c & "    <option value=""Black"" class=""FontColor_Black""" & sel & ">��ɫ</option>" & vbCrLf 
    if fontColor = "White" then sel = " selected" else sel = "" 
    c = c & "    <option value=""White"" class=""FontColor_White""" & sel & ">��ɫ</option>" & vbCrLf 
    c = c & "  </select>" & vbCrLf 
    selectFontColor = c 
end function 
'ѡ����Ů
function selectSex(sex)
    dim c, sel 
    c = c & "  <select name=""FontColor"" id=""FontColor"">" & vbCrLf 
    c = c & "    <option value=""��"">��</option>" & vbCrLf 
    sel = IIf(sex = "Ů", " selected", "") 
    c = c & "    <option value=""Ů""" & sel & ">Ů</option>" & vbCrLf 
    c = c & "  </select>" & vbCrLf 
    selectSex = c 
end function 
'ѡ��Session��Cookies��֤
function selectSessionCookies(verificationMode)
    dim c, sel 
    c = c & "  <select name=""VerificationMode"" id=""VerificationMode"">" & vbCrLf 
    c = c & "    <option value=""1"">Session��֤</option>" & vbCrLf 
    sel = IIf(verificationMode = "0", " selected", "") 
    c = c & "    <option value=""0""" & sel & ">Cookies��֤</option>" & vbCrLf 
    c = c & "  </select>" & vbCrLf 
    selectSessionCookies = c 
end function 
'��ʾѡ��ָ�����  showSelectList("aa","aa|bb|cc","|","bb")
function showSelectList(IDName, content, sSplType, thisValue)
    dim c, sel, splStr, s 
    IDName = trim(IDName) 
    if sSplType = "" then sSplType = "|_-|" 
    if IDName <> "" then c = c & "  <select name=""" & IDName & """ id=""" & IDName & """>" & vbCrLf 

    splStr = split(content, sSplType) 
    for each s in splStr
        sel = "" 
        if s = thisValue then sel = " selected" 
        c = c & "    <option value=""" & s & """" & sel & ">" & s & "</option>" & vbCrLf 
    next 
    if IDName <> "" then c = c & "  </select>" & vbCrLf 
    showSelectList = c 
end function 

'��ʾ����չʾ�б���ʽ 20150114   �� Call Rw(ShowArticleListStyle("�����б���.html"))
function showArticleListStyle(byVal thisValue)
    showArticleListStyle = handleArticleListStyleOrInfoStyle("����չʾ��ʽ", "ArticleListStyle", thisValue) 
end function 
'��ʾ������Ϣչʾ��ʽ 20150114   �� Call Rw(ShowArticleInfoStyle("�����б���.html"))
function showArticleInfoStyle(byVal thisValue)
    showArticleInfoStyle = handleArticleListStyleOrInfoStyle("������Ϣչʾ��ʽ", "ArticleInfoStyle", thisValue) 
end function 
'��������չʾ�б���ʽ��������Ϣ��ʽ
function handleArticleListStyleOrInfoStyle(folderName, inputName, byVal thisValue)
    dim resourceDir, content, c, splStr, fileName, sel  

    resourceDir = cfg_webImages & "\" & folderName & "\" 

    content = getDirHtmlNameList(resourceDir) 

    thisValue = LCase(thisValue)                                                    'ת��Сд �öԱ�

    c = c & "  <select name=""" & inputName & """ id=""" & inputName & """>" & vbCrLf 
    c = c & "    <option value=""""></option>" & vbCrLf 
    splStr = split(content, vbCrLf) 
    for each fileName in splStr
        if fileName <> "" then
            sel = IIF(LCase(fileName) = thisValue, " selected", "") 
            c = c & "    <option value=""" & fileName & """" & sel & ">" & fileName & "</option>" & vbCrLf 
        end if 
    next 
    c = c & "  </select>" & vbCrLf 

    handleArticleListStyleOrInfoStyle = c 
end function 

'���ģ��Ƥ�� ShowWebModuleSkins("ModuleSkins", ModuleSkins)
function showWebModuleSkins(inputName, byVal thisValue)
    dim resourceDir, content, c, splStr, fileName, sel 
    resourceDir = cfg_webImages & "\Index\column" 
    'Call Echo("ResourceDir",ResourceDir)
    content = getDirFolderNameList(resourceDir) 
    'Call Echo("Content",Content)

    thisValue = LCase(thisValue)                                                    'ת��Сд �öԱ�

    c = c & "  <select name=""" & inputName & """ id=""" & inputName & """>" & vbCrLf 
    c = c & "    <option value=""""></option>" & vbCrLf 
    splStr = split(content, vbCrLf) 
    for each fileName in splStr
        if fileName <> "" then
            sel = IIF(LCase(fileName) = thisValue, " selected", "") 
            c = c & "    <option value=""" & fileName & """" & sel & ">" & fileName & "</option>" & vbCrLf 
        end if 
    next 
    c = c & "  </select>" & vbCrLf 

    showWebModuleSkins = c 
end function 

'��ʾ��ѡ���б�
function showRadioList(IDName, content, sSplType, thisValue)
    dim c, sel, splStr, s, i 
    IDName = trim(IDName) 
    if sSplType = "" then sSplType = "|_-|" 
    i = 0 
    splStr = split(content, sSplType) 
    for each s in splStr
        sel = "" : i = i + 1 
        if s = thisValue then sel = " checked" 
        c = c & "<input type=""radio"" name=""" & IDName & """ id=""" & IDName & i & """ value=""radio"" " & sel & "><label for=""" & IDName & i & """>" & s & "</label>" & vbCrLf 
    next 

    showRadioList = c 
end function 
'��ʾInput��ѡ InputCheckBox("Id",ID,"")
function inputCheckBox(textName, isChecked, helpStr)
    'Dim sel
    'If CStr(valueStr) = "True" Or CStr(isChecked) = "1" Then sel = " isChecked" Else sel = ""
    'inputCheckBox = "<input type='checkbox' name='" & textName & "' id='" & textName & "'" & sel & " value='1'>"
    'If helpStr <> "" Then inputCheckBox = "<label for='" & textName & "'>" & inputCheckBox & helpStr & "</label> "
    inputCheckBox = handleInputCheckBox(textName, isChecked, "1", helpStr, "") 
end function 
'��ʾInput��ѡ InputCheckBox("Id",ID,"")
function inputCheckBox3(textName, isChecked, valueStr, helpStr)
    inputCheckBox3 = handleInputCheckBox(textName, isChecked, valueStr, helpStr, "newidname") 
end function 
function handleInputCheckBox(textName, isChecked, valueStr, helpStr, sType)
    dim s, sel, idName 
    if CStr(valueStr) = "True" or isChecked = true then sel = " checked" else sel = "" 
    idName = textName                                                               'id�������ļ�����
    sType = "|" & sType & "|" 
    if inStr(sType, "|newidname|") > 0 then
        idName = textName & phprand(1, 9999) 
    end if 
    s = "<input type='checkbox' name='" & textName & "' id='" & idName & "'" & sel & " value='" & valueStr & "'>" 
    if helpStr <> "" then s = "<label for='" & idName & "'>" & s & helpStr & "</label> " 
    handleInputCheckBox = s 
end function 

'��ʾInput�ı�  InputText("FolderName", FolderName, "40px", "��������")
function inputText(textName, valueStr, width, helpStr)
    dim css 

    width = trim(LCase(width)) 
    if width <> "" then
        if right(width, 1) <> "%" and right(width, 2) <> "px" then
            width = width & "px" 
        end if 
        css = " style='width:" & width & ";'" 
    end if 
    inputText = "<input name=""" & textName & """ type=""text"" id=""" & textName & """ value=""" & valueStr & """" & css & " />" & helpStr 
end function 
'��ʾInput�ı�  InputText("FolderName", FolderName, "40px", "��������")
function inputText2(textName, valueStr, width, className, helpStr)
    dim css 
    if className <> "" then
        className = " class=""" & className & """" 
    end if 
    width = trim(LCase(width)) 
    if width <> "" then
        if right(width, 1) <> "%" and right(width, 2) <> "px" then
            width = width & "px" 
        end if 
        css = " style='width:" & width & ";'" 
    end if 
    inputText2 = "<input name=""" & textName & """ type=""text"" id=""" & textName & """ value=""" & valueStr & """" & css & className & " />" & helpStr 
end function 
'��ʾInput�ı������  InputLeftText(TextName, ValueStr, "98%", "")
function inputLeftText(textName, valueStr, width, helpStr)
    dim css 
    width = trim(LCase(width)) 
    if width <> "" then
        if right(width, 1) <> "%" and right(width, 2) <> "px" then
            width = width & "px" 
        end if 
        css = " style='width:" & width & ";'" 
    end if 
    inputLeftText = helpStr & "<input name=""" & textName & """ type=""text"" id=""" & textName & """ value=""" & valueStr & """" & css & " />" & vbCrLf 
end function 
'��ʾInput�ı������ �����������ұ�
function inputLeftTextHelpTextRight(textName, valueStr, width, helpStr)
    dim css 
    width = trim(LCase(width)) 
    if width <> "" then
        if right(width, 1) <> "%" and right(width, 2) <> "px" then
            width = width & "px" 
        end if 
        css = " style='width:" & width & ";'" 
    end if 
    inputLeftTextHelpTextRight = "<input name=""" & textName & """ type=""text"" id=""" & textName & """ value=""" & valueStr & """" & css & " />" & helpStr 
end function 
'��ʾInput�ı����б� ��ʾ�ı������
function inputLeftTextContent(textName, valueStr, width, helpStr)
    inputLeftTextContent = handleInputLeftRightTextContent("���", textName, valueStr, width, helpStr) 
end function 
'��ʾInput�ı����б� ��ʾ�ı����ұ�
function inputRightTextContent(textName, valueStr, width, helpStr)
    inputRightTextContent = handleInputLeftRightTextContent("�ұ�", textName, valueStr, width, helpStr) 
end function 
'��ʾInput�ı����б� ��ʾ�ı������ �� ��ʾ�ı����ұ� 20150114
function handleInputLeftRightTextContent(sType, textName, valueStr, width, helpStr)
    dim css 
    width = trim(LCase(width)) 
    if width <> "" then
        if right(width, 1) <> "%" and right(width, 2) <> "px" then
            width = width & "px" 
        end if 
        css = " style='width:" & width & ";'" 
    end if 
    if css = "" then
        css = " style='text-align:center;'" 
    else
        css = replace(css, ";'", ";text-align:center;'") 
    end if 
    handleInputLeftRightTextContent = "<input name=""" & textName & """ type=""text"" id=""" & textName & """ value=""" & valueStr & """" & css & " />" 

    if sType = "���" then
        handleInputLeftRightTextContent = helpStr & handleInputLeftRightTextContent & vbCrLf 
    else
        handleInputLeftRightTextContent = handleInputLeftRightTextContent & helpStr 
    end if 

end function 

'��ʾInput�ı����������
function inputLeftPassText(textName, valueStr, width, helpStr)
    dim css 
    width = trim(LCase(width)) 
    if width <> "" then
        if right(width, 1) <> "%" and right(width, 2) <> "px" then
            width = width & "px" 
        end if 
        css = " style='width:" & width & ";'" 
    end if 
    inputLeftPassText = helpStr & "<input name=""" & textName & """ type=""password"" id=""" & textName & """ value=""" & valueStr & """" & css & " />" & vbCrLf 
end function 
'��ʾInput�ı��������������
function inputLeftPassTextContent(textName, valueStr, width, helpStr)
    dim css 
    width = trim(LCase(width)) 
    if width <> "" then
        if right(width, 1) <> "%" and right(width, 2) <> "px" then
            width = width & "px" 
        end if 
        css = " style='width:" & width & ";'" 
    end if 
    if css = "" then
        css = " style='text-align:center;'" 
    else
        css = replace(css, ";'", ";text-align:center;'") 
    end if 
    inputLeftPassTextContent = helpStr & "<input name=""" & textName & """ type=""password"" id=""" & textName & """ value=""" & valueStr & """" & css & " />" & vbCrLf 
end function 
'��ʾInput�����ı�
function inputHiddenText(textName, valueStr)
    inputHiddenText = "<input name=""" & textName & """ type=""hidden"" id=""" & textName & """ value=""" & valueStr & """ />" & vbCrLf 
end function 
'��ʾInput�ı��� InputTextArea("FindTpl", FindTpl, "60%" , "120px", "")
function inputTextArea(textName, valueStr, width, height, helpStr)
    dim css, heightStr 
    width = trim(LCase(width)) 
    if width <> "" then
        if right(width, 1) <> "%" and right(width, 2) <> "px" then
            width = width & "px" 
        end if 
        css = " style='width:" & width & ";'" 
    end if 
    if height <> "" then
        if checkNumber(height) then                                                     '�Զ��Ӹ�px����
            height = height & "px" 
        end if 
        heightStr = "height:" & height & ";" 
        if css <> "" then
            css = replace(css, ";'", ";" & heightStr & ";'") 
        else
            css = " style='height:" & height & ";'" 
        end if 
    end if 
    css = replace(css, ";;", ";")                                                   'ȥ�������ֵ
    inputTextArea = "<textarea name=""" & textName & """ type=""text"" id=""" & textName & """" & css & ">" & valueStr & "</textarea>" & helpStr 
end function 
'��ʾ����Input�ı��� InputTextArea("WebDescription", WebDescription, "99%", "100px", "")
function inputHiddenTextArea(textName, valueStr, width, height, helpStr)
    inputHiddenTextArea = handleInputHiddenTextArea(textName, valueStr, width, height, "", helpStr) 
end function 
'��ʾ����Input�ı��� InputTextArea("WebDescription", WebDescription, "99%", "100px", "")
function handleInputHiddenTextArea(textName, valueStr, width, height, className, helpStr)
    dim css, heightStr 
    if className <> "" then
        className = " class=""" & className & """" 
    end if 
    if width <> "" then css = " style='width:" & width & ";'" 
    if height <> "" then
        heightStr = "height:" & height & ";" 
        if css <> "" then
            css = replace(css, ";'", ";" & heightStr & ";'") 
        else
            css = " style='height:" & height & ";display:none;'" 
        end if 
    end if 
    handleInputHiddenTextArea = "<textarea name=""" & textName & """ type=""text"" id=""" & textName & """" & css & className & ">" & valueStr & "</textarea>" & helpStr 
end function 
'��ʾĿ¼�б� ��Select��ʽ��ʾ
function showSelectDirList(folderPath, valueStr)
    dim splStr, c, fileName, sel 
    splStr = split(getDirFileSort(folderPath), vbCrLf) 
    for each fileName in splStr
        if fileName <> "" then
            sel = IIF(valueStr = fileName, " selected", "") 
            c = c & "<option value=""" & folderPath & fileName & """ " & sel & ">" & fileName & "</option>" & vbCrLf 
        end if 
    next 
    showSelectDirList = c 
end function 
'��Input�Ӹ�Disabled���ɲ���
function inputDisabled(byVal content)
    inputDisabled = replace(content, "<input ", "<input disabled=""disabled"" ") 
end function 

'��Input�Ӹ�rel��ϵ����
function inputAddAlt(byVal content, altStr)
    dim searchStr, replaceStr 
    searchStr = "<input " 
    replaceStr = searchStr & "alt=""" & altStr & """ " 
    if inStr(content, searchStr) > 0 then
        content = replace(content, searchStr, replaceStr) 
    else
        searchStr = "<textarea " 
        replaceStr = searchStr & "alt=""" & altStr & """ " 
        if inStr(content, searchStr) > 0 then
            content = replace(content, searchStr, replaceStr) 
        end if 
    end if 
    inputAddAlt = content 
end function 



'���ٵ�������====================================================

'��վ����
function webTitle_InputTextArea(webTitle)
    webTitle_InputTextArea = inputText("WebTitle", webTitle, "70%", "  ����ؼ�����-����") '����Ϊ��վĬ�ϱ���
end function 
'��վ�ؼ���
function webKeywords_InputText(webKeywords)
    webKeywords_InputText = inputText("WebKeywords", webKeywords, "70%", " ���ԣ�����(���Ķ���)") 
end function 
'��վ����
function webDescription_InputTextArea(webDescription)
    webDescription_InputTextArea = inputTextArea("WebDescription", webDescription, "99%", "100px", "") 
end function 
'��̬�ļ�����
function folderName_InputText(folderName)
    folderName_InputText = inputText("FolderName", folderName, "40%", "") 
end function 
'��̬�ļ���
function fileName_InputText(fileName)
    fileName_InputText = inputText("FileName", fileName, "40%", ".html Ҳ�����������ϵ����ӵ�ַ") 
end function 
'ģ���ļ���

function templatePath_InputText(templatePath)
    templatePath_InputText = inputText("TemplatePath", templatePath, "40%", " ����ΪĬ��") 
end function 
'���ƴ����ť����
function clickPinYinHTMLStr(did)
    clickPinYinHTMLStr = "<a href=""javascript:GetPinYin('FolderName','" & did & "','AjAx.Asp?act=GetPinYin')"" >���ƴ��</a>" 
end function 
'ѡ���ı���ɫ���ı��Ӵ�
function showFontColorFontB(fontColor, isFontB)
    showFontColorFontB = selectFontColor(fontColor) & inputCheckBox("FontB", isFontB, "�Ӵ�") 
end function 
'��ʾ�ı�TEXT����
function showSort(sort)
    showSort = inputText("Sort", sort, "30px", "") 
    showSort = replace(showSort, ";'", ";text-align:center;'") 
end function 
'��վ�������Ͷ����ײ���
function showWebNavType(isNavTop, isNavButtom, isNavLeft, isNavContent, isNavRight, isNavOthre)
    dim c 
    c = c & inputCheckBox("NavTop", isNavTop, "��������") 
    c = c & inputCheckBox("NavButtom", isNavButtom, "�ײ�����") 
    c = c & inputCheckBox("NavLeft", isNavLeft, "��ߵ���") 
    c = c & inputCheckBox("NavContent", isNavContent, "�м䵼��") 
    c = c & inputCheckBox("NavRight", isNavRight, "�ұߵ���") 
    c = c & inputCheckBox("NavOthre", isNavOthre, "��������") 
    showWebNavType = c 
end function 
function showOnHtml(isOnHtml)
    showOnHtml = inputCheckBox("OnHtml", isOnHtml, "����HTML") 
end function 
function showThrough(isThrough)
    showThrough = inputCheckBox("Through", isThrough, "���") 
end function 
function showRecommend(isRecommend)
    showRecommend = inputCheckBox("Recommend", isRecommend, "�Ƽ�") 
end function 
'��ʾ������ر�ͼƬ
function showOnOffImg(id, table, fieldName, isRecommend, url)
    dim temp, img, aUrl 
    if rq("page") <> "" then temp = "&page=" & rq("page") else temp = "" 
    if isRecommend = true then
        img = "<img src=""" & adminDir & "Images/yes.gif"">" 
    else
        img = "<img src=""" & adminDir & "Images/webno.gif"">" 
    end if 
    'Call Echo(GetUrl(),""& adminDir &"HandleDatabase.Asp?act=SetTrueFalse&Table=" & Table & "&FieldName=" & FieldName & "&Url=" & Url & "&Id=" & Id)
    aUrl = getUrlAddToParam(getUrl(), "" & adminDir & "HandleDatabase.Asp?act=SetTrueFalse&Table=" & table & "&FieldName=" & fieldName & "&Url=" & url & "&Id=" & id, "replace") 
    showOnOffImg = "<a href=""" & aUrl & """>" & img & "</a>" 
    '�ɰ�
'ShowOnOffImg = "<a href="& adminDir &"HandleDatabase.Asp?act=SetTrueFalse&Table=" & Table & "&FieldName=" & FieldName & "&Url=" & Url & "&Id=" & Id & Temp & ">" & Img & "</a>"
end function 
'��ʾ������ر�ͼƬ
function newShowOnOffImg(id, table, fieldName, isRecommend, url)
    dim temp, img 
    if rq("page") <> "" then temp = "&page=" & rq("page") else temp = "" 
    if isRecommend = true then
        img = "<img src=""/Images/yes.gif"">" 
    else
        img = "<img src=""/Images/webno.gif"">" 
    end if 
    newShowOnOffImg = "<a href=/WebAdmin/ZAction.Asp?act=Through&Table=" & table & "&FieldName=" & fieldName & "&Url=" & url & "&Id=" & id & temp & ">" & img & "</a>" 
end function 


'��ÿ���Css��ʽ 20150128  ��ʱ����
function controlDialogCss()
    dim c 
    c = "<style>" & vbCrLf 
    c = c & "/*����Css20150128*/" & vbCrLf 
    c = c & ".controlDialog{" & vbCrLf 
    c = c & "    position:relative;" & vbCrLf 
    c = c & "    height:50px;" & vbCrLf 
    c = c & "    width:auto;" & vbCrLf 
    c = c & "}" & vbCrLf 
    c = c & ".controlDialog .menu{" & vbCrLf 
    c = c & "    position:absolute;" & vbCrLf 
    c = c & "    right:0px;" & vbCrLf 
    c = c & "    top:0px;" & vbCrLf 
    c = c & "}" & vbCrLf 
    c = c & ".controlDialog .menu a{" & vbCrLf 
    c = c & "    color:#FF0000;" & vbCrLf 
    c = c & "    font-size:14px;" & vbCrLf 
    c = c & "    text-decoration:none;" & vbCrLf 
    c = c & "    background-color:#FFFFFF;" & vbCrLf 
    c = c & "    border:1px solid #003300;" & vbCrLf 
    c = c & "    padding:4px;" & vbCrLf 
    c = c & "}" & vbCrLf 
    c = c & ".controlDialog .menu a:hover{" & vbCrLf 
    c = c & "    color:#C60000;" & vbCrLf 
    c = c & "    text-decoration:underline;" & vbCrLf 
    c = c & "}" & vbCrLf 
    c = c & "</style>" & vbCrLf 
    controlDialogCss = c 
end function 


'ɾ�����ݴ����
function batchDeleteTempStr(content, startStr, endStr)
    dim i, s 
    for i = 1 to 9
        if inStr(content, startStr) = 0 then
            exit for 
        end if 
        s = getStrCut(content, startStr, endStr, 1) 
        content = replace(content, s, "") 
    next 
    batchDeleteTempStr = content 
end function 
%>     