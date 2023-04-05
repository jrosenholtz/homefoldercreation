$Userlist = Get-ADuser -filter * | Select-Object -expandProperty samaccountname
$rights = 'FullControl'
$inheritance = 'ContainerInherit, ObjectInherit'
$propagation = 'None' 
$type = 'Allow'
foreach($user in $Userlist){
    $dir = '\\PATH TO HOME FOLDER DIR' + $user
    if(test-path $dir){
        write-host $dir 'exists!'
        }
        else
        {
        New-Item -ItemType Directory -Path $dir -whatif
        $ACE = New-Object System.Security.AccessControl.FileSystemAccessRule($user,$rights,$inheritance,$propagation, $type)
        $Acl = Get-Acl -Path $dir
        $Acl.AddAccessRule($ACE)
        Set-Acl -Path $dir -AclObject $Acl
        } 
}
