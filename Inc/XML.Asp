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
'XML Microsoft.XMLHTTP���������ȫ (2013,9,27)
'����Զ���ļ�  [����ʱ ������] Call SaveRemoteFile(RemoteFileUrl, LocalFileName)
function saveRemoteFile(byVal remoteFileurl, byVal localFileName)
    on error resume next 
    saveRemoteFile = 0 
    dim ads, xmlHttp, getRemoteData 
    call handlePath(localFileName)                                                  '�������·��
    set xmlHttp = createObject("Microsoft.XMLHTTP")
        with xmlHttp
            .open "Get", remoteFileurl, false, "", ""                                       'Flaseͬ��,True�첽
            .send 
            if err then
                saveRemoteFile = 9999 : exit function                         '[��ַ����]
            end if 
            getRemoteData =.responseBody 
            saveRemoteFile =.status 
        end with 
    set xmlHttp = nothing 
    set ads = createObject("ADODB.Stream")
        with ads
            .type = 1 
            .open 
            .write getRemoteData 
            'Response.Write("<br><b>["&LocalFileName&"]</b><br>")
            .saveToFile localFileName, 2 
            .cancel 
            .close 
        end with 
    set ads = nothing 
'If Err Then doError Err.Description, "SaveRemoteFile ����Զ���ļ� ����������RemoteFileUrl=" & remoteFileurl & "<hr>LocalFileName=" & localFileName
end function 


'����Զ���ļ� (����)
function downFile(remoteFileurl, localFileName)
    downFile = saveRemoteFile(remoteFileurl, localFileName) 
end function 


