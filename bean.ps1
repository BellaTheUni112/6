Add-Type -Name Win -Namespace Console -MemberDefinition @"
  [DllImport("user32.dll")]
  public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
  [DllImport("kernel32.dll")]
  public static extern IntPtr GetConsoleWindow();
"@

$consolePtr = [Console.Win]::GetConsoleWindow()
[Console.Win]::ShowWindowAsync($consolePtr, 0)
