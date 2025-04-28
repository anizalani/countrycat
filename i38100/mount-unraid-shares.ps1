# Mount SMB shares from Unraid to i38100 (Windows 11)

$SMBServer = "unraid"   # <-- Unraid Tailscale IP
$Username = "windows11" # <-- SMB username
$Password = "Czech1701!" # <-- SMB password

$shares = @(
    @{ DriveLetter = "Z"; Path = "\\$SMBServer\3dprinting" },
    @{ DriveLetter = "A"; Path = "\\$SMBServer\aniz" },
    @{ DriveLetter = "X"; Path = "\\$SMBServer\appdatabackup" },
    @{ DriveLetter = "B"; Path = "\\$SMBServer\backup" },
    @{ DriveLetter = "Y"; Path = "\\$SMBServer\books" },
    @{ DriveLetter = "V"; Path = "\\$SMBServer\downloads" },
    @{ DriveLetter = "F"; Path = "\\$SMBServer\flynn" },
    @{ DriveLetter = "G"; Path = "\\$SMBServer\guacamole" },
    @{ DriveLetter = "U"; Path = "\\$SMBServer\incomplete" },
    @{ DriveLetter = "I"; Path = "\\$SMBServer\isla" },
    @{ DriveLetter = "W"; Path = "\\$SMBServer\MacBook Pro Time Machine" },
    @{ DriveLetter = "M"; Path = "\\$SMBServer\media" },
    @{ DriveLetter = "R"; Path = "\\$SMBServer\movies" },
    @{ DriveLetter = "L"; Path = "\\$SMBServer\music" },
    @{ DriveLetter = "P"; Path = "\\$SMBServer\nextcloud" },
    @{ DriveLetter = "N"; Path = "\\$SMBServer\nicole" },
    @{ DriveLetter = "S"; Path = "\\$SMBServer\steam" },
    @{ DriveLetter = "T"; Path = "\\$SMBServer\tv" },
    @{ DriveLetter = "E"; Path = "\\$SMBServer\tv4k" }
)


)

foreach ($share in $shares) {
    New-PSDrive -Name $share.DriveLetter -PSProvider FileSystem -Root $share.Path -Persist -Credential (New-Object System.Management.Automation.PSCredential($Username, (ConvertTo-SecureString $Password -AsPlainText -Force)))
}
