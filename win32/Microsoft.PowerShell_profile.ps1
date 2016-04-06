function remove_alias($name) {
	while(test-path alias:$name) {
		rm alias:$name
	}
}

function cd($dir) {
	if($dir) {
		set-location $dir
	} else {
		set-location $env:USERPROFILE
	}
}

function ls() {
	param(
		[switch]$l,
		[switch]$a,
		[switch]$R
	)

	if($args.length -gt 0) {
		foreach($file in $args) {
			get-filelist $l $a $R $file 
		}
	}
	else {
		get-filelist $l $a $R
	}
}

function get-filelist($long, $all, $recursive, $name) {
	$args = @{
		Recurse = $recursive
		Path = $name
	};

	$list = get-childitem @args
	if(! $all) {
		$list = $list | where { ! ($_.name -match "^[._]") }
	}

	if($long) {
		$list
	}
	elseif($recursive) {
		$list | sort @{expression = {$_.fullname}} | foreach-object {
			if($_.mode -match "d"){ echo "`n$($_.fullname)" }
			else { echo $_.name }
		}
	}
	else {
		$list | select-object -expand name
	}
}

function which($name) {
	get-command $name | select-object -expandproperty definition
}

function prompt {
	$laststatus = $?

	$_ = ($branch = git symbolic-ref -q --short HEAD 2>$nul) -or
	($branch = git describe --tags --exact-match 2>$nul) -or
	($branch = git describe --always 2>$nul)

	write-host ([Environment]::Username + "@" + [Environment]::MachineName) -nonewline -foregroundcolor "green"
	write-host ($executionContext.SessionState.Path.CurrentLocation) -nonewline -foregroundcolor "blue"

	if($branch) {
		write-host " ($branch)" -nonewline -foregroundcolor "darkmagenta"
	}

	if($laststatus) {
		write-host " $" -nonewline -foregroundcolor "blue"
	} else {
		write-host " $" -nonewline -foregroundcolor "red"
	}

	return " "
}

function exit_on_ctrld {
	$line = $null
	$cursor = $null
	[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

	if($line) {
		return;
	}

	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert('exit')
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}


$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

remove_alias cd
remove_alias ls
remove_alias curl

set-alias vi vim

set-psreadlinekeyhandler -Key Ctrl+d -ScriptBlock {
	exit_on_ctrld
}


