Add-Type -AssemblyName System.Windows.Forms

# Form nesnesi oluşturun
$form = New-Object Windows.Forms.Form
$form.Text = "Şifre Oluşturucu"
$form.Size = New-Object Drawing.Size(400, 200)

# Etiket ekleyin
$label = New-Object Windows.Forms.Label
$label.Text = "Şifre Uzunluğu:"
$label.Location = New-Object Drawing.Point(10, 20)
$form.Controls.Add($label)

# Şifre uzunluğu için bir metin kutusu ekleyin
$textBox = New-Object Windows.Forms.TextBox
$textBox.Location = New-Object Drawing.Point(150, 20)
$form.Controls.Add($textBox)

# Şifre özellikleri için onay kutuları ekleyin
$checkBoxUppercase = New-Object Windows.Forms.CheckBox
$checkBoxUppercase.Text = "Büyük Harf"
$checkBoxUppercase.Location = New-Object Drawing.Point(10, 50)
$form.Controls.Add($checkBoxUppercase)

$checkBoxLowercase = New-Object Windows.Forms.CheckBox
$checkBoxLowercase.Text = "Küçük Harf"
$checkBoxLowercase.Location = New-Object Drawing.Point(10, 80)
$form.Controls.Add($checkBoxLowercase)

$checkBoxNumbers = New-Object Windows.Forms.CheckBox
$checkBoxNumbers.Text = "Rakamlar"
$checkBoxNumbers.Location = New-Object Drawing.Point(10, 110)
$form.Controls.Add($checkBoxNumbers)

$checkBoxSpecial = New-Object Windows.Forms.CheckBox
$checkBoxSpecial.Text = "Özel Karakterler"
$checkBoxSpecial.Location = New-Object Drawing.Point(10, 140)
$form.Controls.Add($checkBoxSpecial)

# Şifre oluşturma düğmesi ekleyin
$buttonGenerate = New-Object Windows.Forms.Button
$buttonGenerate.Text = "Şifre Oluştur"
$buttonGenerate.Location = New-Object Drawing.Point(250, 50)
$buttonGenerate.Add_Click({
    $length = [int]$textBox.Text
    $includeUppercase = $checkBoxUppercase.Checked
    $includeLowercase = $checkBoxLowercase.Checked
    $includeNumbers = $checkBoxNumbers.Checked
    $includeSpecial = $checkBoxSpecial.Checked
    
    $password = Generate-RandomPassword -Length $length -IncludeUppercase $includeUppercase -IncludeLowercase $includeLowercase -IncludeNumbers $includeNumbers -IncludeSpecialCharacters $includeSpecial
    
    $textBoxResult.Text = $password  # Oluşturulan şifreyi metin kutusuna yaz
})
$form.Controls.Add($buttonGenerate)

# Şifre metin kutusu ekleyin
$textBoxResult = New-Object Windows.Forms.TextBox
$textBoxResult.Location = New-Object Drawing.Point(10, 170)
$textBoxResult.Size = New-Object Drawing.Size(350, 20)
$form.Controls.Add($textBoxResult)

# Kopyala düğmesi ekleyin
$buttonCopy = New-Object Windows.Forms.Button
$buttonCopy.Text = "Kopyala"
$buttonCopy.Location = New-Object Drawing.Point(365, 168)
$buttonCopy.Add_Click({
    $textBoxResult.SelectAll()  # Şifreyi seç
    [System.Windows.Forms.Clipboard]::SetText($textBoxResult.Text)  # Kopyala
})
$form.Controls.Add($buttonCopy)

# Betikteki şifre oluşturma işlevi
function Generate-RandomPassword {
    param (
        [int]$Length = 12,
        [bool]$IncludeUppercase = $true,
        [bool]$IncludeLowercase = $true,
        [bool]$IncludeNumbers = $true,
        [bool]$IncludeSpecialCharacters = $true
    )

    $CharacterSet = ""
    
    if ($IncludeUppercase) { $CharacterSet += "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    if ($IncludeLowercase) { $CharacterSet += "abcdefghijklmnopqrstuvwxyz" }
    if ($IncludeNumbers) { $CharacterSet += "0123456789" }
    if ($IncludeSpecialCharacters) { $CharacterSet += "!@#$%^&*()-_" }
    
    $Password = ""
    
    1..$Length | ForEach-Object {
        $RandomIndex = Get-Random -Minimum 0 -Maximum $CharacterSet.Length
        $Password += $CharacterSet[$RandomIndex]
    }
    
    return $Password
}

# Form'u gösterin
$form.ShowDialog()
