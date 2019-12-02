using namespace System.Net

param($Request, $TriggerMetadata)

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = (Get-Random @(" נ (Nun)"," ג (Gimmel)"," ה (Hay)"," ש (Shin)"))
})
