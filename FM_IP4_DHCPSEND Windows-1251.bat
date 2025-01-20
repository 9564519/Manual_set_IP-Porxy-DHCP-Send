@echo off >nul
chcp 1251
rem mode con: cols=84 lines=34
@echo EN Setting the encoding
@echo RU Установка кодировки по умолчанию 1251
@echo DOS=866 UTF-8=65001 Windows-1251=1251
setlocal enabledelayedexpansion
:start0
set /P code="Enter 866/65001/1251 (RU можно ничего не вводить):"
@echo ------------------------------------------------------------------
if %errorlevel% equ 1 >nul (
	goto :next_setup0
) else if "!code!"=="866" (
    goto :next_setup1
) else if "!code!"=="65001" (
    goto :next_setup1
) else if "!code!"=="1251" (
    goto :next_setup1
) else (
    @echo Некорректное значение!
	@echo введите одно из 866/65001/1251
	@echo RU можно ничего не вводить
    goto :start0
)
:next_setup0
@echo Установлен код 1251 по умолчанию.
goto :next_setup2
:next_setup1
chcp !code!
@echo Установлен код %code%.
@echo ENTER chcp=%code%.
Pause
@echo ------------------------------------------------------------------
@echo RU Если с кириллицей всё ОК то введите "1"
@echo ------------------------------------------------------------------
@echo TR Esli c kirillicoj vse OK to enter "1"
@echo ------------------------------------------------------------------
pause >nul
set /P gonext1="1:"
if %errorlevel% equ 1 >nul (
	goto :start0
) else if "!gonext1!"=="1" (
goto :next_setup2
) else (
    @echo Некорректное значение!
	goto :start0
	)
:next_setup2
color 04
cls rem --------------------------- очистка -----------------------------
>nul 2>&1 "%SYSTEMROOT%\System32\cacls.exe" "%SYSTEMROOT%\System32\config\system"
if '%errorlevel%' NEQ '0' (
set "trig_error2=1"
@echo RU
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^!Выполнение происходит без доступа к изменению параметров сети^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^! дальнейшее выполнение не выполнит изменения параметров сети ^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^!Если необходимо внести изменение, то запуск от администратора^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo EN
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^!Execution occurs without access to changing network parameters^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^!   Further execution will not change the network parameters   ^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^!   If you need to make a change, then run as administrator    ^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
pause
cls rem --------------------------- очистка -----------------------------
goto :next_setup3
) else ( 
@echo Выполнение происходит с доступом ADM ^^!^^!^^!
pause
goto :next_setup3
)
:next_setup3
color 07
cls rem --------------------------- очистка -----------------------------
color 06
@echo текущий NETSH INTERFACE ip show subinterfaces
@echo Изменения будут происходить именно для "Ethernet"
netsh interface ip show subinterfaces 
@echo ^^!^^!^^! Если название "Ethernet" то продолжаем ^^!^^!^^! 
@echo ^^!^^!^^! Если "Ethernet" отсутствует, то прервать выполнение ^^!^^!^^!
pause
cls rem --------------------------- очистка -----------------------------
rem Выполнение query user и сохранение результата для использования дальше
rem Далее выполняется мера по определению текущего юзера, если юзер не единственный
REM Создать временный файл
set "tempFile_query_output=c:\temp\query_output.txt"
REM Выполнить команду query user и записать вывод во временный файл, а потом в переменную начиная с символа ^>
query user > "%tempFile_query_output%"
set "filename_USER=%tempFile_query_output%"
set "lineStart=>"
for /f "delims=" %%i in ('findstr /b "%lineStart%" "%filename_USER%"') do (
    set "line=%%i"
    set "line=!line:*%lineStart%=!"
    for /f "tokens=1" %%j in ("!line!") do set "loginuser=%%j"
)
del "%tempFile_query_output%"
color 06
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^!^^!^^!        Тут должен быть указан логин       ^^!^^!^^!
@echo ^^!^^!^^!              %loginuser%
@echo ^^!^^!^^!пользователя для которого меняем настройки ^^!^^!^^!
@echo ^^!^^!^^! Если нет, то прерываем выполнение скрипта ^^!^^!^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
pause
color 07
cls rem --------------------------- очистка -----------------------------

