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

'�ж��Ƿ�Ϊ�ַ�ת�� 
function isStrTransferred(content)
    dim splStr, i, s, nCount 
    nCount = 0 
    isStrTransferred = false  
    for i = 0 to len(content) - 1   
        s = mid(content, len(content) - i, 1) 
        if s = "\" then
            nCount = nCount + 1 
        else
            isStrTransferred = IIF(nCount mod 2 = 1, true, false) 
            exit function 
        end if 
    next  
end function 

'������ʣ���Ϸ�������õ� 20150601
function getBL(nSetWidth, nSetHeight, nDanFuXianZhi)
    dim arrNSplStr(3) 
    dim nWidthZheFu : nWidthZheFu = 1                                               '������ 
    dim nHeightZheFu : nHeightZheFu = 1                                             '������
    dim nBFB                                                                        '�ٷֱ�
    dim nXXFBX                                                                      'ÿ���ٷֱȣ���ΪҪ�ж������ܳ���10
    if nSetWidth < 0 then
        nSetWidth = nSetWidth * - 1 
        nWidthZheFu = -1 
    end if 
    if nSetHeight < 0 then
        nSetHeight = nSetHeight * - 1 
        nHeightZheFu = -1 
    end if 
    if nSetWidth > nSetHeight then
        nBFB = cint(formatNumber(nSetWidth / nSetHeight, 2))                                  '//���� �ٷֱ�
        arrNSplStr(0) = nBFB 
        arrNSplStr(1) = 1 
    else
        nBFB = cint(formatNumber(nSetHeight / nSetWidth, 2))                                  '//�߿� �ٷֱ�
        arrNSplStr(0) = 1 
        arrNSplStr(1) = nBFB 
    end if 
    'ÿ������ָ��ֵ������
    'if nBFB>=nDanFuXianZhi then
    nXXFBX = cint(formatNumber(nDanFuXianZhi / nBFB, 2)) 
    arrNSplStr(0) = arrNSplStr(0) * nXXFBX 
    arrNSplStr(1) = arrNSplStr(1) * nXXFBX 
    'end if

    arrNSplStr(0) = arrNSplStr(0) * nWidthZheFu 
    arrNSplStr(1) = arrNSplStr(1) * nHeightZheFu 
    arrNSplStr(2) = nBFB 
    arrNSplStr(3) = getCountPage(nSetWidth, arrNSplStr(0)) 
    'Call echo("page count ҳ��", arrNSplStr(3))
    arrNSplStr(3) = getCountStep(nSetWidth, nSetHeight, arrNSplStr(0), arrNSplStr(1), arrNSplStr(3)) 

    getBL = arrNSplStr 
end function 

'����ܲ���
function getCountStep(nWidthStep, nHeightStep, nWidthBL, nHeightBL, nCountPage)
    dim i 
    getCountStep = 0
    if nWidthStep < 0 then
        nWidthStep = nWidthStep * - 1  
    end if 
    if nHeightStep < 0 then
        nHeightStep = nHeightStep * - 1 
    end if 
    if nWidthBL < 0 then
        nWidthBL = nWidthBL * - 1 
    end if 
    if nHeightBL < 0 then
        nHeightBL = nHeightBL * - 1 
    end if 
    for i = nCountPage - 10 to nCountPage
        'call echo(i & "��nWidthBL*i>=nWidthStep",nWidthBL*i &">="&nWidthStep    & "   |  " & nHeightBL*i &">="& nHeightStep)
        if nWidthBL * i >= nWidthStep or nHeightBL * i >= nHeightStep then
            getCountStep = i 
        'call echo("getCountStep",getCountStep)
        end if 
    next 
end function 


'������ĺ�������
function getChina(content)
    dim i, c, j, s 
    for i = 1 to len(content)
        j = asc(mid(content, i, 1)) 
        s = mid(content, i, 1) 
        '�Ǻ����ۼ�
        if j < 0 then
            if(j <= -22033 and j >= -24158) = false then
                c = c & s 
            end if 
        end if 
    next 
    getChina = c 
