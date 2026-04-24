param(
  [Parameter(Mandatory = $false)]
  [string]$RepoUrl
)

$ErrorActionPreference = "Stop"
$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Project path: $projectPath"

if (-not $RepoUrl) {
  $RepoUrl = Read-Host "Enter GitHub repo URL (example: https://github.com/yourname/limme-demo.git)"
}

if (-not $RepoUrl) {
  throw "Repo URL is required. Script stopped."
}

Set-Location $projectPath

if (-not (Test-Path ".git")) {
  git init
}

git add .

$hasCommit = $true
try {
  git rev-parse --verify HEAD *> $null
} catch {
  $hasCommit = $false
}

if (-not $hasCommit) {
  git commit -m "Initial commit: LIMME GitHub-ready demo"
} else {
  $status = git status --porcelain
  if ($status) {
    git commit -m "Update project files"
  } else {
    Write-Host "No new changes to commit."
  }
}

$hasOrigin = $false
try {
  git remote get-url origin *> $null
  $hasOrigin = $true
} catch {
  $hasOrigin = $false
}

if ($hasOrigin) {
  git remote set-url origin $RepoUrl
} else {
  git remote add origin $RepoUrl
}

git branch -M main
git push -u origin main

Write-Host ""
Write-Host "Upload completed."
Write-Host "If this is your first push, complete GitHub login when prompted."
