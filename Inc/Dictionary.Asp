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
'Dictionary �ֵ� (2013,9,27)

'��ʼ
dim aspD, aspHelpTitle, aspHelpContent 
set aspD = createObject("Scripting.Dictionary")
aspD.add "Abs", "�������ֵľ���ֵ" 
aspD.add "Sqr", "������ֵ����ʽ��ƽ����" 
aspD.add "Sgn", "���ر�ʾ���ַ��ŵ�����" 
aspD.add "Rnd", "����һ��������ɵ�����" 
aspD.add "Log", "����ָ����ֵ����Ȼ����" 
aspD.add "Exp", "����e��ָ������" 
aspD.add "Sin", "����ָ�����ȵ�����ֵ" 
aspD.add "Cos", "����ָ�����ȵ�����ֵ" 
aspD.add "Tan", "����ָ�����ȵ�����ֵ" 
aspD.add "Atn", "����ָ����ֵ�ķ�����ֵ" 
aspD.add "Int", "����ָ�����ֵ���������" 
aspD.add "Round", "�Բ�����ָ����λ��������������" 
aspD.add "Fix", "����ָ����ֵ����������" 
aspD.add "Now", "���ص�ǰ������ʱ��" 
aspD.add "Date", "���ص�ǰ��ϵͳ����" 
aspD.add "Time", "���ص�ǰ��ϵͳʱ��" 
aspD.add "Year", "��ָ���ı���ʽ����ȡ���" 
aspD.add "Month", "��ָ���ı���ʽ����ȡ�·�" 
aspD.add "Day", "��ָ������ʽ����ȡ����" 
aspD.add "Hour", "��ָ���ı���ʽ����ȡ����ֵ" 
aspD.add "Minute", "��ָ���ı���ʽ����ȡ������" 
aspD.add "Second", "��ָ���ı���ʽ����ȡ����" 
aspD.add "DateAdd", "��ָ������������ָ��ʱ������������ֵ" 
aspD.add "DateDiff", "������������֮���ʱ����" 
aspD.add "DatePart", "���ظ��������е�ĳһ����" 
aspD.add "DateSerial", "�����ṩ�������յ���ֵ����һ��Date�����͵�����" 
aspD.add "DateValue", "��ָ�����ַ���ת��ΪDate�����͵�����" 
aspD.add "MonthName", "����ָ�������ַ��ش������·ݵ��ַ���" 
aspD.add "Weekday", "���ش���һ����ĳһ�������" 
aspD.add "WeekdayName", "�����ܴη��ش������ܴε��ַ���" 
aspD.add "TimeSerial", "�����ṩ��ʱ�������ֵ����һ��Date�����͵�����" 
aspD.add "TimeValue", "��ָ�����ַ���ת��ΪDate�����͵�����" 
aspD.add "CBool", "������ʽת��ΪBoolean������" 
aspD.add "CByte", "������ʽת��ΪByte������" 
aspD.add "CDbl", "������ʽת��ΪDouble������" 
aspD.add "Chr", "��ANSI�ַ����루����ת��Ϊ��Ӧ���ַ�" 
aspD.add "CInt", "������ʽת��ΪInteger��ֵ������" 
aspD.add "CLng", "������ʽת��ΪLong��ֵ������" 
aspD.add "Cstr", "������ʽת��ΪString������" 
aspD.add "CCur", "������ʽת��ΪCurrency������" 
aspD.add "CDate", "�����ڱ���ʽת��ΪDate������" 
aspD.add "CSng", "������ʽת��ΪSingle��ֵ������" 
aspD.add "Asc", "�������ַ�������ĸ���Ӧ��ANSI�ַ����루����" 
aspD.add "Oct", "���ذ˽��Ƶ��ַ���" 
aspD.add "Hex", "����ʮ�����Ƶ��ַ���" 
aspD.add "FormatNumber", "��ʽ��ָ������ֵ����ʽ" 
aspD.add "FormatDateTime", "��ʽ��ָ��������ʱ�����ʽ" 
aspD.add "FormatCurrency", "��ʽ��ָ���Ļ��ұ���ʽ" 
aspD.add "FormatPercent", "��ʽ��ĳһ��ֵΪ�ٷ���" 
aspD.add "IsArray", "�ж�ĳһ�����Ƿ�Ϊ�������" 
aspD.add "IsDate", "�ж�ĳһ�����Ƿ�Ϊ���߿���ת��Ϊ���ڱ���ʽ" 
aspD.add "IsEmpty", "�жϱ����Ƿ�Ϊ��" 
aspD.add "IsNull", "�жϱ���ʽ���Ƿ������Ч����" 
aspD.add "IsNumeric", "�жϱ���ʽ��ֵ�Ƿ�Ϊ����" 
aspD.add "Is_object_", "�жϱ���ʽ��ֵ�Ƿ�Ϊĳһ����" 
aspD.add "VarType", "����ָ��������������" 
aspD.add "TypeName", "����ָ�����������͵���Ϣ" 
aspD.add "MsgBox", "����������ʾ��Ϣ�ĶԻ���" 
aspD.add "InputBox", "�������������ݵĶԻ���" 
aspD.add "ScriptEngine", "����һ��������ǰ��ʹ�õĽű����Ե��ַ���" 
aspD.add "ScriptEngineBuildVersion", "������ʹ�õĽű�����ı���汾��" 
aspD.add "ScriptEngineMajorVersion", "������ʹ�õĽű���������汾��" 
aspD.add "ScriptEngineMinorVersion", "������ʹ�ýű�����Ĵΰ汾��" 
aspD.add "Array", "���������Ĳ�������һ������" 
aspD.add "UBound", "����������������±�" 
aspD.add "LBound", "�����������С�����±�" 
aspD.add "Filter", "����һ���������а����������������ַ���" 
aspD.add "InStr", "����ĳ�ַ�����ָ���ַ����е�һ�γ��ֵ�λ��" 
aspD.add "InStrRev", "����ĳ�ַ�����ָ���ַ����дӽ�β����ĳ���λ��" 
aspD.add "Join", "�������е��ַ�������Ϊһ���ַ���" 
aspD.add "LCase", "���ַ����е���ĸȫ��ת��ΪСд��ʽ" 
aspD.add "Left", "���ַ��������ȡָ����Ŀ���ַ�" 
aspD.add "Len", "�����ַ����ĳ��Ȼ��ߴ洢ĳһ��������Ҫ���ֽ���" 
aspD.add "Ltrim", "���ز���ǰ���ո���ַ���" 
aspD.add "Replace", "���ַ�����ָ���ַ����滻Ϊ��������" 
aspD.add "Right", "���ַ������Ҳ��ȡָ����Ŀ���ַ�" 
aspD.add "Rtrim", "ɾ���ַ����ĺ����ո�" 
aspD.add "Mid", "���ַ�����ָ��λ�û�ȡָ�����ȵ��ַ���" 
aspD.add "Split", "���ذ���ָ����Ŀ���ַ�����һά����" 
aspD.add "StrComp", "������ָ�����ַ������бȽ�" 
aspD.add "StrReverse", "��ָ���ַ����������в������������к���ַ���" 
aspD.add "String", "������ָ����Ŀ��ĳһ�ַ���ɵ��ַ���" 
aspD.add "Trim", "ɾ���ַ�����ǰ���ͺ����ո�" 
aspD.add "Space", "������ָ����Ŀ�Ŀո���ɵ��ַ���" 
aspD.add "UCase", "���ַ����е���ĸȫ��ת��Ϊ��д��ʽ" 
aspD.add "LoadPicture", "����һ��ͼƬ����" 
aspD.add "Create_object_", "����������һ������" 
aspD.add "Get_object_", "��ָ���ļ��л��һ��Automation����" 
aspD.add "RGB", "���ش���ĳһ��ɫ������" 
aspHelpTitle = aspD.keys 
aspHelpContent = aspD.items 
'���ASP���ú�������˵��
function ASPHelpTip(byVal funName, byVal content)
	dim i, s, c 
	for i = 0 to aspD.count - 1
		if LCase(aspHelpTitle(i)) = LCase(funName) then
			if LCase(funName) = "chr" then
				s = left(content, inStr(content, ")") - 1) 
				s = replace(s, "(", "") 
				c = vbCrLf & "Chr(" & s & ")=" 
				if checkNumber(s) = true then                  '�ж�Chr �����Ƿ�Ϊ����
					if s = "10" or s = "13" then
						c = c & "(�س���)" 
					elseIf s = "32" then
						c = c & "(�ո�)" 
					elseIf s = "0" then
						c = c & "(�жϳ���,ִֹͣ��)" 
					else
						c = c & "(" & chr(s) & ")" 
					end if 
					c = replace(c, "'", "&#x27;") 
				else
					c = c & s 
				end if 
			end if 
			ASPHelpTip = aspHelpContent(i) & c 
			exit for 
		end if 
	next 
