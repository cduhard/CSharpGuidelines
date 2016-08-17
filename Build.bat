@echo off
powershell -NoProfile -ExecutionPolicy unrestricted -Command ".\Build\psake.ps1 .\Build\default.ps1 

marked .\Guidelines\CSharpCodingGuidelines.md -o .\Guidelines\CSharpCodingGuidelines.html
"c:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe" .\Guidelines\CSharpCodingGuidelines.html .\Guidelines\CSharpCodingGuidelines.pdf