if not exist "C:\ProgramData\Solutions POS\" (
    mkdir "C:\ProgramData\Solutions POS"
)
start /wait "POS Backup" robocopy "C:\Program Files (x86)\Solutions POS" "C:\ProgramData\Solutions POS\Backup" /E
