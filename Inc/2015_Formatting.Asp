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
'��ʽ��20150212


'Html��ʽ�� �򵥰� ��ǿ��2014 12 09��20150709
function htmlFormatting(content)
    htmlFormatting = handleHtmlFormatting(content, false, 0, "") 
end function 

'������ʽ�� 
function handleHtmlFormatting(byVal content, isMsgBox, nErrLevel, action)
    dim splStr, s, tempS, lCaseS, c, left4Str, left5Str, left6Str, left7Str, left8Str 
    dim nLevel                                                                      '����
    dim elseS, elseLable 

    dim levelArray(299), keyWord 
    dim lableName                                                                   '��ǩ����
    dim isJavascript                                                                'Ϊjavascript
    dim isTextarea                                                                  'Ϊ�����ı���<textarea
    dim isPre                                                                       'Ϊpre
    isJavascript = false                                                            'Ĭ��javascriptΪ��
    isTextarea = false                                                              '�����ļ���Ϊ��
    isPre = false                                                                   'Ĭ��preΪ��
    nLevel = 0                                                                      '������

    action = "|" & action & "|"                                                     '����
    splStr = split(content, vbCrLf) 
    for each s in splStr
        tempS = s : elseS = s 
        s = trimVbCrlf(s) : lCaseS = lCase(s) 
        '�ж���20150710
        if(left(lCaseS, 8) = "<script " or left(lCaseS, 8) = "<script>") and inStr(s, "</"&"script>") = false and isJavascript = false then
            isJavascript = true 
            c = c & phptrim(tempS) & vbCrLf 
        elseIf isJavascript = true then

            if left(lCaseS, 9) = "</"&"script>" then
                isJavascript = false 
                c = c & phptrim(tempS) & vbCrLf                                                 '���������߿ո�
            else
                c = c & tempS & vbCrLf                                                          'Ϊjs����ʾԭ�ı�  ������������߿ո�phptrim(tempS)
            end if 

            '�����ı����ж���20151019
        elseIf(left(lCaseS, 10) = "<textarea " or left(lCaseS, 10) = "<textarea>") and inStr(s, "</textarea>") = false and isTextarea = false then
            isTextarea = true 
            c = c & phptrim(tempS) & vbCrLf 
        elseIf isTextarea = true then
            c = c & phptrim(tempS) & vbCrLf 
            if left(lCaseS, 11) = "</textarea>" then
                isTextarea = false 
            end if 
            '�����ı����ж���20151019
        elseIf(left(lCaseS, 5) = "<pre " or left(lCaseS, 5) = "<pre>") and inStr(s, "</pre>") = false and isPre = false then
            isPre = true 
            c = c & phptrim(tempS) & vbCrLf 
        elseIf isPre = true then
            c = c & tempS & vbCrLf 
            if left(lCaseS, 6) = "</pre>" then
                isPre = false 
            end if 


        elseIf s <> "" and isJavascript = false and isTextarea = false then
            left4Str = "|" & left(lCaseS, 4) & "|" : left5Str = "|" & left(lCaseS, 5) & "|" : left6Str = "|" & left(lCaseS, 6) & "|" 
            left7Str = "|" & left(lCaseS, 7) & "|" : left8Str = "|" & left(lCaseS, 8) & "|" 

            keyWord = ""                                                                    '�ؼ��ʳ�ʼ���
            lableName = ""                                                                  '��ǩ����
            if inStr("|<ul>|<ul |<li>|<li |<dt>|<dt |<dl>|<dl |<dd>|<dd |<tr>|<tr |<td>|<td |", left4Str) > 0 then
                keyWord = left4Str 
                lableName = mid(left4Str, 3, 2) 
            elseIf inStr("|<div>|<div |", left5Str) > 0 then
                keyWord = left5Str 
                lableName = mid(left5Str, 3, 3) 
            elseIf inStr("|<span>|<span |<form>|<form |", left6Str) > 0 then
                keyWord = left6Str 
                lableName = mid(left6Str, 3, 4) 

            elseIf inStr("|<table>|<table |<tbody>|<tbody |", left7Str) > 0 then
                keyWord = left7Str 
                lableName = mid(left7Str, 3, 5) 

            elseIf inStr("|<center>|<center |", left8Str) > 0 then
                keyWord = left8Str 
                lableName = mid(left8Str, 3, 6) 
            end if 
            keyWord = trim(replace(replace(keyWord, "<", ""), ">", "")) 
            'call echo(KeyWord,lableName)
            '��ʼ
            if keyWord <> "" then
                s = copyStr("    ", nLevel) & s 
                if right(lCaseS, 3 + len(lableName)) <> "</" & lableName & ">" and inStr(lCaseS, "</" & lableName & ">") = false then
                    nLevel = nLevel + 1 
                    if nLevel >= 0 then
                        levelArray(nLevel) = keyWord 
                    end if 
                end if 
            elseIf inStr("|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|", "|" & left(lCaseS, 5) & "|") > 0 or inStr("|</div>|", "|" & left(lCaseS, 6) & "|") > 0 or inStr("|</span>|</form>|", "|" & left(lCaseS, 7) & "|") > 0 or inStr("|</table>|</tbody>|", "|" & left(lCaseS, 8) & "|") > 0 or inStr("|</center>|", "|" & left(lCaseS, 9) & "|") > 0 then
                nLevel = nLevel - 1 
                s = copyStr("    ", nLevel) & s 
            else
                s = copyStr("    ", nLevel) & s 
                '����ǽ�����ǩ���һ��
                if right(lCaseS, 6) = "</div>" then
                    if checkHtmlFormatting(lCaseS) = false then
                        s = left(s, len(s) - 6) 
                        nLevel = nLevel - 1 
                        s = s & vbCrLf & copyStr("    ", nLevel) & "</div>" 
                    end if 
                elseIf right(lCaseS, 7) = "</span>" then
                    if checkHtmlFormatting(lCaseS) = false then
                        s = left(s, len(s) - 7) 
                        nLevel = nLevel - 1 
                        s = s & vbCrLf & copyStr("    ", nLevel) & "</span>" 
                    end if 
                elseIf inStr("|</ul>|</dt>|<dl>|<dd>|", left5Str) > 0 then
                    s = left(s, len(s) - 5) 
                    nLevel = nLevel - 1 
                    s = s & vbCrLf & copyStr("    ", nLevel) & right(lCaseS, 5) 
                end if 


                '��   aaa</li>   ���ֽ�����   20160106
                elseS = phptrim(lCase(elseS)) 
                if inStr(elseS, "</") > 0 then
                    elseLable = mid(elseS, inStr(elseS, "</")) 
                    if inStr("|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|</div>|</span>|<form>|", "|" & elseLable & "|") > 0 and nLevel > 0 then
                        nLevel = nLevel - 1 
                    end if 
                end if 
                'call echo("s",replace(s,"<","&lt;"))


            end if 
            'call echo("",ShowHtml(temps)
            c = c & s & vbCrLf 
        elseIf s = "" then
            if inStr(action, "|delblankline|") = false and inStr(action, "|ɾ������|") = false then'ɾ������
                c = c & vbCrLf 
            end if 
        end if 
    next 
    handleHtmlFormatting = c 
    nErrLevel = nLevel                                                              '��ô��󼶱�
    if nLevel <> 0 and isMsgBox=true then
        call echo("HTML��ǩ�д���", nLevel) 
    end if 
