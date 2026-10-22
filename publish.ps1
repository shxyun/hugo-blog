$libPath  = "E:\hugo\neirong\hugo\content\posts"
$sitePath = "E:\hugo\blog"
$zhDir    = "E:\hugo\blog\content\zh\posts"
$enDir    = "E:\hugo\blog\content\en\posts"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "         一键发文 - blog 站" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 第一步：选文章
$files = @(Get-ChildItem -Path $libPath -Filter "*.md" -File | Sort-Object Name)
if ($files.Count -eq 0) {
    Write-Host "文章库为空：$libPath" -ForegroundColor Red
    exit
}
Write-Host "文章库（$libPath）：" -ForegroundColor Yellow
for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host ("  {0,2} | {1}" -f ($i + 1), $files[$i].Name)
}
Write-Host "   0 | 取消" -ForegroundColor Gray
Write-Host ""
$sel = Read-Host "选择要发的文章编号"
$num = 0
if (-not [int]::TryParse($sel, [ref]$num) -or $num -lt 0 -or $num -gt $files.Count) {
    Write-Host "无效编号，已取消。" -ForegroundColor Red
    exit
}
if ($num -eq 0) { Write-Host "已取消。" -ForegroundColor Red; exit }
$src = $files[$num - 1]

# 第二步：选语言
Write-Host ""
Write-Host "发布为哪种语言？" -ForegroundColor Yellow
Write-Host "  1 - 中文（进 zh/posts，网址带 /zh/）"
Write-Host "  2 - 英文（进 posts，根路径）"
Write-Host "  0 - 取消"
$langSel = Read-Host "请选择"
if ($langSel -eq "1") { $targetDir = $zhDir; $lang = "zh" }
elseif ($langSel -eq "2") { $targetDir = $enDir; $lang = "en" }
else { Write-Host "已取消。" -ForegroundColor Red; exit }

# 中文稿进 zh/posts 时去掉 .zh 后缀，否则 URL 会变成 /zh/zh/
$destName = if ($lang -eq "zh") { $src.Name -replace '\.zh\.md$', '.md' } else { $src.Name }
$targetFile = Join-Path $targetDir $destName

# 已存在则确认覆盖
if (Test-Path $targetFile) {
    Write-Host ""
    Write-Host "目标已存在：$($destName)" -ForegroundColor Yellow
    $ow = Read-Host "覆盖吗？(y/n)"
    if ($ow -ne "y" -and $ow -ne "Y") { Write-Host "已取消。" -ForegroundColor Red; exit }
}

# 第三步：复制并修正 front matter（date=现在, draft=false, language=对应语言）
$lines = [System.IO.File]::ReadAllLines($src.FullName, [System.Text.Encoding]::UTF8)
$now = Get-Date -Format "yyyy-MM-ddTHH:mm:ss+08:00"
# 识别 front matter 格式：首行是 +++ 为 TOML，--- 为 YAML
$delim = if ($lines[0].Trim() -eq "+++") { "+++" } else { "---" }
$isToml = ($delim -eq "+++")
if ($isToml) {
    $dateLine = "date = $now"; $draftLine = "draft = false"; $langLine = "language = `"$lang`""
    $pDate = "^date\s*="; $pDraft = "^draft\s*="; $pLang = "^language\s*="
} else {
    $dateLine = "date: $now"; $draftLine = "draft: false"; $langLine = "language: $lang"
    $pDate = "^date\s*:"; $pDraft = "^draft\s*:"; $pLang = "^language\s*:"
}
$inFm = $false; $hasLang = $false; $out = New-Object System.Collections.Generic.List[string]
foreach ($line in $lines) {
    $t = $line.Trim()
    if ($t -eq $delim) {
        if (-not $inFm) { $inFm = $true; $out.Add($line); continue }
        else {
            if (-not $hasLang) { $out.Add($langLine) }
            $inFm = $false; $out.Add($line); continue
        }
    }
    if ($inFm) {
        if ($t -match $pDate)  { $out.Add($dateLine); continue }
        if ($t -match $pDraft) { $out.Add($draftLine); continue }
        if ($t -match $pLang)  { $out.Add($langLine); $hasLang = $true; continue }
    }
    $out.Add($line)
}
[System.IO.File]::WriteAllLines($targetFile, $out, (New-Object System.Text.UTF8Encoding($false)))
Write-Host ""
Write-Host "已复制到：$targetFile" -ForegroundColor Green
Write-Host "（date 已更新为当前时间，draft=false，language=$lang）" -ForegroundColor Gray

# 第四步：提交推送
Write-Host ""
$defaultMsg = "发布文章 $($destName -replace '\.md$','') [$lang]"
$msg = Read-Host "提交信息（直接回车用：$defaultMsg）"
if ([string]::IsNullOrWhiteSpace($msg)) { $msg = $defaultMsg }

Push-Location $sitePath
git add .
git commit -m $msg 2>&1 | ForEach-Object { Write-Host $_ }
if ($LASTEXITCODE -eq 0) {
    git push 2>&1 | ForEach-Object { Write-Host $_ }
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "推送完成！Cloudflare 会自动重建上线。" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "提交成功，但推送失败（可能是网络问题）。网络恢复后手动执行：git -C $sitePath push" -ForegroundColor Yellow
    }
} else {
    Write-Host "无改动可提交。" -ForegroundColor Yellow
}
Pop-Location

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "               发文结束" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
