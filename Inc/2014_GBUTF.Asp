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
'���뻥�� GB2312��UTF-8ת��

'UTFתGB23
function UTF2GB(byVal UTFStr)
    dim nDig, GBStr 
    for nDig = 1 to len(UTFStr)
        '���UTF8����������%��ͷ�����ת��
        if mid(UTFStr, nDig, 1) = "%" then
            'UTF8�������ִ���8��ת��Ϊ����
            if len(UTFStr) >= nDig + 8 then
                GBStr = GBStr & convChinese(mid(UTFStr, nDig, 9)) 
                nDig = nDig + 8 
            else
                GBStr = GBStr & mid(UTFStr, nDig, 1) 
            end if 
        else
            GBStr = GBStr & mid(UTFStr, nDig, 1) 
        end if 
    next 
    UTF2GB = GBStr 
end function 

'����Ƿ���԰�UTFתGB2312
function checkUTFToGB2312(byVal UTFStr)
    dim nDig, GBStr 
    checkUTFToGB2312 = true 
    for nDig = 1 to len(UTFStr)
        '���UTF8����������%��ͷ�����ת��
        if mid(UTFStr, nDig, 1) = "%" then
            'UTF8�������ִ���8��ת��Ϊ����
            if len(UTFStr) >= nDig + 8 then
                if convChinese(mid(UTFStr, nDig, 9)) = "[����Error]" then
                    checkUTFToGB2312 = false : exit function 
                end if 
                nDig = nDig + 8 
            else
                GBStr = GBStr & mid(UTFStr, nDig, 1) 
            end if 
        else
            GBStr = GBStr & mid(UTFStr, nDig, 1) 
        end if 
    next  
end function 

'UTF8�������ֽ�ת��Ϊ���� �������
function convChinese(x)
    on error resume next 
    err.clear 
    dim arrStr, i, j, nDig, unicode 
    arrStr = split(mid(x, 2), "%") 
    i = 0 
    j = 0 
    for i = 0 to uBound(arrStr)
        arrStr(i) = c16to2(arrStr(i)) 
    next 
    for i = 0 to uBound(arrStr) - 1
        nDig = inStr(arrStr(i), "0") 
        unicode = "" 
        for j = 1 to nDig - 1
            if j = 1 then
                arrStr(i) = right(arrStr(i), len(arrStr(i)) - nDig) 
                unicode = unicode & arrStr(i) 
            else
                i = i + 1 
                arrStr(i) = right(arrStr(i), len(arrStr(i)) - 2) 
                unicode = unicode & arrStr(i) 
            end if 
        next 

        if len(c2to16(unicode)) = 4 then
            convChinese = convChinese & chrW(int("&H" & c2to16(unicode))) 
        else
            convChinese = convChinese & chr(int("&H" & c2to16(unicode))) 
        end if 
        if err <> 0 then convChinese = "[����Error]" : exit function      '��@����asp����@��     �������˳�
    next 
end function 



'תUTF8���룬�ǳ���׼�����ã�(2014 12 11) 
function UTF8_URLEncoding(szInput)
    dim wch, uch, szRet 
    dim x 
    dim nAsc 
    if szInput = "" then
        UTF8_URLEncoding = szInput 
        exit function 
    end if   
    for x = 1 to len(szInput)
        wch = mid(szInput, x, 1) 
        nAsc = ascW(wch) 

        if nAsc < 0 then nAsc = nAsc + 65536 

        if(nAsc and &HFF80) = 0 then
            szRet = szRet & wch 
        else
            if(nAsc and &HF000) = 0 then
                uch = "%" & hex(((nAsc \ 2 ^ 6)) or &HC0) & hex(nAsc and &H3F or &H80) 
                szRet = szRet & uch 
            else
                uch = "%" & hex((nAsc \ 2 ^ 12) or &HE0) & "%" & _ 
                hex((nAsc \ 2 ^ 6) and &H3F or &H80) & "%" & _ 
                hex(nAsc and &H3F or &H80) 
                szRet = szRet & uch 
            end if 
        end if 
    next 
    UTF8_URLEncoding = szRet 
end function 