'Call Echo("nLevel",nLevel & "," & levelArray(nLevel))                '��ʾ�������20150212
end function 

'�����պ�HTML��ǩ(20150902)  ������ĸ����� �������  �޸�<script>����20160719home
function formatting(content, action)
    dim i, endStr, s, c, labelName, startLabel, endLabel, endLabelStr, nLevel, isYes, parentLableName, nTempI, tempS 
    dim sNextLableName                                                               '��һ����������
    dim isA                                                                         '�Ƿ�ΪA����
    dim isTextarea                                                                  '�Ƿ�Ϊ���������ı���
    dim isScript                                                                    '�ű�����
    dim isStyle                                                                     'Css�����ʽ��
    dim isPre                                                                       '�Ƿ�Ϊpre
    startLabel = "<" 
    endLabel = ">" 
    nLevel = 0 
    action = "|" & action & "|"                                                     '�㼶
    isA = false : isTextarea = false : isScript = false : isStyle = false : isPre = false 
    content = replace(replace(content, vbCrLf, chr(10)), vbTab, "    ") 

    for i = 1 to len(content)
        s = mid(content, i, 1) 
        endStr = mid(content, i) 
        isYes = false 
        if s = "<" then
            if inStr(endStr, ">") > 0 then
                tempS = mid(endStr, 1, inStr(endStr, ">")) 
                nTempI = i + len(tempS) - 1 
                tempS = mid(tempS, 2, len(tempS) - 2) 
                if right(tempS, 1) = "/" then
                    tempS = phptrim(left(tempS, len(tempS) - 1)) 
                end if 
                endStr = right(endStr, len(endStr) - len(tempS) - 2)                            '����ַ���ȥ��ǰ��ǩ  -2����Ϊ����<>�����ַ�
                'ע��֮ǰ����labelName����
                labelName = mid(tempS, 1, inStr(tempS & " ", " ") - 1) 
                labelName = lCase(labelName) 

                'call echo("labelName",labelName)
                if labelName = "a" then
                    isA = true 
                elseIf labelName = "/a" then
                    isA = false 
                elseIf labelName = "textarea" then
                    isTextarea = true 
                elseIf labelName = "/textarea" then
                    isTextarea = false 
                elseIf labelName = "script" then
                    isScript = true 
                elseIf labelName = "/script" then
                    isScript = false 
                elseIf labelName = "style" then
                    isStyle = true 
                elseIf labelName = "/style" then
                    isStyle = false 
                elseIf labelName = "pre" then
                    isPre = true 
                elseIf labelName = "/pre" then
                    isPre = false 
                elseif isScript = true then
                    isYes = true 
                end if 
            end if 
 
            if isYes = false then
                'call echo("","11111111111")
                s = tempS 
                i = nTempI 

                endLabelStr = endLabel 
                sNextLableName = getHtmlLableName(endStr, 0) 
                '��Ϊѹ��HTML
                if inStr(action, "|ziphtml|") = false and isPre = false then
                    if isA = false then
                        if inStr("|a|strong|u|i|s|script|", "|" & labelName & "|") = false and sNextLableName<>"/" & labelName and inStr("|/a|/strong|/u|/i|/s|/script|", "|" & sNextLableName & "|") = false then
                            endLabelStr = endLabelStr & chr(10) 
                        end if 
                    end if 
                end if 
                '����ǩ���Ӹ� /   20160615
                if instr("|br|hr|img|input|param|meta|link|", "|" & labelName & "|") > 0 then
                    s = s & " /" 
                end if 

                s = startLabel & s & endLabelStr 
                '��Ϊѹ��HTML
                if inStr(action, "|ziphtml|") = false and isPre = false then
                    '�������            aaaaa</span>
                    if isA = false and isYes = false and left(labelName, 1) = "/" and labelName <> "/script" and labelName <> "/a" then
                        '�ų�����    <span>���췢��</span>     �����ж���һ���ֶβ�����vbcrlf����
                        if labelName  <> "/" & parentLableName and right(trim(c), 1) <> chr(10) then
                            s = chr(10) & s 
                        end if 
                    end if 
                end if 
                parentLableName = labelName 
                isYes = true 
            end if 
        elseIf s <> "" then
            isYes = false 
            'call echo("isPre",isPre)
            if isPre = false then
                if s = chr(10) then
                    if isTextarea = false and isScript = false and isStyle = false then
                        s = "" 
                    elseIf isScript = true then
                        if inStr(action, "|zipscripthtml|") > 0 then
                            s = " " 
                        end if 
                    elseIf isStyle = true then
                        if inStr(action, "|zipstylehtml|") > 0 then
                            s = "" 
                        end if 
                    elseIf isTextarea = true then
                        if inStr(action, "|ziptextareahtml|") > 0 then
                            s = "" 
                        end if 
                    else
                        s = chr(10)  
                    end if 
                'Right(Trim(c), 1) = ">")   Ϊ��ѹ��ʱ�õ�
                elseIf(right(trim(c), 1) = chr(10) or right(trim(c), 1) = ">") and phptrim(s) = "" and isTextarea = false and isScript = false then
                    s = "" 
                end if 
            end if 
        end if 
        c = c & s 
    next 
    c = replace(c, chr(10), vbCrLf) 
    formatting = c 
