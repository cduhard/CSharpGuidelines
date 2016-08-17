properties {
    $BaseDirectory = Resolve-Path ..     
}

task default -depends Clean, Compile, Convert-ToHtml, Convert-ToPdf

task Clean {	
    TeamCity-Block "Removing build output from previous runs" {
		Get-ChildItem $BaseDirectory\Guidelines\CSharp*.md | ForEach { Remove-Item $_.FullName }
    }
}

task Compile {
    TeamCity-Block "Compiling Markdown file from individual section" {
		$files = (dir $BaseDirectory\Guidelines\*.md)
		$outfile = "$BaseDirectory\Guidelines\CSharpCodingGuidelines.md"

		$files | %{
			Write-Host "Including " + $_.FullName
		    Get-Content $_.FullName | Add-Content $outfile
		}
    }
}

task Convert-ToHtml {
    TeamCity-Block "Converting to html..." {
		$command = 'marked $BaseDirectory\Guidelines\CSharpCodingGuidelines.md -o $BaseDirectory\Guidelines\CSharpCodingGuidelines.html'
		iex $command
	}
}

task Convert-ToPdf {
	TeamCity-Block "Converting to pdf..." {
		$command = '"c:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe" $BaseDirectory\Guidelines\CSharpCodingGuidelines.html $BaseDirectory\Guidelines\CSharpCodingGuidelines.pdf'
		iex "& $command"
	}
}