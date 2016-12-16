Sub TOTEXT_交叉引用_图题()
' 如 "图4.31" 所示
    Dim a As Field
    For Each a In ActiveDocument.Fields
        If a.Type = wdFieldRef Then
           a.Unlink ' 取消链接, 3 wdFieldRef 是交叉引用
        End If
    Next
End Sub

Sub TOTEXT_交叉引用_Page()
' 如 "图4.31" 所示
    Dim a As Field
    For Each a In ActiveDocument.Fields
        If a.Type = wdFieldPageRef Then
           a.Unlink
        End If
    Next
End Sub



Sub TOTEXT_题注()
' 图4.12 插入新类
' 将数字"12"转换为文本
' 为什么这里使用这种方法？而不调用Unlink？因为Unlink无法取消这种类型的域的链接
    Dim a As Field
    For Each a In ActiveDocument.Fields
        If a.Type = wdFieldSequence Then  'Seq(序列)域。
           'a.Unlink ' 取消链接, 3 wdFieldRef 是交叉引用
           tempText = a.Result
           a.Select
           Selection.Delete
           Selection.TypeText text:=tempText
        End If
    Next
End Sub


Sub TOTEXT_AUTONUM()
'
' <代码 06     代码位置：光盘\Code\04\Bits\06.txt>
' 06.txt/'6' => 文本型的

'    Dim a As Field
'    For Each a In ActiveDocument.Fields
'        If a.Type = wdFieldAutoNum Then
'           a.Unlink
'        End If
'    Next

' 上面那样不行，这个要倒着遍历，因为前面的数字变了，后面的就会自动减一
    Dim i As Integer
    With ActiveDocument
    For i = .Fields.Count To 1 Step -1
      With .Fields(i)
        If .Type = wdFieldAutoNum Or .Type = wdFieldListNum Then
           .Unlink
        End If
      End With
    Next
    End With
End Sub


Sub 自动编号转文本()
    If Selection.Type = wdSelectionIP Then
        ActiveDocument.Content.ListFormat.ConvertNumbersToText
        'ActiveDocument.Content.Find.Execute FindText:="^t", replacewith:=" ", Replace:=wdReplaceAll
    Else
        Selection.Range.ListFormat.ConvertNumbersToText
        Selection.Find.Execute FindText:="^t", replacewith:=" ", Replace:=wdReplaceAll
    End If
End Sub

