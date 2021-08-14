# GENERAL SETTINGS
Import-Module posh-git                                                                   # posh-git: git tab completion
Set-PoshPrompt -Theme honukai                                                            # OHMYPOSH: Set the prompt to oh-my-posh's paradox theme
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'                                        # PSFzf: command <fzf here>
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'                                  # PSFzf: cd to path with fzf
# Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }               # PSFzf: Enable tab completion using fzf

# ALIAS FUNCTIONS
function l() { fd -d 1 }                                                                 # DIR: List files & dirs using fd
function la() { fd -d 1 -H }                                                             # DIR: List files & dirs including hidden using fd
function ..() { Set-Location -LiteralPath .. }                                           # DIR: Move up one dir
function ...() { Set-Location -LiteralPath ../../ }                                      # DIR: Move up two dir
function h() { Set-Location $HOME }                                                      # DIR: Go to home dir
function c() { Set-Location -LiteralPath C:/ }                                           # DIR: Go to C:/
function d() { Set-Location -LiteralPath D:/ }                                           # DIR: Go to D:/
function re() { Set-Location -LiteralPath D:/repos }                                      # DIR: Go to D:/repos
function f() { Set-Location -LiteralPath F:/ }                                           # DIR: Go to F:/
function k() { Set-Location -LiteralPath F:/Kuliah/ }                                    # DIR: Go to F:/Kuliah
function dow() { Set-Location -LiteralPath C:/Users/Administrator/Downloads/ }           # DIR: User Downloads
function doc() { Set-Location -LiteralPath C:/Users/Administrator/Documents/ }           # DIR: User Documents
function fm() {                                                                          # DIR: Fuzzy cd to all drive
  Write-Output "[FD] Searching dirs"
  $d = Set-Location D:\; fd -t d -a; Set-Location F:\; fd -t d -a
  # $f = Set-Location F:\; fd -t d -a
  Write-Output $d # + $f
  Set-Location $HOME
}
function fr($pattern) {                                                                  # NVIM: Open from a pattern searched by ripgrep
  if(!(rg -h)) {
    Write-Error "Failed to use ripgrep"
    if (!(fzf -h)) {
      Write-Error "Failed to use fzf"
    }
  } elseif ($pattern) {
    Write-Host "[RIPGREP] Searching for '$pattern'"
    rg -l $pattern | fzf | ForEach-Object { nvim "$(Get-Location)\$_" }
  } else {
    Write-Warning "Please input pattern 'fr <pattern>'"
  }
}

# REMOVE CONFLICTING ALIAS
if(Test-Path alias:h) { Remove-Alias h }                                                 # Get-History

# ENVIRONTMENT VARIABLES
$env:FZF_DEFAULT_COMMAND = "fd -H -a"
$env:FZF_CTRL_T_COMMAND = "$env:FZF_DEFAULT_COMMAND"
$env:FZF_Alt_C_COMMAND = "$env:FZF_DEFAULT_COMMAND -t d"
