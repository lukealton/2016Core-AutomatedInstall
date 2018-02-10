#This script creates a new Hyper-V VM on the local machine

Import-Module Hyper-V

function New-Gen2VM ($NewVMName) {
    New-VM -Name $NewVMName -NewVHDPath "$NewVMName.vhdx" -NewVHDSizeBytes 20GB -Generation 2
}

function Add-DVDdriveandISO ($VMName,$ISOPath) {
    $VM = Get-VM -Name $VMName
    if (-Not($VM.DVDDrives)) {
        Add-VMDvdDrive -VMName $VMName -Path $ISOPath
    }
}

function Set-VMtoBootFromDVD ($VMName) {
    $DVDdrive = Get-VMDvdDrive -VMName $VMName
    Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDdrive
}
 