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
sub setApp(appName, appData)
    application.lock 
    application.contents.item(appName) = appData 
    application.unlock 
end sub 
function getApp(appName)
    if appName = "" then getApp = "" : exit function 
    getApp = application.contents.item(appName) 
end function 
sub removeApp(appName)
    application.lock 
    application.contents.remove(appName) 
    application.unlock 
end sub 


'����cookie(20151120)
function setCookie(cookieName, cookieValue, nAddMinutes)
    response.cookies(cookieName) = cookieValue 
    response.cookies(cookieName).expires =dateAdd("s",nAddMinutes, now())	'now + 0.00001*nAddMinutes    '�Ӷ�����
end function 
'���cookieֵ
function getCookie(byVal cookieName)
    getCookie = request.cookies(cookieName) 
end function 
'�Ƴ�cookie
function removeCookie(byVal cookieName)
    response.cookies(cookieName) = empty 
    response.cookies(cookieName).expires = now() 
end function 
'���cookie
function clearCookie(byVal cookieName)
    removeCookie(cookieName) 
end function 
'���cookie
function deleteCookie(byVal cookieName)
    removeCookie(cookieName) 
end function 
 
 
'session
'����Session
sub setSession(sessionName,sessionValue)
	Session(sessionName)=sessionValue
end sub
'���Session
function getSession(sessionName)
	getSession=Session(sessionName)
end function
'ɾ��Session
sub deleteSession(sessionName)
	Session(sessionName)=""
end sub
%> 
  