<%
'************************************************************
'作者：红尘云孙(SXY) 【精通ASP/PHP/ASP.NET/VB/JS/Android/Flash，交流/合作可联系)
'版权：源代码免费公开，各种用途均可使用。 
'创建：2016-09-22
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered by PAAJCMS 
'************************************************************
%>
<%
'获得编辑器内容
Function getEditorStr(inputName,sType)
    Dim C
    C = "<script charset=""utf-8"" src=""Keditor/kindeditor.js""></"&"script> " & vbCrlf
    C = C & "<script charset=""utf-8"" src=""Keditor/lang/zh_CN.js""></"&"script>  " & vbCrlf
    C = C & "<script language=""javascript"">" & vbCrlf
    C = C & "KindEditor.ready(function(K) {" & vbCrlf
    C = C & "	var editor1 = K.create('textarea[name="""& inputName &"""]', {		//处理让文本域" & vbCrlf
    C = C & "		cssPath : 'Keditor/plugins/code/prettify.css'," & vbCrlf
    C = C & "		uploadJson : 'Keditor/"& sType &"/upload_json."& sType &"'," & vbCrlf
    C = C & "		fileManagerJson : 'Keditor/"& sType &"/file_manager_json."& sType &"'," & vbCrlf
    C = C & "		allowFileManager : true," & vbCrlf
    C = C & "		afterCreate : function() {" & vbCrlf
    C = C & "			var self = this;" & vbCrlf
    C = C & "			K.ctrl(document, 13, function() {" & vbCrlf
    C = C & "				self.sync();" & vbCrlf
    C = C & "				K('form[name=example]')[0].submit();" & vbCrlf
    C = C & "			});" & vbCrlf
    C = C & "			K.ctrl(self.edit.doc, 13, function() {" & vbCrlf
    C = C & "				self.sync();" & vbCrlf
    C = C & "				K('form[name=example]')[0].submit();" & vbCrlf
    C = C & "			});" & vbCrlf
    C = C & "		}" & vbCrlf
    C = C & "	});" & vbCrlf
    C = C & "	//prettyPrint();				//因为这个出错，所以给它注释掉 2013,12,12" & vbCrlf
    C = C & "});" & vbCrlf
    C = C & "</"&"script>" & vbCrlf

    getEditorStr = C
End Function
'上传文件面板
function displayUploadDialog(returnInputName,sType)
	displayUploadDialog=""
	if sType="asp" then
		displayUploadDialog="<iframe style='top:2px' src='"& adminDir &"upload_Photo.asp?PhotoUrlID=1&returnInputName="& returnInputName &"' frameborder=0 scrolling='No' width=340 height=25></iframe>"
	elseif sType="php" then
		displayUploadDialog="<iframe style='top:2px' src='upfile.php?returnInputName="& returnInputName &"' frameborder=0 scrolling='No' width=340 height=25></iframe>"
	end if
end function
%>