'GBתUTF8--��GB��������ת��ΪUTF8��������  �������׼�����Ժ���ϳ���
function toUTF8(szInput)
    dim wch, uch, szRet 
    dim x 
    dim nAsc 
    '����������Ϊ�գ����˳�����
    if szInput = "" then
        toUTF8 = szInput 
        exit function 
    end if 
    '��ʼת��
    for x = 1 to len(szInput)
        '����mid�����ֲ�GB��������
        wch = mid(szInput, x, 1) 
        '����ascW��������ÿһ��GB�������ֵ�Unicode�ַ�����
        'ע��asc�������ص���ANSI �ַ����룬ע������
        nAsc = ascW(wch) 
        if nAsc < 0 then nAsc = nAsc + 65536 

        if(nAsc and &HFF80) = 0 then
            szRet = szRet & wch 
        else
            if(nAsc and &HF000) = 0 then
                uch = "%" & hex(((nAsc / 2 ^ 6)) or &HC0) & hex(nAsc and &H3F or &H80) 
                szRet = szRet & uch 
            else
                'GB�������ֵ�Unicode�ַ�������0800 - FFFF֮��������ֽ�ģ��
                uch = "%" & hex((nAsc / 2 ^ 12) or &HE0) & "%" & _ 
                hex((nAsc / 2 ^ 6) and &H3F or &H80) & "%" & _ 
                hex(nAsc and &H3F or &H80) 
                szRet = szRet & uch 
            end if 
        end if 
    next 

    toUTF8 = szRet 
end function 

'GBתunicode---��GB��������ת��Ϊunicode��������
function chinese2unicode(str)
    dim i 
    dim str_one 
    dim str_unicode 
    if(isNull(str)) then
        exit function 
    end if 
    for i = 1 to len(str)
        str_one = mid(str, i, 1) 
        str_unicode = str_unicode & chr(38) 
        str_unicode = str_unicode & chr(35) 
        str_unicode = str_unicode & chr(120) 
        str_unicode = str_unicode & hex(ascW(str_one)) 
        str_unicode = str_unicode & chr(59) 
    next 
    chinese2unicode = str_unicode 
end function 


'�ж��Ƿ�Ϊ��Ч��ʮ�����ƴ���
function isvalidhex(str)
    dim c 
    isvalidhex = true 
    str = uCase(str) 
    if len(str) <> 3 then isvalidhex = false : exit function 
    if left(str, 1) <> "%" then isvalidhex = false : exit function 
    c = mid(str, 2, 1) 
    if not(((c >= "0") and(c <= "9")) or((c >= "A") and(c <= "Z"))) then isvalidhex = false : exit function 
    c = mid(str, 3, 1) 
    if not(((c >= "0") and(c <= "9")) or((c >= "A") and(c <= "Z"))) then isvalidhex = false : exit function 
end function 

'---------------------- �Լ��ļ����� ----------------------------
'����ͬJS��escapeһ��
function escape(str)
    dim i, s, c, n 
    s = "" 
    for i = 1 to len(str)
        c = mid(str, i, 1) 
        n = ascW(c) 
        if(n >= 48 and n <= 57) or(n >= 65 and n <= 90) or(n >= 97 and n <= 122) then
            s = s & c 
        elseIf inStr("@*_-./", c) > 0 then
            s = s & c 
        elseIf n > 0 and n < 16 then
            s = s & "%0" & hex(n) 
        elseIf n >= 16 and n < 256 then
            s = s & "%" & hex(n) 
        else
            s = s & "%u" & hex(n) 
        end if 
    next 
    escape = s 
end function 


'����ͬJS��unescapeһ��
function unescape(str)
    dim i, sNew, c, isChar, lastChar, sNext_1_c, next_1_num 
    isChar = false 
    lastChar = "" 
    sNew = "" 
    for i = 1 to len(str)
        c = mid(str, i, 1) 
        if c = "+" then
            sNew = sNew & " " 
        elseIf mid(str, i, 2) = "%u" and i <= len(str) - 5 then
            if isNumeric("&H" & mid(str, i + 2, 4)) then
                sNew = sNew & chrW(CInt("&H" & mid(str, i + 2, 4))) 
                i = i + 5 
            else
                sNew = sNew & c 
            end if 
            'ElseIf c="%" and i<=Len(str)-2 Then
            'If IsNumeric("&H" & Mid(str,i+1,2)) Then
            'newstr = newstr & ChrW(CInt("&H" & Mid(str,i+1,2)))
            'i = i+2
            'Else
            'newstr = newstr & c
        'End If
        elseIf c = "%" and i <= len(str) - 2 then
            sNext_1_c = mid(str, i + 1, 2) 
            if isNumeric("&H" & sNext_1_c) then
                next_1_num = CInt("&H" & sNext_1_c) 
                if isChar = true then
                    isChar = false 
                    sNew = sNew & chr(CInt("&H" & lastChar & sNext_1_c)) 
                else
                    if abs(next_1_num) <= 127 then
                        sNew = sNew & chr(next_1_num) 
                    else
                        isChar = true 
                        lastChar = sNext_1_c 
                    end if 
                end if 
                i = i + 2 
            else
                sNew = sNew & c 
            end if 
        else
            sNew = sNew & c 
        end if 
    next 
    unescape = sNew 
