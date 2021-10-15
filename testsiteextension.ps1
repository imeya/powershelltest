#we can get the username and password from azure portal -> function app -> deployment center -> FTPS Credential -> Application scope
$username = "`$xxxx"
$password = "xxx"

# Note that the $username here should look like `SomeUserName`, and **not** `SomeSite\SomeUserName`
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $password)))
$userAgent = "powershell/1.0"

$body = @{
    command='dir "D:\Program Files (x86)\SiteExtensions\Functions"'
} | ConvertTo-Json


$apiUrl = "https://function_app_name.scm.azurewebsites.net/api/command"

$s = Invoke-RestMethod -Uri $apiUrl `
    -Headers @{ 'Authorization' = "Basic $base64AuthInfo"} `
    -Body $body `
    -Method Post `
    -UserAgent 'powershell/1.0' `
    -ContentType 'application/json'

#it will print out the results
$s.Output





