end function 
'�ж��Ƿ�������
function isChina(content)
    dim i, j, s 
    isChina = false 
    for i = 1 to len(content)
        j = asc(mid(content, i, 1)) 
        s = mid(content, i, 1) 
        '�Ǻ����ۼ�
        if j < 0 then
            if(j <= -22033 and j >= -24158) = false then
                isChina = true 
                exit function 
            end if 
        end if 
    next 
end function  
'�ж��Ƿ������� (����) 
function checkChina(content)
    checkChina = isChina(content) 
end function 

'PHP��Randʹ��20150212
function phpRand(nMinimum, nMaximum)
    randomize 
    phpRand = 0
    dim i 
    for i = 1 to 9
        phpRand = CInt((nMinimum + nMaximum) * rnd) 
        if phpRand >= nMinimum and phpRand <= nMaximum then 
            exit for 
        end if 
    next 
    if phpRand < nMinimum then
        phpRand = nMinimum 
    elseIf phpRand > nMaximum then
        phpRand = nMaximum 
    end if 
end function 

'�������棬Ϊʲô����Ϊ����д��������� 
function phpRnd(nMinimum, nMaximum)
    phpRnd = phpRand(nMinimum, nMaximum) 
end function 

 
'ɾ���ظ�����  20141220
function deleteRepeatStr(content, sSplType)
    dim splStr, s, c 
    c = "" 
    splStr = split(content, sSplType) 
    for each s in splStr
        if s <> "" then
            if inStr(sSplType & c & sSplType, sSplType & s & sSplType) = 0 then
                c = c & s & sSplType 
            end if 
        end if 
    next 
    if c <> "" then c = left(c, len(c) - len(sSplType)) 
    deleteRepeatStr = c 
end function 

'�滻����N�� 20141220
function replaceN(content, yunStr, replaceStr, nNumb)
    dim i,sNumb
    sNumb = handleNumber(cStr(nNumb))			'Ϊ�˸�.netc�� 
    if sNumb = "" then
        nNumb = 1 
    else
        nNumb = CInt(sNumb) 
    end if 
    for i = 1 to nNumb
        content = replace(content, yunStr, replaceStr) 
    next 

    replaceN = content 
end function 

'asp���ڲ�0����   ���ñ���20141216
function fillZero(content)
	fillZero=""
    if len(content) = 1 then
        fillZero = "0" & content 
    else
        fillZero = content 
    end if 
end function 

'���ִ�Сд�滻�����ߣ�С�ƣ�д��20140925 �÷�Response.Write(CaseInsensitiveReplace("112233aabbbccddee","b","С����ţ"))
function caseInsensitiveReplace(content, sCheck, sReplace)
    dim nStartLen, nEndLen, lowerCase, startStr, endStr, c, i 
    c = "" 
    if LCase(sCheck) = LCase(sReplace) then
        caseInsensitiveReplace = content 
    end if 
    lowerCase = LCase(content) 
    for i = 1 to 99
        if inStr(lowerCase, sCheck) > 0 then
            nStartLen = inStr(lowerCase, sCheck) - 1 
            startStr = left(content, nStartLen) 
            nEndLen = nStartLen + len(sCheck) + 1 
            endStr = mid(content, nEndLen)   
            content = startStr & sReplace & endStr 
            'Call Echo(StartLen,EndLen)
            'Call Echo(StartStr,EndStr)
            'Call Echo("Content",Content)
            lowerCase = LCase(content) 
        else
            exit for 
        end if 
    next 
    caseInsensitiveReplace = content 
end function  
 
'������������ (2013,10,1)
function array_Sort(arrnArray)
    dim i, j, nMinmaxSlot, nMinmax, nTemp 
    for i = uBound(arrnArray) to 0 step - 1
        nMinmax = arrnArray(i)  
        nMinmaxSlot = 0 
        for j = 1 to i
            if arrnArray(j) > nMinmax then
                nMinmax = arrnArray(j) 
                nMinmaxSlot = j 
            end if 
        next 
        if nMinmaxSlot <> i then
            nTemp = arrnArray(nMinmaxSlot) 
            arrnArray(nMinmaxSlot) = arrnArray(i) 
            arrnArray(i) = nTemp 
        end if 
    next 
    array_Sort = arrnArray 