end function 
'�����û������ֵ
function handleWrite(jc)
	dim s 
	s = left(jc, len(jc) - 1) 
	s = right(s, len(s) - 1) 
	s = LCase(trim(s)) 
	if s = "adodb.connection" then
		jc = """Adodb.Connection""" 
	elseIf s = "adodb.recordset" then
		jc = """Adodb.RecordSet""" 
	end if 
	handleWrite = jc 
end function 
'����
'�����뷱��ת�� �÷� JianTiTabFanTi("�հڰܰ���������",2)2Ϊ����
function jianTiTabFanTi(path, content, sType)
	dim jianStr, fanStr, jianS, fanS, i, s, c 
	c = getFText(path) & vbCrLf 
	sType = cstr(sType)                             '�ַ�����
	jianStr = strCut(c, "����" & vbCrLf, vbCrLf, 2) 
	fanStr = strCut(c, "����" & vbCrLf, vbCrLf, 2) 
	if 1 = 2 then
		if len(content) * 2 < len(jianStr) then
			for i = 1 to len(content)
				s = mid(content, i, 1) 
				'����ת����
				if sType = "2" and inStr(jianStr, s) > 0 then
					jianS = mid(jianStr, inStr(jianStr, s), 1) 
					fanS = mid(fanStr, inStr(jianStr, s), 1) 
					content = replace(content, jianS, fanS) 
					call echo("", "") 
				elseIf inStr(fanStr, s) > 0 then
					jianS = mid(jianStr, inStr(fanStr, s), 1) 
					fanS = mid(fanStr, inStr(fanStr, s), 1) 
					content = replace(content, fanS, jianS) 
				end if 
			next 
			jianTiTabFanTi = content 
			exit function 
		end if 
	end if 
	for i = 1 to len(jianStr)
		jianS = mid(jianStr, i, 1) 
		fanS = mid(fanStr, i, 1) 
		'����ת����
		if sType = "2" then
			content = replace(content, jianS, fanS) 
		else
			content = replace(content, fanS, jianS) 
		end if 
	next 
	jianTiTabFanTi = content 
end function 
'������滻
function jiYiCiReplace(path, content)
	dim splStr, splxx, i, s, c 
	splStr = split(getFText(path), vbCrLf) 
	for each s in splStr
		if inStr(s, ",") and left(trim(s), 1) <> "#" then
			splxx = split(s, ",") 
			if uBound(splxx) >= 1 then
				content = replace(content, splxx(0), splxx(1)) 
			end if 
		end if 
	next 
	jiYiCiReplace = content 
end function 
'�滻�ַ�
function ciReplace(THContent, content)
	dim splStr, splxx, i, s, c 
	splStr = split(THContent, vbCrLf) 
	for each s in splStr
		if inStr(s, ",") and left(trim(s), 1) <> "#" then
			splxx = split(s, ",") 
			if uBound(splxx) >= 1 then
				content = replace(content, splxx(0), splxx(1)) 
			end if 
		end if 
	next 
	ciReplace = content 
end function 

%>  