for /f "skip=1 tokens=1" %%S in ('wmic useraccount where name^='%loginuser%' get sid') do (
    set "reg_uid=%%S"
goto :next0
)
:next0
:: Проверяем, что reg_uid установлена правильно
:: echo reg_uid должен быть: %reg_uid%
@echo --- Текущий ipconfig IPv4 ---
chcp 866 >nul
ipconfig | findstr /i "IPv4"
chcp 1251 >nul
@echo ---- проверяем ping целевого ip ----
@echo можно ничего не вводить если не нужно проверять
set prov_podIP=
set /p prov_podIP="Enter pod_ip (192.168.pod_ip.2-254):"
IF "%prov_podIP%"=="" ( goto :next_setup4
) else (
set /p prov_IP="Enter P_IP (192.168.1-42.P_IP):"
)
ping -n 2 192.168.%prov_podIP%.%prov_IP% -w 1
pause
:next_setup4
cls rem --------------------------- очистка -----------------------------
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo Устанавливаем параметры для сетевого протокола
@echo --- Текущий ipconfig IPv4+DHCP ---
chcp 866 >nul
ipconfig /all | findstr /i "IPv4 DHCP"
chcp 1251 >nul 
color 06
:input_DHCP1
echo Определите параметр DHCP
set /p "tiggDHCP=Enter DHCP [1]=on [0]=off:"
if "%tiggDHCP%"=="0" (
echo Вы выбрали "off".
) else if "%tiggDHCP%"=="1" (
echo Вы выбрали "on".
goto :setup_DHCP
) else (
    echo Неправильное значение! Пожалуйста, введите только "0" или "1".
    goto :input_DHCP1
)
pause





cls rem --------------------------- очистка -----------------------------

@echo --- Текущий ipconfig IPv4+DHCP ---
chcp 866 >nul
ipconfig /all | findstr /i "IPv4 DHCP"
chcp 1251 >nul
:reg_query
@reg query "HKEY_USERS\%reg_uid%\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable
if %errorlevel% NEQ 0 >nul (
set "trig_error1=1"
goto :ERROr1
) else (
    goto :test_next1
)
:ERROr1
color 06
@echo Произошла ошибка^^!
@echo Переключение прокси не доступно^^!
@echo ^^!Изменения для прокси не будет выполнено^^!
Pause
color 07
:test_next1
@echo Текущее положение PROXY
@echo Если ProxyEnable REG_DWORD = 0x1 [PROXY  on]
@echo Если ProxyEnable REG_DWORD = 0x0 [PROXY off]
if "%trig_error1%"=="1" >nul (
@echo Доступ к переключению использования прокси отсутствует^^!
@echo Введение переменной предложено для ознакомления^^!
)
:input_proxy
set /P proxy="Enter PROXY [0]=[off] / [1]=[on]:"
if "!proxy!"=="0" (
    echo Вы выбрали PROXY "off".
	set proxy_stat=off
) else if "!proxy!"=="1" (
    echo Вы выбрали PROXY "on".
	set proxy_stat=on
) else ( 
    echo Неправильное значение! Введите только "0" или "1".
    goto :input_proxy
)
pause
cls rem --------------------------- очистка -----------------------------
color 07


:setup_DHCP
cls rem --------------------------- очистка -----------------------------
if "%trig_error2%"=="1" (goto :trig_DHCP_error2_1) else (goto :trig_DHCP_error2_0)
:trig_DHCP_error2_1
color 04
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^!Выполнение происходит без доступа к изменению параметров сети^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
)
:trig_DHCP_error2_0
if "%tiggDHCP%"=="1" (
echo --------------------------------------------------------
echo --------------------------------------------------------
echo --- Текущий ipconfig IPv4+DHCP ---
chcp 866 >nul
ipconfig /all | findstr /i "IPv4 DHCP"
chcp 1251 >nul 
echo --------------------------------------------------------
echo      После нажатия далее, будет изменён IP на DHCP
echo              Для пользователя %loginuser%
echo           Прокси в любом случае включается
echo                 консоль будет закрыта
echo          Открытые соединения будут разорваны
echo --------------------------------------------------------
echo --------------------------------------------------------
pause && reg add "HKEY_USERS\%reg_uid%\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f|netsh interface ipv4 set dnsservers "Ethernet" static 192.168.1.105|netsh interface ipv4 add dnsservers "Ethernet" address=192.168.25.200 index=2|netsh interface ip set address name="Ethernet" dhcp|ipconfig /registerdns



REM Ожидание 5 секунд, для корректного получения DHCP
for /l %%i in (1,-1,1) do (
    cls
    powershell -Command "$width = [Console]::WindowWidth; $height = [Console]::WindowHeight; $x = ($width - (\"Осталось %%i секунд до отправки...\".Length)) / 2; $y = ($height/2); [Console]::SetCursorPosition([int]$x, [int]$y); echo \"Осталось %%i секунд до отправки...\""
    timeout /t 1 > nul
)
cls
:: Получаем имя компьютера
set "computerName=%COMPUTERNAME%"

:: Получаем текущую дату и время в формате YYYYMMDDHHMMSS
for /f "skip=1 tokens=1" %%a in ('wmic os get localdatetime') do (
    set "datetime=%%a"
    goto :dateDone
)
:dateDone
set "currentDate=%datetime:~0,4%_%datetime:~4,2%_%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%"

:: Формируем полное имя файла
set "fileName_TXT=C:\temp\ipconfig_%computerName%_%currentDate%.txt"

:: Проверяем, что переменная fileName_TXT установлена правильно
echo Полное имя файла: %fileName_TXT%

:: Выполняем команду и сохраняем вывод в файл
ipconfig /all > "%fileName_TXT%"
:: Копируем файл на удалённый ПК
set "destination=\\KAR-ADMENGIN\C$\Temp\"
copy "%fileName_TXT%" "%destination%"

if %errorlevel%==0 (
    echo Файл успешно скопирован в: %destination%
) else (
    echo Ошибка при копировании файла.
)

REM endlocal
echo Текущие данные IPv4:
chcp 866 >nul
ipconfig | findstr /i "IPv4"
chcp 1251 >nul
echo --
echo - Далее, при нажатии, программа будет закрыта -
echo --
pause
exit

)
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!

