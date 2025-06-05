#Xaikar Audio Selection Menu

# Requires the AudioDeviceCmdlets module
# Install-Module -Name AudioDeviceCmdlets

#Add MENU for the GUI
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#Pull the Current Index for Astro A50X Voice and Mic and USB Speakers
#A50X Voice
$A50Xindex = Get-AudioDevice -List | Where-Object { $_.ID -eq "{0.0.0.00000000}.{cc921ae7-4a53-4fe1-8170-ed624b48aa38}"} | Select-Object -ExpandProperty Index
#A50X Mic Input
$MicInput =  Get-AudioDevice -List | Where-Object { $_.ID -eq "{0.0.1.00000000}.{e211aac6-d79f-444b-aef5-fea14a502d9c}"} | Select-Object -ExpandProperty Index
#USB Speakers
$USBSpeakers = Get-AudioDevice -List | Where-Object { $_.ID -eq "{0.0.0.00000000}.{502a8404-a854-4c13-a723-e11eae5346f4}"} | Select-Object -ExpandProperty Index

#Create Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Xaikar Audio Select"
$form.StartPosition = 'CenterScreen'
$form.Size = New-Object System.Drawing.Size(250, 150) #Sets the total size
$form.FormBorderStyle = 'FixedSingle'
$form.MaximizeBox = $false
$form.MinimizeBox = $false

#Set Background
$form.BackColor = [System.Drawing.Color]::DarkGray

#Label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select Audio Output Device"
$label.Location = New-Object System.Drawing.Point(10, 10)
$label.AutoSize = $true
$form.Controls.Add($label)

#Setup button for A50X
$buttonA50x = New-Object System.Windows.Forms.Button
$buttonA50x.Text = "A50 X Voice"
$buttonA50x.Location = New-Object System.Drawing.Point(10, 40)
$buttonA50x.Size = New-Object System.Drawing.Size(100, 30)
$buttonA50x.Add_Click({Set-AudioDevice -Index $A50Xindex; Set-AudioDevice -Index $MicInput})
$form.Controls.Add($buttonA50x)

#Setup button for Speakers
$buttonSpeakers = New-Object System.Windows.Forms.Button
$buttonSpeakers.Text = "Speakers"
$buttonSpeakers.Location = New-Object System.Drawing.Point(120, 40)
$buttonSpeakers.Size = New-Object System.Drawing.Size(100, 30)
$buttonSpeakers.Add_Click({Set-AudioDevice -Index $USBSpeakers; Set-AudioDevice -Index $MicInput})
$form.Controls.Add($buttonSpeakers)


$form.ShowDialog()