end function 

'���������磺���й���&#x4E2D;&#x56FD;��
function chineseToUnicode(str)
    dim i, s, c 
    for i = 1 to len(str)
        s = mid(str, i, 1) 
        s = "&#x" & hex(ascW(s)) & ";" 
        c = c & s 
    next 
    chineseToUnicode = c 
end function 

'�⺺������
function unicodeToChinese(content)
    dim splStr, s, c 
    splStr = split(content, ";") 
    for each s in splStr
        if inStr(s, "&#x") > 0 then
            s = right(s, len(s) - 3) 
            c = c & chrW(CInt("&H" & s)) 
        end if 
    next 
    unicodeToChinese = c 
end function 



'Url����
function URLEncode(byRef strUrl)
    dim i 
    dim tempStr 
	URLEncode=""
    for i = 1 to len(strUrl)
        if asc(mid(strUrl, i, 1)) < 0 then
            tempStr = "%" & right(CStr(hex(asc(mid(strUrl, i, 1)))), 2) 
            tempStr = "%" & left(CStr(hex(asc(mid(strUrl, i, 1)))), len(CStr(hex(asc(mid(strUrl, i, 1))))) - 2) & tempStr 
            URLEncode = URLEncode & tempStr 
        elseIf(asc(mid(strUrl, i, 1)) >= 65 and asc(mid(strUrl, i, 1)) <= 90) or(asc(mid(strUrl, i, 1)) >= 97 and asc(mid(strUrl, i, 1)) <= 122) then
            URLEncode = URLEncode & mid(strUrl, i, 1) 
        else
            URLEncode = URLEncode & "%" & hex(asc(mid(strUrl, i, 1))) 
        end if 
    next 
end function 

'URL����   �������
function URLDecode(byRef strUrl)
    dim i 
	URLDecode=""
    if inStr(strUrl, "%") = 0 then URLDecode = strUrl : exit function 
    for i = 1 to len(strUrl)
        if mid(strUrl, i, 1) = "%" then
            if val("&H" & mid(strUrl, i + 1, 2)) > 127 then
                URLDecode = URLDecode & chr(val("&H" & mid(strUrl, i + 1, 2) & mid(strUrl, i + 4, 2))) 
                i = i + 5 
            else
                URLDecode = URLDecode & chr(val("&H" & mid(strUrl, i + 1, 2))) 
                i = i + 2 
            end if 
        else
            URLDecode = URLDecode & mid(strUrl, i, 1) 
        end if 
    next 
end function 
 
'GB2312��UTF-8
function toUTFChar(szInput)
    dim wch, uch, szRet 
    dim x 
    dim nAsc 
    '����������Ϊ�գ����˳�����
    if szInput = "" then
        toUTFChar = szInput 
        exit function 
    end if 
    '��ʼת��
    for x = 1 to len(szInput)
        wch = mid(szInput, x, 1) 
        nAsc = ascW(wch) 
        if nAsc < 0 then nAsc = nAsc + 65536 
        if(nAsc and &HFF80) = 0 then
            szRet = szRet & wch 
        else
            if(nAsc and &HF000) = 0 then
                uch = "%" & hex(((nAsc \ 2 ^ 6)) or &HC0) & hex(nAsc and &H3F or &H80) 
                szRet = szRet & uch 
            else
                uch = "%" & hex((nAsc \ 2 ^ 12) or &HE0) & "%" & _ 
                hex((nAsc \ 2 ^ 6) and &H3F or &H80) & "%" & _ 
                hex(nAsc and &H3F or &H80) 
                szRet = szRet & uch 
            end if  
        end if 
    next 
    toUTFChar = szRet 
end function 

'���ܽ���URL
function encDecURL(byVal content, byVal sType)
    dim yStr, tStr, temp, i, s, c 
    yStr = "abcdefghijklmnopqrstuvwxyz0123456789:/.=& ()%" 
    tStr = "9ab1cdefghij234klmnopqrst678uvwxyz:/.05*-$[]@" 
    if sType = "����" or sType = "0" then
        temp = yStr 
        yStr = tStr 
        tStr = temp 
    end if 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if inStr(yStr, s) > 0 then
            s = mid(tStr, inStr(yStr, s), 1) 
        end if 
        c = c & s 
    next 
    encDecURL = c 
end function 

'����URL (����)
function encURL(content)
    encURL = encDecURL(content, "����") 
end function 

'����URL (����)
function decURL(content)
    decURL = encDecURL(content, "����") 
end function 

%>   