@echo Устанавливаем параметры для сетевого протокола
:next_setup5
@echo --- Текущий ipconfig IPv4 ---
chcp 866 >nul
ipconfig | findstr /i "IPv4"
chcp 1251 >nul 
@echo --- Необходимо определить переменные для ip ---
set pod_ip=
@echo Вводим третий октет (подсеть) от 0 до 254
set /p pod_ip="Enter _pod_ip_ (192.168._pod_ip_.2-254):"
@echo --- Вы ввели подсеть .%pod_ip%. ---
IF "%pod_ip%"=="" ( echo Вы не ввели _pod_ip_
goto :next_setup5 )
set /a "valid_range=0"
if %pod_ip% geq 0 if %pod_ip% leq 254 set /a "valid_range=1"
if %valid_range% equ 0 (
	echo ОШИБКА^^! Введите число от 0 до 254.
	echo ERROR^^! Enter a number between 0 and 254.
	pause
	goto :next_setup5
)

:next_setup6
@echo --- Текущий ipconfig IPv4 ---
chcp 866 >nul
ipconfig | findstr /i "IPv4"
chcp 1251 >nul 
@echo --- Необходимо определить переменные для ip ---
set P_IP=
@echo Вводим четвертый октет (хост/ip) от 2 до 254
set /p P_IP="Enter _IP_ (192.168.%pod_ip%._IP_):"
@echo --- Вы ввели ip .%P_IP% ---
IF "%P_IP%"=="" ( echo Вы не ввели _IP_
goto :next_setup6 )
set /a "valid_range=0"
if %P_IP% geq 2 if %P_IP% leq 254 set /a "valid_range=1"
if %valid_range% equ 0 (
	echo ОШИБКА^^! Введите число от 2 до 254.
	echo ERROR^^! Enter a number between 2 and 254.
	pause
	goto :next_setup6
)
cls rem --------------------------- очистка -----------------------------
if "%trig_error2%"=="1" (goto :trig_ip_error2_1) else (goto :trig_ip_error2_0)
:trig_ip_error2_1
color 04
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
@echo ^^!Выполнение происходит без доступа к изменению параметров сети^^!
@echo ^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!^^!
)
:trig_ip_error2_0

@echo --------------------------------------------------------
@echo --------------------------------------------------------
@echo --- Текущий ipconfig IPv4+DHCP ---
chcp 866 >nul
ipconfig /all | findstr /i "IPv4 DHCP"
chcp 1251 >nul 
@echo --------------------------------------------------------
@echo        После нажатия далее, будет изменён IP: 
@echo                 IP = 192.168.%pod_ip%.%P_IP%
@echo               Шлюз = 192.168.%pod_ip%.1
@echo              Прокси: [%proxy_stat%]
@echo                консоль будет закрыта
@echo          Удалённые соединения будут разорваны
@echo --------------------------------------------------------
@echo --------------------------------------------------------
pause
reg add "HKEY_USERS\%reg_uid%\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d %proxy% /f|netsh interface ipv4 set dnsservers "Ethernet" static 192.168.1.105|netsh interface ipv4 add dnsservers "Ethernet" address=192.168.25.200 index=2|netsh interface ip set address name="Ethernet" static 192.168.%pod_ip%.%P_IP% 255.255.255.0 192.168.%pod_ip%.1|ipconfig /registerdns
chcp 866 >nul
@echo --------------------------------------------------------
@echo --- Текущий ipconfig IPv4+DHCP ---
@echo --------------------------------------------------------
ipconfig /all | findstr /i "IPv4 DHCP"
pause
chcp 1251 >nul
Exit