end function 

'����Zip��С
function handleZipSize(byVal zipSize)
    on error resume next 
    dim nSize 
    zipSize = LCase(zipSize) 
    nSize = getDianNumb(zipSize) 
    if inStr(zipSize, "g")>0 then
        nSize = nSize * 1073741824 
    elseIf inStr(zipSize, "m")>0 then
        nSize = nSize * 1048576 
    elseIf inStr(zipSize, "k")>0 then
        nSize = nSize * 1024 
    end if 
    handleZipSize = nSize 
    if err then doError err.description, "HandleZipSize ����Zip��С ����������ZipSize=" & zipSize 
end function 

'//���������
function getRnd(byVal nCount)
    randomize 
    dim charS, i, c 
    for i = 1 to nCount
        if i mod 2 = 0 then
            charS = chrW((57 - 48) * rnd + 48)                                                  '0~9
        elseIf i mod 3 = 0 then
            charS = chrW((90 - 65) * rnd + 65)                                                  'A~Z
        else
            charS = chrW((122 - 97) * rnd + 97)                                                 'a~z
        end if 
        c = c & charS 
    next 
    getRnd = c 
end function 

'������������js(20150826)
function mathRandom()
    dim i, c 
    c = "" 
    randomize 
    for i = 1 to 16
        c = c & cint(int(rnd() * 9)) 
    next 
    mathRandom = "0." & c 
end function 



'���ָ��λ�����A��Z�ַ�
function getRndAZ(nCount)
    dim zd, i, s, c 
    c = "" : zd = "" 
    randomize 
    zd = "abcdefghijklmnopqrstuvwxyz" & uCase(zd) 
    for i = 1 to nCount
        s = mid(zd, phpRnd(1, len(zd)), 1) 
        c = c & s 
    next 
    getRndAZ = c 
end function 

'�������� ���������棩 
function getRand(byVal nCount)
    getRand = getRnd(nCount) 
end function 

'��������N�� InputStr����ֵ  nMultiplier������php����һ��2014 12 02
'��� nMultiplier ������ΪС�ڵ���0���������ؿ��ַ�����
function copyStrNumb(byVal inputStr, nMultiplier)
    dim i, s 
    if nMultiplier > 0 then
        s = inputStr 
        for i = 1 to nMultiplier - 1
            inputStr = inputStr & s 
        next 
    else
        inputStr = "" 
    end if 
    copyStrNumb = inputStr 
end function 

'��������N��  PHP�ﺯ��
function str_Repeat(byVal inputStr, nMultiplier)
    str_Repeat = copyStrNumb(inputStr, nMultiplier) 
end function 

'���������
function copyStr(inputStr, nMultiplier)
    copyStr = copyStrNumb(inputStr, nMultiplier) 
end function 

'���ݼ�Tab
function contentAddTab(byVal content, nNumb)
    contentAddTab = copyStr("    ", nNumb) & join(split(content, vbCrLf), vbCrLf & copyStr("    ", nNumb)) 
end function  

'ɾ�����ָ���ַ�20150228 Content=DeleteEndStr(Content,2) 
function deleteEndStr(content, nLen)
    if content <> "" then content = left(content, len(content) - nLen) 
    deleteEndStr = content 
end function 
    

'StringNumber (2013,9,27)
function toNumber(byVal n, byVal nD)
    toNumber = cint(formatNumber(n, nD, - 1))   
end function  

'����������
function handleNumber(byVal content)
    dim i, s, c 
    c = ""   
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if inStr("0123456789", s) > 0 then
            c = c & s 
        end if 
    next 
    handleNumber = c
end function 

'�ַ�������ȡ���� 20150507
function strDrawInt(byVal content)
    strDrawInt = handleNumber(content) 