'�����ļ�����
function popupDownFile(path)
    dim OSM, SZ 
    call handlePath(path)                                                           '�������·��
    response.clear 
    set OSM = createObject("ADODB.Stream")
        OSM.open 
        OSM.type = 1 
        OSM.loadFromFile path 
        SZ = inStrRev(path, "\") + 1 
        response.addHeader "Content-Disposition", "attachment; filename=" & mid(path, SZ) 
        response.addHeader "Content-Length", OSM.size 
        response.charset = "UTF-8" 
        response.contentType = "application/octet-stream" 
        response.binaryWrite OSM.read 
        response.flush 
        response.write("") 
        OSM.close 
    set OSM = nothing 
end function 

'��xml�����ҳ״̬
function xmlGetStatus(byVal url)
    on error resume next 
    dim http 
    set http = createObject("Microsoft.XMLHTTP")
        with http
            .open "Get", url, false 
            .setRequestHeader "cache-control", "no-cache" 
            .setRequestHeader "Content-Type", "application/x-www-form-urlencoded" 
            .send 
            xmlGetStatus =.status 
        end with 
    set http = nothing 
    'responseBody�� �������Ϊ�޷����������顣
    'responseStream�� �������ΪIStream����
    'responseText �� �������Ϊ�ַ�����
'responseXML�� �������ΪXML��ʽ���ݡ�
end function 



'Post������Gb2312��ʽ
'��20150105 Call Echo(Url,xmlPost("http://127.0.0.1/5.asp", "title='"& escape("����"& vbCrlf &"1") & "'&content='����'&UpDateTime='ʱ��'"))
function xmlPost(url, postStr)
    xmlPost = handleXMLPost(url, postStr, "gb2312")(0) 
end function 


'Post������Utf-8��ʽ
function utfXMLPost(url, postStr)
    utfXMLPost = handleXMLPost(url, postStr, "utf-8")(0) 
end function 


'��xml����ҳ��������, ��������ˣ����(�� ��=%D7%C0) (������)
function handleXMLPost(byVal url, byVal postStr, sSetChar)
    dim http, dataArray(6), content 
    sSetChar = handleStrCharSet(sSetChar) 
    set http = createObject("Microsoft.XMLHTTP")
        call http.open("POST", url, false) 
        call http.setRequestHeader("cache-control", "no-cache") 
        call http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded") 
        call http.setRequestHeader("Connection", "close") 
        call http.setRequestHeader("Content-Length", len(postStr))                      '���Բ���Ҫ

        call http.send(postStr) 
        if http.readyState <> 4 then
            content = "error" 
        else
            content = bytesToBstr(http.responseBody, sSetChar) 
        'content = bytes2BSTR(Http.responseBody)    '���Ҫ�������Ǹ�����   ��ʱҲ������
        end if 
        dataArray(0) = content 
        dataArray(1) = http.status 
        dataArray(2) = http.responseBody                                                '�ֽ�
        handleXMLPost = dataArray 
    set http = nothing 
end function 


'��xml����ҳ��������, ��������ˣ����(�� ��=%D7%C0) (������)
function xmlGet(byVal url)
    xmlGet = handleXmlGet(url, "gb2312")(0) 
end function 


'����get�����������
function handleXmlGet(byVal url, sSetChar)
    'on error resume next
    dim http, dataArray(1), content 
    'call echo("sSetChar",sSetChar)
    sSetChar = handleStrCharSet(sSetChar) 
    set http = createObject("Microsoft.XMLHTTP")
        call http.open("Get", url, false) 
        call http.setRequestHeader("cache-control", "no-cache") 
        call http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded") 
        'Call http.SetRequestHeader("Cookie", "Admin%5FPassWord=admin; Admin%5FUserName=admin; CNZZDATA5865366=cnzz_eid%3D1338721452-1438760869-%26ntime%3D1438760869; style=default; sswbr=1; Hm_lvt_c39492dd0d3beab26d196a53cbd72d54=1440725802,1442725700; BD_UPN=112451; ASPSESSIONIDSCDQDRAC=CNOHMAHANIPHOFLHKCIKFIGH")
        call http.send 
        if http.readyState <> 4 then
            content = "error" 
        else
            'call eerr("sSetChar",sSetChar)
            content = bytesToBstr(http.responseBody, sSetChar) 
        'content = bytes2BSTR(Http.responseBody)        '���Ҫ�������Ǹ���������   ��ʱҲ������
        end if 
        dataArray(0) = content 
        dataArray(1) = http.status 
    set http = nothing 
    if err then
        dataArray(0) = "" 
        dataArray(1) = -1 
    end if 
    handleXmlGet = dataArray 
end function 


'Cookies�ύ (������)
function cookiesPost(postUrl, postCok)
    cookiesPost = handleCookiesPost(postUrl, postCok, "gb2312") 
end function 


'����Cookies�ύ
function handleCookiesPost(postUrl, postCok, sSetChar)
    dim http, dataArray(1), content 
    sSetChar = handleStrCharSet(sSetChar) 
    postCok = "ASPSESSIONIDAQACTAQB=HKFHJOPDOMAIKGMPGBJJDKLJ;" & postCok 
    set http = createObject("msxml2.serverXMLHTTP")
        call http.open("POST", postUrl, false) 
        '.SetRequestHeader "Content-Length", Len(PostStr)        '���Բ���Ҫ
        call http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded") 
        '.SetRequestHeader "Referer", PostRef
        call http.setRequestHeader("Cookie", postCok) 
        call http.send 
        if http.readyState <> 4 then
            content = "error" 
        else
            content = bytesToBstr(http.responseBody, sSetChar) 
        'content = bytes2BSTR(Http.responseBody)    '���Ҫ�������Ǹ���������   ��ʱҲ������
        end if 
        dataArray(0) = content 
        dataArray(1) = http.status 
    set http = nothing 
    handleCookiesPost = dataArray 
end function 


'���ܣ�ASP��ȡԶ���ļ���С   ������
'������url Զ���ļ���ַ
'���أ�Զ���ļ���С(��λ���ֽ�)
function getRemoteFileSize(url)
    dim xmlHttp 
    set xmlHttp = createObject("MSXML2.XMLHTTP")
        with xmlHttp
            .open "get", url, false 
            call.setRequestHeader("range", "bytes=-1") 
            .send 
            getRemoteFileSize = split(.getResponseHeader("Content-Range"), "/")(1) 
        end with 
    set xmlHttp = nothing 
end function 

'����Զ���ļ�
function downRemoteFile(path)
    dim OSM, SZ 
    call handlePath(path)                                                           '�������·��
    response.clear 
    set OSM = createObject("ADODB.Stream")
        with OSM
            .open 
            .type = 1 
            .loadFromFile path 
            SZ = inStrRev(path, "\") + 1 
            response.addHeader "Content-Disposition", "attachment; filename=" & mid(path, SZ) 
            response.addHeader "Content-Length",.size 
            response.charset = "UTF-8" 
            response.contentType = "application/octet-stream" 
            response.binaryWrite.read 
            response.flush 
            response.write("") 
            .close 
        end with 
    set OSM = nothing 
end function 


'ͼƬתBase64 20150722�������� call echo("images/error.gif",ImagesToBase64("images/error.gif"))
function imagesToBase64(fileName)
    dim xml 
    dim root 
    dim fs 
    dim filePath 
    dim objStream 
    dim objXMLDoc 
    dim base64 
    dim getFileExt 
    '����������
    '��������
    filePath = handlePath(fileName) 
    getFileExt = mid(filePath, inStrRev(filePath, ".") + 1) 
    set objXMLDoc = createObject("msxml2.FreeThreadedDOMDocument")
        '�趨����XML�ĵ��ĸ�Ϊ Base64Data
        call objXMLDoc.loadxml("<?xml version='1.0'?><Base64Data />") 
        set fs = createObject("Scripting.FileSystemObject")                             ''��������ҪFSO���
            if fs.fileExists(filePath) then                                                 '�ж�File�ļ��Ƿ����
                '�� stream ����ȡ����
                set objStream = createObject("ADODB.Stream")
                    objStream.type = 1 
                    objStream.open 
                    call objStream.loadFromFile(filePath) 


                    objXMLDoc.documentElement.dataType = "bin.base64" 
                    objXMLDoc.documentElement.nodeTypedValue = objStream.read 
                    '��������ȡ����.�õ���ֵ objXMLDoc
                    '����XML�ļ�
                    set xml = createObject("msxml2.FreeThreadedDOMDocument")
                        call xml.load(objXMLDoc) 
                        if xml.readyState > 2 then
                            set root = xml.getElementsByTagName("Base64Data")
                                'Base64="<img src=""data:image/"&getFileExt&";base64,"&vbcrlf&root.Item(0).Text&""">"
                                'Base64 = "data:image/" & getFileExt & ";base64," & vbCrLf & root.item(0).text
                                base64 = root.item(0).text 
                        else
                            base64 = "" 
                        end if 
                            set xml = nothing
                    set objStream = nothing
            else
                base64 = "" 
            end if 

                set fs = nothing
        set objXMLDoc = nothing


        imagesToBase64 = base64 
end function

'Base64תͼƬ 20150722 ��������   call Base64ToImages("1.jpg",Base64Data)
function base64ToImages(saveImagePath, base64Data)
    dim xmlStr 
    saveImagePath = handlePath(saveImagePath) 
    xmlStr = "<data>" & base64Data & "</data>" 
    dim xml : set xml = createObject("MSXML2.DOMDocument")
        dim stm : set stm = createObject("ADODB.Stream")
            xml.resolveExternals = false 
            call xml.loadxml(xmlStr) 
            call xml.documentElement.setAttribute("xmlns:dt", "urn:schemas-microsoft-com:datatypes") 
            xml.documentElement.dataType = "bin.base64" 
            stm.type = 1                                                                    'adTypeBinary
            stm.open 
            call stm.write(xml.documentElement.nodeTypedValue) 
            call stm.saveToFile(saveImagePath) 
            stm.close 
        set xml = nothing 
    set stm = nothing 
end function 

'SQLע�벿��

'���SQLע������
function getSqlInContent(httpurl, canShu, methodType, selectWebShowType)
    getSqlInContent = handleSqlIn(httpurl, canShu, methodType, selectWebShowType, "gb2312")(0) 
end function 


'�������SQLע����Ϣ �� call rwend( handleSqlIn("http://127.0.0.1/4.asp?", "&url=aaa3222333&url2=sss333333", "cookies", 1, "utf-8")(0) )
function handleSqlIn(httpurl, canShu, methodType, selectWebShowType, txtCharSet)
    dim content, dataArray                                                          '���(9)����Ҫ��Ҫ��Ȼ�ͻᱨ�������ܸ����鸳ֵ
    methodType = LCase(methodType) 
    'Post����  ���Ӽ���Ū
    if methodType = "post" then
        dataArray = handleXMLPost(httpurl, handlePostCookiesParame(canShu, "post"), txtCharSet) 
    'Get��������
    elseIf methodType = "get" then
        canShu = handlUrlCanShu(canShu)                                                 '��������
        dataArray = handleXmlGet(httpurl & canShu, txtCharSet) 

    'Cookies������
    elseIf methodType = "cookies" then
        dataArray = handleCookiesPost(httpurl, handlePostCookiesParame(canShu, "cookies"), txtCharSet) 

    end if 
    if CStr(selectWebShowType) = "0" then
        dataArray(0) = replace(dataArray(0), "<", "&lt;") 
    elseIf CStr(selectWebShowType) = "1" then
        dataArray(0) = replace(dataArray(0), "<br>", vbCrLf) 
        dataArray(0) = delHtml(dataArray(0)) 
    end if 
    handleSqlIn = dataArray 
end function 



'�ж��Ƿ����ע��
function sqlInUrl(byVal httpurl)
    dim xmlOject, isTrue1, isTrue2 
    sqlInUrl = false 
    isTrue1 = false : isTrue2 = false 
    set xmlOject = createObject("Microsoft.XMLHTTP")
        with xmlOject
            .open "GET", httpurl, false                                                     '����ҳ���Ƿ����
            .send 
            if xmlOject.status <> 200 then
                exit function 
            end if 
            call.open("GET", httpurl & " And 1=1", false)                                   '����ҳ���Ƿ����
            .send 
            isTrue1 =.status 

            call.open("GET", httpurl & " And 1=2", false)                                   '����ҳ���Ƿ����
            .send "" 
            isTrue2 =.status 
        end with 
    set xmlOject = nothing 
    if isTrue1 = 200 and isTrue2 = 500 then sqlInUrl = true 
end function 







'α��������ַ20150922  call rw(getWinHttp("http://127.0.0.1/4.asp","","Admin%5FPassWord=admin; Admin%5FUserName=admin; CNZZDATA5865366=cnzz_eid%3D1338721452-1438760869-%26ntime%3D1438760869; style=default; sswbr=1; Hm_lvt_c39492dd0d3beab26d196a53cbd72d54=1440725802,1442725700; BD_UPN=112451; ASPSESSIONIDSCDQDRAC=CNOHMAHANIPHOFLHKCIKFIGH",""))
function getWinHttp(httpurl, refererUrl, cookiesStr, postStr, sSetChar)
    dim winHttp, content 
    set winHttp = createObject("WinHttp.WinHttpRequest.5.1")
        with winHttp
            '��·��ַΪ�� ��Ϊ��ǰ��ַ����
            if refererUrl = "" then
                refererUrl = getwebsite(httpurl) 
            end if 
            '����cookies�ַ�������Ϊ��
            if cookiesStr = "" then
                cookiesStr = "ASPSESSIONIDAQACTAQB=HKFHJOPDOMAIKGMPGBJJDKLJ;" 
            end if 
            '�ַ����
            sSetChar = trim(sSetChar) 
            if sSetChar = "" or sSetChar = "1" or sSetChar = "gb2312" then
                sSetChar = "gb2312" 
            else
                sSetChar = "utf-8" 
            end if 

            '���ò���
            .setTimeOuts 60000, 60000, 60000, 3000                                          '���ò�����ʱʱ��
            '.SetTimeouts resolveTimeout, connectTimeout, sendTimeout, receiveTimeout
            'resolveTimeout = 10000 '���� DNS ���ֵĳ�ʱʱ�䣬10000 ���롣
            'connectTimeout = 10000 '���� Winsock ���ӵĳ�ʱʱ�䣬10000 ���롣
            'sendTimeout = 120000 '�������ݵĳ�ʱʱ�䣬120000 ���롣
            'receiveTimeout = 60000 '���� response �ĳ�ʱʱ�䣬60000 ���롣
            .option(4) = 13056                                                              '���Դ����־
            .option(6) = false                                                              'Ϊ True ʱ��������ҳ���ض�����תʱ�Զ���ת��False ���Զ���ת����ȡ����˷��ص�302״̬��
            '.Open "GET", "http://www.baidu.com/", False 'GET �� POST, Url, False ͬ����ʽ��True �첽��ʽ
            .open "GET", httpurl, false 
            '��� HTTP ͷ��Ϣ
            .setRequestHeader "Accept", "*/*"                                               '������������
            .setRequestHeader "Accept-Language", "zh-cn,zh"                                 '�û�ϵͳ����
            .setRequestHeader "User-Agent", "Mozilla/6.0"                                   '�û��������Ϣ
            .setRequestHeader "Content-Type", "application/x-www-form-urlencoded"           '���뷽ʽ
            .setRequestHeader "Referer", refererUrl                                         '��·
            .setRequestHeader "Connection", "Close"                                         'Close = ���������ӣ�Keep-Alive = ��������(�־�����)
            '.SetRequestHeader "Accept-Encoding", "gzip, deflate" '������ͣ��᷵�� gzip, deflate ѹ�����ı���
            '.SetRequestHeader "Content-Length", Len(Str) '���ݳ��ȣ�Post ��ʽ�õġ�
            .setRequestHeader "Cookie", cookiesStr                                          '���� Cookie   ֱ�Ӱ�cookies�ַ����Ž�ȥ�Ϳ����ˣ�  ��÷���:IE��F12������

            postStr = handlePostCookiesParame(postStr, "post") 

            '��������
            .send(postStr)                                                                  'Post ��ʽ��.Send (����)
            .waitForResponse                                                                '�ȴ���������XMLHTTP��Ҳ����ʹ��
            '������
            'Response.Write .Status '��ǰ HTTP ״̬
            'Response.Write .ResponseText '�ı�����
            content = bytesToBstr(.responseBody, sSetChar) 

        'Response.BinaryWrite .ResponseBody '����������������   �÷���
        end with 
        getWinHttp = content 
end function


%>      