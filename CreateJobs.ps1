#Script for creating new project year folders and adding new projects to existing years
#Print user options
function printOptions {
    Write-Output "Please select one of the following options"
    Write-Output "1) Create a folder for a new year"
    Write-Output "2) Add new projects for an existing year"
    Write-Output "3) Quit"
}
printOptions
#Gets valid user choice and executes the appropriate task
$choice = Read-Host "Please choose options 1, 2, or 3"
do {
    #Create a new folder for a new year
    if ($choice -eq "1") {
        #Gets valid year from user
        [bool]$validYear = $true
        $newYear = Read-Host "Please enter the new year (eg. 2020)"
        $existingYears = Get-ChildItem -Path "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\SampleFDrive" -Name
        do {
            if ($newYear -match "20\d{2}" -and !($existingYears.Contains($newYear))) {
                $validYear = $false
            }
            else {
                $newYear = Read-Host "Year is invalid or already exists!`nPlease enter a valid new year (eg. 2021)"
            }
        } while ($validYear)
        #Creates the new year folder
        New-Item -Path "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\SampleFDrive" -Name $newYear -ItemType "directory" | Out-Null
        #Gets the number of jobs to create inside new year folder
        [bool]$validNumberOfJobs = $true
        $numOfJobs = [int](Read-Host "Please enter the number of job folders to create")
        do {
            if ($numOfJobs.GetType() -eq [int] -and $numOfJobs -gt 0 -and $numOfJobs -lt 201) {
                $validNumberOfJobs = $false
            }
            else {
                $numOfJobs = [int](Read-Host "Invalid number, please enter a number between 1-200")
            }
        } while ($validNumberOfJobs)
        #Job number
        $newJob = [int]($newYear.Substring(0, 1) + $newYear.Substring(2, 2) + "001")
        #Creates jobs in new year folder
        for ($i = 0; $i -lt $numOfJobs; $i++) {
            New-Item -Path "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\SampleFDrive\$newYear" -Name $newJob -ItemType "directory" | Out-Null
            Copy-Item -Path "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\JOBNUM\*" -Destination "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\SampleFDrive\$newYear\$newJob" -Recurse
            $newJob++
        }
    }
    elseif ($choice -eq "2") {
        #Gets user input for the existing year to add new projects
        [bool]$existingYear = $true
        $year = Read-Host "Please enter the year to add new projects to"
        $allExistingYear = Get-ChildItem -Path "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\SampleFDrive\" -Name
        do {
            if ($allExistingYear.Contains($year)) {
                $existingYear = $false
                [bool]$validJobNum = $true
                $jobs = [int](Read-Host "Please enter the number of new jobs to be created")           
                do {
                    if ($jobs.GetType() -eq [int] -and $jobs -gt 0 -and $jobs -lt 201) {
                        $validJobNum = $false
                        $existingJobs = Get-ChildItem -Path "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\SampleFDrive\$year" -Name
                        $newJobNumber = 0
                        if ($existingJobs.Length -eq 0) {
                            $newJobNumber = [int]($Year.Substring(0, 1) + $Year.Substring(2, 2) + "001")       
                        }
                        else {
                            $newJobNumber = [int]$existingJobs[$existingJobs.Length - 1] + 1
                        }
                        #Creates jobs in new year folder
                        for ($i = 0; $i -lt $jobs; $i++) {
                            New-Item -Path "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\SampleFDrive\$year" -Name $newJobNumber -ItemType "directory" | Out-Null
                            Copy-Item -Path "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\JOBNUM\*" -Destination "C:\Users\lwung\Desktop\CW_GS_2020\AddingNewProjectsToFDrive\SampleFDrive\$Year\$newJobNumber" -Recurse
                            $newJobNumber++
                        }
                    }
                    else {
                        $jobs = [int](Read-Host "Invalid number, please enter a number between 1-200")
                    }
                } while ($validJobNum)
            }
            else {
                $year = Read-Host "Invalid year, please enter a project folder year that exists"
            }
        } while ($existingYear)
    }
    elseif ($choice -eq "3") {
        exit
    }
    else {
        $choice = Read-Host "Please enter a valid option (1, 2, or 3)"    
    }  
} while (($choice -ne 1) -and ($choice -ne 2))

