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
'���ݴ���������


'dim rsDataArray(99,2),s,c,i,j,k
'call handleDataArray(rsDataArray,"add","asp","asp��active server pages")
'call handleDataArray(rsDataArray,"add","asp","asp��active server pages")
'call handleDataArray(rsDataArray,"add","asp","asp��active server pages")
'call handleDataArray(rsDataArray,"del","asp","asp��active server pages")
'call handleDataArray(rsDataArray,"edit","asp","eeeeeeeeeee")
'call handleDataArray(rsDataArray,"��ӡ","","")
'������ά���� �����ݿ����� 20160727 
function handleDataArray(arrayData, byval sAction, fieldName, fieldValue) 
    dim title, content, i 
    sAction = lcase(sAction) 
    for i = 0 to uBound(arrayData)
        title = arrayData(i, 0) 
        content = arrayData(i, 1) 
        if sAction = "��ӡ" or sAction = "print" then
            call echo(i & "��" & title, content) 
        elseif title <> "" then
            if(sAction = "�޸�" or sAction = "edit") and title = fieldName then
                arrayData(i, 0) = fieldName 
                arrayData(i, 1) = fieldValue 
                exit for 
            elseif(sAction = "ɾ��" or sAction = "del") and title = fieldName then
                arrayData(i, 0) = "" 
                arrayData(i, 1) = "" 
                exit for 
            elseif(sAction = "���" or sAction = "get") and title = fieldName then
                handleDataArray = content 
                exit function 
            end if 
        elseif sAction = "����" or sAction = "add" then
            arrayData(i, 0) = fieldName 
            arrayData(i, 1) = fieldValue 
            exit for 
        end if 
    next 
end function 

'������������
function contentNameSort(content, sType)
    dim splStr, arrayStr(99), fileName, isOther, otherStr, sid, nIndex, c, s, i, left1 
    splStr = split(content, vbCrLf) 
    for each s in splStr
        if s <> "" then
            fileName = getStrFileName(s) 
            isOther = true 
            left1 = left(fileName, 1) 
            if inStr(fileName, "��") > 0 then
                sid = replace(left(fileName, 2), "��", "") 
                if isNumber(sid) then
                    nIndex = cint(sid) 
                    arrayStr(nIndex) = arrayStr(nIndex) & s & vbCrLf 
                    isOther = false 
                end if 
            end if 

            if inStr(sType, left1) = 0 and isOther = true then
                otherStr = otherStr & s & vbCrLf 
            end if 
        end if 
    next 
    for i = 0 to uBound(arrayStr)
        c = c & arrayStr(i) 
    next 
    contentNameSort = c & otherStr 
end function 


'ɾ��������#���б�(20150818)
function remoteContentJingHao(content, sSplType)
    dim splStr, s, c 
    splStr = split(content, sSplType) 
    for each s in splStr
        if left(phpTrim(s), 1) <> "#" and left(phpTrim(s), 1) <> "_" then
            if c <> "" then c = c & sSplType 
            c = c & s 
        end if 
    next 
    remoteContentJingHao = c 
end function 
'ɾ��������#�Ż����_���б�(20150818)
function remoteArrayJingHao(splStr)
    dim s, c, sSplType 
    sSplType = "[|-|_]" 
    for each s in splStr
        if left(phpTrim(s), 1) <> "#" and left(phpTrim(s), 1) <> "_" then
            if c <> "" then c = c & sSplType 
            c = c & s 
        end if 
    next 
    splStr = split(c, sSplType) 
    remoteArrayJingHao = splStr 
end function 

'ÿ���ַ���ָ��ֵ
function getEachStrAddValue(content, valueStr)
    dim i, s, c 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        c = c & s & valueStr 
    next 
    getEachStrAddValue = c 
end function 
'���ֵ��������λ�� 20150708
function getValueInArrayID(splStr, valueStr)
    dim i 
    getValueInArrayID = -1 
    for i = 0 to uBound(splStr)
        if splStr(i) = valueStr then
            getValueInArrayID = i 
            exit for 
        end if 
    next 
end function 
'�ж�ֵ�Ƿ���������
function checkValueInArray(splStr, valueStr)
    dim i 
    checkValueInArray = false 
    for i = 0 to uBound(splStr)
        if splStr(i) = valueStr then
            checkValueInArray = true 
            exit for 
        end if 
    next 
end function 

