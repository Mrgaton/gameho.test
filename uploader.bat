@echo off
setlocal enabledelayedexpansion

:: Initialize counter
set count=0

:: Loop through each file in the directory
for %%f in ("shootergame\content\paks\*") do (
    echo Processing file: %%f
    git add "%%f"
    git commit -m "Commit: %%~nxf"
    set /a count+=1

    :: When 4 commits are done, push the batch
    if !count! EQU 10 (
        echo Pushing a batch of 10 commits...
        git push origin main
        set count=0
    )
)

:: Push any remaining commits that did not form a full batch
if %count% GTR 0 (
    echo Pushing the final batch of %count% commit(s)...
    git push origin main
)

endlocal
pause
