$libPath = "E:\hugo\neirong\hugo\content\posts"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "         一键改文 - 文章库" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$files = @(Get-ChildItem -Path $libPath -Filter "*.md" -File | Sort-Object Name)
if ($files.Count -eq 0) {
    Write-Host "文章库为空：$libPath" -ForegroundColor Red
    exit
}
Write-Host "文章库（共 $($files.Count) 篇）：" -ForegroundColor Yellow
for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host ("  {0,2} | {1}" -f ($i + 1), $files[$i].Name)
}
Write-Host "   0 | 取消" -ForegroundColor Gray
Write-Host ""

$sel = Read-Host "选择要编辑的文章编号"
$num = 0
if (-not [int]::TryParse($sel, [ref]$num) -or $num -lt 0 -or $num -gt $files.Count) {
    Write-Host "无效编号，已取消。" -ForegroundColor Red
    exit
}
if ($num -eq 0) { Write-Host "已取消。" -ForegroundColor Red; exit }

$target = $files[$num - 1].FullName
Write-Host ""
Write-Host "打开：$($files[$num - 1].Name)" -ForegroundColor Green
Start-Process $target