'ɾ���ظ�����  20141220
function deleteRepeatArray(splStr)
    dim sSplType, s, c 
    sSplType = "[|-|_]" 
    for each s in splStr
        if s <> "" then
            if inStr(sSplType & c & sSplType, sSplType & s & sSplType) = 0 then
                c = c & s & sSplType 
            end if 
        end if 
    next 
    if c <> "" then c = left(c, len(c) - len(sSplType)) 
    splStr = split(c, sSplType) 
    deleteRepeatArray = splStr 
end function 
'ɾ���ظ����� �Զ��ָ����� 20150724
function deleteRepeatContent(content, sSplType)
    dim splStr, s, c 
    splStr = split(content, sSplType) 
    for each s in splStr
        if s <> "" then
            if inStr(sSplType & c & sSplType, sSplType & s & sSplType) = 0 then
                if c <> "" then c = c & sSplType 
                c = c & s 
            end if 
        end if 
    next 
    deleteRepeatContent = c 
end function 

'�����������
function getArrayCount(content, sSpl)
    dim splStr 
    getArrayCount = 0 
    if inStr(content, sSpl) > 0 then
        splStr = split(content, sSpl) 
        getArrayCount = uBound(splStr) + 1 
    end if 
end function 
'�����ʾ���� randomShow("1,2,3,4,5,6,7,8,9", ",", 2)
function randomShow(content, sSplType, nSwitch)
    dim splStr, s, c, n, i 
    randomize 
    for i = 1 to nSwitch
        splStr = split(content, sSplType) 
        for each s in splStr
            n = cInt(rnd * 100) 
            if n > 50 then
                c = c & s & sSplType 
            else
                c = s & sSplType & c 
            end if 
        next 
        if c <> "" then c = left(c, len(c) - len(sSplType)) 
        content = c 
        c = "" 
    next 
    'Call Echo("C",C)
    randomShow = content 
end function 
'���������ʾ ArrayRandomShow("1,2,3,4,5,6,7,8,9", 2)
function arrayRandomShow(byVal splStr, nSwitch)
    dim s, c, n, i, sSplType 
    sSplType = "[|-|_]" 
    randomize 
    for i = 1 to nSwitch
        for each s in splStr
            n = cInt(rnd * 100) 
            if n > 50 then
                c = c & s & sSplType 
            else
                c = s & sSplType & c 
            end if 
        'Call Echo(S,N)
        next 
        if c <> "" then c = left(c, len(c) - len(sSplType)) 
        splStr = split(c, sSplType) : c = "" 
    next 
    arrayRandomShow = splStr 
end function 
'��ӡ��������
sub printArray(splStr)
    dim i, s 
    for i = 0 to uBound(splStr)
        s = splStr(i) 
        call echo(i, s) 
    next 
end sub 
'��ʾ��������  (��������)
sub echoArray(splStr)
    call PrintArray(splStr) 
end sub 
'���ش��Һ���ַ�����Shuffle=ϴ��  2014 12 02
function str_Shuffle(content)
    dim i, s, c, n 
    randomize 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        if c = "" then
            c = s 
        elseIf len(c) = 1 then
            n = cInt(rnd * 100) 
            if n > 50 then
                c = c & s 
            else
                c = s & c 
            end if 
        else
            n = cInt(rnd * len(c)) + 1 
            c = mid(c, 1, n) & s & mid(c, n + 1) 
        end if 
    next 
    str_Shuffle = c 
end function 
'�ַ�����
function characterUpset(content)
    characterUpset = str_Shuffle(content) 
end function 
'���ַ���ת��Ϊ����   PHP���õ�����ʱ����   �������뼸���ַ��ָ������  ��  abcefg,2     0=ab 1=ce 2=fg
function str_Split(content, nSplitLength)
    dim i, s, c, n, arrStr(99), nArr 
    if nSplitLength <= 0 then nSplitLength = 1 
    n = 0 : nArr = 0 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        c = c & s 
        n = n + 1 
        if n = nSplitLength then
            arrStr(nArr) = c 
            c = "" : n = 0 
            nArr = nArr + 1 
        end if 
    next 
    str_Split = arrStr 
end function 
'�Ƴ���ֵ����
function removeNullValueArray(content, sSplType)
    removeNullValueArray = handleArray(content, sSplType, "nonull") 
end function 
'�Ƴ��ظ�����
function removeRepeatValueArray(content, sSplType)
    removeRepeatValueArray = handleArray(content, sSplType, "norepeat") 
end function 
'��������
function handleArray(content, sSplType, sType)
    dim splStr, s, c, isTrue 
    sType = "|" & lCase(sType) & "|" 
    splStr = split(content, sSplType) 
    for each s in splStr
        isTrue = true 
        if inStr(sType, "|nonull|") > 0 and isTrue = true then
            if s = "" then isTrue = false 
        end if 
        if inStr(sType, "|norepeat|") > 0 and isTrue = true then
            if inStr(sSplType & c & sSplType, sSplType & s & sSplType) > 0 then isTrue = false 
        end if 
        if isTrue = true then c = c & s & sSplType 
    next 
    if c <> "" then c = left(c, len(c) - len(sSplType)) 
    handleArray = c 
