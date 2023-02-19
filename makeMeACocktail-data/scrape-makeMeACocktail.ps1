#init File
$filePath = "D:\GitHub\DrinkBot\"
$fileName = "drinkData$(Get-Date -Format 'yy-MM-dd-hh-mm-ss').json"
New-Item -Path $filePath -Name $fileName

"[" | Out-File -FilePath "$($filePath)$($fileName)"

$result1 = Invoke-WebRequest -Uri 'https://makemeacocktail.com/recipes/s/?' -SessionVariable sess

$items = 20
$totalItems = 3272
for ($page = 1; $items * $page -lt $totalItems; $page++) {
Write-Progress -Id 0 -Status "Page $page" -PercentComplete ((($items * $page) / $totalItems) * 100) -Activity 'Looping pages'
    $Form = @{
        ajaxurl = 'scripts/ajaxcalls.php?ajaxcall=updateResults'
        scid = 14358565
        numPerPage = $items
        sortBy = 'c_score'
        pageNum = $page
        haveToHaveAll = @()
        mixersArr = @()
        haveToHaveOne = @("attr_gid_1","attr_gid_2","attr_gid_3","attr_gid_4","attr_gid_5","attr_gid_6","attr_gid_7","attr_gid_9","attr_gid_12","attr_gid_13","attr_gid_23","attr_gid_32")
        showMixers = ''
        module = 'recipe_results'
    }

    $result2 = Invoke-WebRequest -Uri 'https://makemeacocktail.com/scripts/ajaxcalls.php?ajaxcall=updateResults' -WebSession $sess -Method Post -Body $Form

    $links = $result2.Links | where {$_.href -Like "cocktail/*"}
    for ($i = 0; $i -lt $links.Count; $i = $i + 2) {
    Write-Progress -Id 1 -Status "scraping $($links[$i].href)" -PercentComplete ((($i) / $links.Count) * 100) -Activity 'Looping links'
        $cocktailPage = Invoke-RestMethod -Uri "https://makemeacocktail.com/$($links[$i].href)" -WebSession $sess
        $cocktailPage | select-string -Pattern '(?<=<script type=\"application\/ld\+json\">)(.|\n)*?(?=<\/script>)' | foreach {$_.Matches.value} | out-file -FilePath "$($filePath)$($fileName)" -Append
        "," | Out-File -FilePath "$($filePath)$($fileName)" -Append
    }    
} 

#finalze file

"]" | Out-File -FilePath "$($filePath)$($fileName)" -Append