end function 

function zipHTML(c)
    zipHTML = formatting(c, "ziphtml|zipscripthtml|zipstylehtml")                   'ziphtml|zipscripthtml|zipstylehtml|ziptextareahtml
end function 

'���HTML��ǩ�Ƿ�ɶԳ��� �磨<div><ul><li>aa</li></ul></div></div>��
function checkHtmlFormatting(byVal content)
    dim splStr, s, c, splxx, nLable, lableStr 
    content = lCase(content) 
    splStr = split("ul|li|dt|dd|dl|div|span", "|") 
    for each s in splStr
        s = phptrim(s) 
        if s <> "" then
            nLable = 0 
            lableStr = "<" & s & " " 
            if inStr(content, lableStr) > 0 then
                splxx = split(content, lableStr) 
                nLable = nLable + uBound(splxx) 
            end if 
            lableStr = "<" & s & ">"  
            if inStr(content, lableStr) > 0 then
                splxx = split(content, lableStr) 
                nLable = nLable + uBound(splxx) 
            end if  
            lableStr = "</" & s & ">" 
            if inStr(content, lableStr) > 0 then
                splxx = split(content, lableStr) 
                nLable = nLable - uBound(splxx) 
            end if 
            'call echo(ShowHtml(lableStr),nLable)
            if nLable <> 0 then
                checkHtmlFormatting = false 
                exit function 
            end if 
        end if 
    next 
    checkHtmlFormatting = true 
end function 


%>     