end function 

'���������� ���ַ�������-����
function getFirstNegativeNumber(byVal content)
    dim i, s, c 
    c = "" 
    content = trim(content) 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if s = "-" and c = "" then
            c = c & s 
        elseIf inStr("0123456789", s) > 0 then
            c = c & s 
        end if 
    next 
    if c = "" then c = "0"
    getFirstNegativeNumber = c 
end function 

'����Ƿ�Ϊ��������
function checkNumberType(byVal content)
    checkNumberType = handleNumber(content) 
end function 

'����ַ�����Ϊ��������
function checkStrIsNumberType(byVal content)
    dim i, s 
    checkStrIsNumberType = true 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if inStr("0123456789", s) = 0 then
            checkStrIsNumberType = false 
            exit function 
        end if 
    next 
end function 

'��������������
function handleNumberType(byVal content)
    dim i, s, c 
    c = "" 
    content = trim(content) 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if i = 1 and inStr("+-*/", left(content, 1)) > 0 then
            c = c & s 
        elseIf i > 1 and s = "." then
            c = c & s 
        elseIf inStr("0123456789", s) > 0 then
            c = c & s 
        end if 
    next 
    handleNumberType = c 
end function 

'������� ֻ����������� ���ҵ�һ����������Ϊ��0     20150322
function getNumber(byVal content)
    dim i, s, c 
    c = "" 
    content = trim(content) 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if inStr("0123456789", s) > 0 then
            if c = "" and s = "0" then                                                      '���Ľ�����Ϊ�������Ӳ������ˣ�����ô����20150322
            else
                c = c & s 
            end if 
        end if 
    next 
    getNumber = c
end function 

'����Ƿ�Ϊ����
function checkNumb(c)
	dim s,i
	checkNumb = true
	for i = 1 to len(c)
		s=mid(c,i,1)
		if inStr("0123456789.", s) =0 then
			checkNumb = false
			exit function
		end if 
	next
end function 

'�����С��������
function getDianNumb(byVal content)
    dim i, s, c 
    c = "" 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if inStr("0123456789.", s) > 0 then
            c = c & s 
        end if 
    next 
    getDianNumb = c 
end function 

'�����ҳ��
function getCountPage(nCount, nPageSize)
    '�Ѹ���ת����ȷ���м���20150502
    dim nCountPage 
    if nCount < 0 then
        nCount = nCount * - 1 
    end if 
    if nPageSize < 0 then
        nPageSize = nPageSize * - 1 
    end if 
    nCountPage = fix(nCount / nPageSize) 
    if  nCount Mod nPageSize  > 0 then nCountPage = nCountPage + 1 
    getCountPage = nCountPage 
end function 

'��ô�����ҳ��
function getPageNumb(nRecordCount, nPageSize)
    dim n 
    n = int(nRecordCount / nPageSize) 
    if nRecordCount mod nPageSize > 0 then
        n = n + 1 
    end if 
    getPageNumb = n 
end function 

'������òɼ���ҳ��
function getCaiHandleCountPage(content)
    content = delHtml(content) 
    content = handleNumber(content) 
    getCaiHandleCountPage = "" 
    if len(content) < 10 then
        getCaiHandleCountPage = right(content, 1) 
    elseIf len(content) < 200 then
        getCaiHandleCountPage = right(content, 2) 
    end if 
end function 

'��òɼ�������ҳ�� 20150312
function getCaiSortCountPage(byVal content)
    dim i, s 
    getCaiSortCountPage = "" 
    content = delHtml(content) 
    content = handleNumber(content) 
    for i = 1 to 30
        s = mid(content, 1, len(i)) 
        if s = CStr(i) then
            getCaiSortCountPage = cstr(i) 
            'Call Echo(i,s)
            content = right(content, len(content) - len(i)) 
        end if 
    next 
end function 