end function  
'����ת�ַ�(20151124)
function arrayToString(splStr, addtoStr)
    dim s, c  
    for each s in splStr
        if s <> "" then    
            c = c & s & addtoStr 
        end if 
    next  
    arrayToString = c  
end function 
'������������ 20141217
sub testArrayData()
    dim nArrayData 
    nArrayData = array(3, 2, 4, 1, 6, 0) 
    call responseArray(nArrayData, "ԭ��˳��") 
    call responseArray(nArraySelectSort(nArrayData), "ѡ������") 
    call responseArray(nArrayQuickSort(nArrayData), "��������") 
    call responseArray(nArrayInsertSort(nArrayData), "��������") 
    call responseArray(nArrayBubbleSort(nArrayData), "ð������") 
    call responseArray(nArrayReQuickSort(nArrayData), "��������") 
    response.write("<b>�� �� ֵ��</b>" & nGetMaxArray(nArrayData) & "<hr>") 
    response.write("<b>�� С ֵ��</b>" & nGetMinArray(nArrayData) & "<hr>") 
end sub 
'===================================
'�������
'===================================
sub responseArray(nArrayData, str)
    dim s, i 
    s = "" 
    response.write("<b>" & str & "��</b>") 
    for i = 0 to uBound(nArrayData)
        s = s & nArrayData(i) & "," 
    next 
    s = left(s, len(s) - 1) 
    response.write(s) 
    response.write("<hr>") 
end sub
'===================================
'ѡ������
'===================================
function nArraySelectSort(nArrayData)
    dim i, j, nK 
    dim nBound, nTemp 
    nBound = uBound(nArrayData) 

    for i = 0 to nBound - 1
        nK = i 
        for j = i + 1 to nBound
            if nArrayData(nK) > nArrayData(j) then
                nK = j 
            end if 
        next 
        nTemp = nArrayData(i) 
        nArrayData(i) = nArrayData(nK) 
        nArrayData(nK) = nTemp
    next 
    nArraySelectSort = nArrayData 
end function 
'===================================
'��������
'===================================
function nArrayQuickSort(nArrayData)
    dim i, j 
    dim nBound, nTemp 
    nBound = uBound(nArrayData) 
    for i = 0 to nBound - 1
        for j = i + 1 to nBound
            if nArrayData(i) > nArrayData(j) then
                nTemp = nArrayData(i) 
                nArrayData(i) = nArrayData(j) 
                nArrayData(j) = nTemp
            end if 
        next 
    next 
    nArrayQuickSort = nArrayData 
end function 
'===================================
'ð������
'===================================
function nArrayBubbleSort(nArrayData)
    dim nBound 
    nBound = uBound(nArrayData) 
    dim isSorted, i,j, nTemp
    isSorted = false 
'    do while nBound > 0 and isSorted = false		��������
	for j=1 to 9999	
        isSorted = true 
        for i = 0 to nBound - 1
            if nArrayData(i) > nArrayData(i + 1) then
                nTemp = nArrayData(i) 
                nArrayData(i) = nArrayData(i + 1) 
                nArrayData(i + 1) = nTemp
                isSorted = false 
            end if 
        next 
        nBound = nBound - 1 
		if isSorted=false then 
			exit for
		end if
    next

    nArrayBubbleSort = nArrayData 
end function 
'===================================
'��������
'===================================
function nArrayInsertSort(nArrayData)
    dim nBound 
    nBound = uBound(nArrayData) 
    dim i, j, nT,nTemp

    for i = 1 to nBound
        nTemp = nArrayData(i) 
        j = i 
        do while nT < nArrayData(j - 1) and j > 0
            nArrayData(j) = nArrayData(j - 1) 
            j = j - 1  
        loop 
        nArrayData(j) = nTemp
    next 
    nArrayInsertSort = nArrayData 
end function 
'===================================
'��������-��������
'===================================
function nArrayReQuickSort(nArrayData)
    dim i, nBound, nArrayTemp 
    nArrayData = nArrayQuickSort(nArrayData) 
    nArrayTemp = nArrayQuickSort(nArrayData) 
    nBound = uBound(nArrayData) 
    for i = 0 to nBound
        nArrayData(i) = nArrayTemp(nBound - i) 
    next 
    nArrayReQuickSort = nArrayData 
end function 
'���鷴��
function nArrayReverse(nArrayData)
    nArrayReverse = nArrayReQuickSort(nArrayData) 
end function 
 
'===================================
'���������ֵ
'=================================== 
function nGetMaxArray(nArrayData)
    dim i, j, nBound, nTemp 
    nArrayData = nArrayQuickSort(nArrayData) 
    nBound = uBound(nArrayData) 
    for i = 0 to nBound 
        for j = i + 1 to nBound
            if nArrayData(j) > nArrayData(i) then
                nTemp = nArrayData(i) 
                nArrayData(i) = nArrayData(j) 
                nArrayData(j) = nTemp 
            end if 
        next 
    next 
    nGetMaxArray = nArrayData(0) 
end function 
'===================================
'��������Сֵ
'===================================
function nGetMinArray(nArrayData)
    dim i, j, nBound, nTemp  
    nArrayData = nArrayQuickSort(nArrayData) 
    nBound = uBound(nArrayData) 
    for i = 0 to nBound
        for j = i + 1 to nBound
            if nArrayData(j) > nArrayData(i) then
                nTemp  = nArrayData(i) 
                nArrayData(i) = nArrayData(j) 
                nArrayData(j) = nTemp  
            end if 
        next 
    next 
    nGetMinArray = nArrayData(nBound) 
end function 


 
'��ɾ��.netc start��

'���Զ�ά������ʾ
function testTwoDimensionalArray()
    dim splStr, i 
    splStr = handleSplitArray("9-g|2-b|3-a|1-��", "|", "-") 
    for i = 0 to uBound(splStr)
        call echo(splStr(i, 1), splStr(i, 0)) : doevents 
    next 
    call echo("", "�����") 
    call TwoDimensionalArrayAsc(splStr)                                            '��ά����������
    for i = 0 to uBound(splStr)
        call echo(splStr(i, 1), splStr(i, 0)) : doevents 
    next 
    call echo("", "Desc") 
    call TwoDimensionalArrayDesc(splStr)                                           '��ά���鵹����
    for i = 0 to uBound(splStr)
        call echo(splStr(i, 1), splStr(i, 0)) : doevents 
    next 
end function 

'�����ָ��ά���� 20150313
function handleSplitArray(content, splOneType, splTowType)
    dim splA, splB, splStr, splxx, i, s, c, j, t, sSplType 
    sSplType = "[|Array|]" 
    splStr = split(content, splOneType) 
    for i = 0 to uBound(splStr)
        if splStr(i) <> "" then
            splxx = split(splStr(i), splTowType) 
            splA = splA & splxx(0) & sSplType 
            splB = splB & splxx(1) & sSplType 
        end if 
    next 
    if splA <> "" then splA = left(splA, len(splA) - len(sSplType)) 
    if splB <> "" then splB = left(splB, len(splB) - len(sSplType)) 
    splA = split(splA, sSplType) 
    splB = split(splB, sSplType) 

    reDim splStr(uBound(splA), uBound(splB)) 
    for i = 0 to uBound(splA)
        splStr(i, 0) = splA(i) 
        splStr(i, 1) = splB(i) 
    next 
    handleSplitArray = splStr 
end function 
'��ά���������� 20150313
function twoDimensionalArrayAsc(splStr)
    dim i, j, t 
    for i = 0 to uBound(splStr)
        if isNul(splStr(i, 0)) = false then
            for j = i to uBound(splStr)
                if splStr(i, 0) > splStr(j, 0) then
                    t = splStr(i, 0) 
                    splStr(i, 0) = splStr(j, 0) 
                    splStr(j, 0) = t 
                    t = splStr(i, 1) 
                    splStr(i, 1) = splStr(j, 1) 
                    splStr(j, 1) = t 
                end if 
            next 
        end if 
    next 
    twoDimensionalArrayAsc = splStr 
end function 
'��ά���鵹���� 20150313
function twoDimensionalArrayDesc(splStr)
    dim i, j, t 
    for i = 0 to uBound(splStr)
        if isNul(splStr(i, 0)) = false then
            for j = i to uBound(splStr)
                if splStr(i, 0) < splStr(j, 0) then
                    t = splStr(i, 0) 
                    splStr(i, 0) = splStr(j, 0) 
                    splStr(j, 0) = t 
                    t = splStr(i, 1) 
                    splStr(i, 1) = splStr(j, 1) 
                    splStr(j, 1) = t 
                end if 
            next 
        end if 
    next 
    twoDimensionalArrayDesc = splStr 
end function 
'��ɾ��.netc end��
%>   