'�������С֮�� Between the minimum and maximum
function minMaxBetween(nMin, nMax, nValue)
    'nMin = CInt(nMin)                                                         '��С��
    'nMax = CInt(nMax)                                                         '�����
    'nValue = CInt(nValue)                                                     '��ǰ��
	minMaxBetween = nMin
    if nMin > nMax then
        minMaxBetween = nMax 
    elseIf nValue > nMin then
        minMaxBetween = nValue 
        if nValue > nMax then
            minMaxBetween = nMax 
        end if 
    end if 
end function 

'��������ļ�����������  (��FSO�ļ����Ѿ������������20141220)
function getStrFileType(fileName)
    dim c 
    c = "" 
    if inStr(fileName, ".") > 0 then
        c = LCase(mid(fileName, inStrRev(fileName, ".") + 1)) 
        if inStr(c, "?") > 0 then
            c = mid(c, 1, inStr(c, "?") - 1) 
        end if 
    end if 
    getStrFileType = c 
end function 
 
'���ַ�����ת����������
function val(byVal s)
	val = cint(s) 
    if s = "" or not isNumeric(s) then
        val = 0  
    end if 
end function 

'�����ַ������N��byte
function strLen(str)
    on error resume next 
	strLen = 0 
    if isNull(str)<>false and str <> "" then
        dim i, n, nK, chrA  
        nK = 0 
        n = len(str) 
        for i = 1 to n


            chrA = mid(str, i, 1) 

            'If Asc(chrA) >= 0 And Asc(chrA) <= 255 Then
            'nK = nK + 1
            'Else
            'nK = nK + 2
            'End If

            if chrA < 0 then chrA = chrA + 65536 
            if chrA < 255 then nK = nK + 1 
            if chrA > 255 then nK = nK + 2 

        next 
        strLen = nK 
    end if 
end function 

'ѭ�������� AddIndent(Content,"    ")
function addIndent(content, indentStr)
    dim splStr, s, c 
    c = "" 
    splStr = split(content, vbCrLf) 
    for each s in splStr
        c = c & indentStr & s & vbCrLf 
    next 
    addIndent = trimVbCrlf(c) 
end function 

'�������ǰ�ַ� 2014 12 12(������Ϊ����ǿ�л��ֿ�����)
function getNumberBeforeStr(content)
    dim i, s, c 
    c = "" 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if inStr("0123456789", s) > 0 then exit for 
        c = c & s 
    next 
    getNumberBeforeStr = c 
end function 

'�������� 20141212
'�÷�response.write makePassword(6)
function makePassword(byVal nMaxLen)
    dim strNewPass ,n
    dim nWhatsNext, nUpper, nLower, nCounter 
    randomize 
    strNewPass = "" 
    for nCounter = 1 to nMaxLen
        nWhatsNext = int((1 - 0 + 1) * rnd + 0) 
        if nWhatsNext = 0 then 
            nUpper = 90 
            nLower = 65 
        else
            nUpper = 57 
            nLower = 48 
        end if 
		n=cint( (nUpper - nLower + 1) * rnd + nLower)
        strNewPass = strNewPass & chr(n)
    next 
    makePassword = strNewPass 
end function 

'����˵������������ַ�����������Сд��ĸ�����֣����������ϣ������ڸ����롣 20141212
'����˵����nMin--��������С���ȣ�ends--��������󳤶�
'�÷�'Response.Write rndCode(20, 330)
function rndCode(byVal nMin, byVal nMax)
    dim nRndLen, i 
    randomize 
    rndCode = "" 
    nRndLen = int(nMin * rnd + nMax - nMin) 
    for i = 1 to nRndLen
        randomize 
        rndCode = rndCode & chr(cint(127 * rnd + 1)) 
    next 
end function 

'�������ֻ����� ûʲô���壬���ñ��˵�  20141217
'��:CAll Rw(GetRandomPhoneNumber(41))
function getRandomPhoneNumber(nCount)
    dim s, rndnum, j, c ,n
    c = "" : rndnum = "" 
    j = 1 
    do while j < nCount
        randomize 
        do while len(rndnum) < 9                                                        '����������ĸ���
            n = cint((57 - 48) * rnd + 48)
            rndnum = rndnum & chr(n)
        loop 
        c = c & 13 & rndnum & vbCrLf 
        rndnum = "" 
        j = j + 1 
    loop 
    if c <> "" then c = left(c, len(c) - 2) 
    getRandomPhoneNumber = c 
end function 
 
'����ַ�����
function lenStr(content)
    dim l, t, c 
    c = "" 
    dim i 
    l = len(content)  
    t = 0 
    for i = 1 to l
        c = asc(mid(content, i, 1))  
        if c < 0 then c = c + 65536 
        if c < 255 then t = t + 1 
        if c > 255 then t = t + 2  
    next 
    lenStr = t 
end function 

'����ת�ַ���
function toString(byVal arr)
    dim tmp 
    if isArray(arr) then
        tmp = join(arr, ",")   
    end if 
	toString = tmp 
end function 
'�Ƴ�����(20151022)
function remoteNumber(content)
    dim i, s, c 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if inStr("0123456789.", s) = 0 then
            c = c & s 
        end if 
    next 
    remoteNumber = c 
end function 


'================================================= �ж��������ַ� start
'��������ָ���ַ�
function handleHaveStr(content, zd)
    dim s, i 
    handleHaveStr = false 
    for i = 1 to len(zd)
        s = mid(zd, i, 1) 
        if inStr(content, s) > 0 then
            handleHaveStr = true 
            exit function 
        end if 
    next 
end function 
'��Сд(20151224)
function haveLowerCase(content)
    haveLowerCase = handleHaveStr(content, "abcdefghijklmnopqrstuvwxyz") 
end function 
'�д�д(20151224)
function haveUpperCase(content)
    haveUpperCase = handleHaveStr(content, "ABCDEFGHIJKLMNOPQRSTUVWXYZ") 
end function 
'������(20151224)
function haveNumber(content)
    haveNumber = handleHaveStr(content, "0123456789") 
end function 
'�к���(20151224)
function haveChina(content)
    dim i, j 
    haveChina = false 
    for i = 1 to len(content)
        j = asc(mid(content, i, 1)) 
        '�Ǻ����ۼ�
        if j < 0 then
            if(j <= -22033 and j >= -24158) = false then
                haveChina = true 
                exit function 
            end if 
        end if 
    next 
end function 
'================================================= �ж��������ַ� end




'*************************************************
'��������EncodeJP
'��  �ã������ձ�Ƭ��������Access����ʧЧ��bug
'*************************************************
function encodeJP(str)
    if not str = "" then
        str = replace(str, "��", "&#12460;") 
        str = replace(str, "��", "&#12462;") 
        str = replace(str, "��", "&#12464;") 
        str = replace(str, "��", "&#12450;") 
        str = replace(str, "��", "&#12466;") 
        str = replace(str, "��", "&#12468;") 
        str = replace(str, "��", "&#12470;") 
        str = replace(str, "��", "&#12472;") 
        str = replace(str, "��", "&#12474;") 
        str = replace(str, "��", "&#12476;") 
        str = replace(str, "��", "&#12478;") 
        str = replace(str, "��", "&#12480;") 
        str = replace(str, "��", "&#12482;") 
        str = replace(str, "��", "&#12485;") 
        str = replace(str, "��", "&#12487;") 
        str = replace(str, "��", "&#12489;") 
        str = replace(str, "��", "&#12496;") 
        str = replace(str, "��", "&#12497;") 
        str = replace(str, "��", "&#12499;") 
        str = replace(str, "��", "&#12500;") 
        str = replace(str, "��", "&#12502;") 
        str = replace(str, "��", "&#12502;") 
        str = replace(str, "��", "&#12503;") 
        str = replace(str, "��", "&#12505;") 
        str = replace(str, "��", "&#12506;") 
        str = replace(str, "��", "&#12508;") 
        str = replace(str, "��", "&#12509;") 
        str = replace(str, "��", "&#12532;") 
    end if 
    encodeJP = str 
end function 
%>   
