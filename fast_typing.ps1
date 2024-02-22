# Fast Typing Script. 
# Takes your clipboard content and converts to keystrokes after a 3 second delay

# Load the System.Windows.Forms assembly for SendKeys and clipboard access
Add-Type -AssemblyName System.Windows.Forms

# Function to send keystrokes
function Send-KeystrokesFromClipboard {
    # Ensure the [System.Windows.Forms.Clipboard] class is used for accessing the clipboard
    $Text = [System.Windows.Forms.Clipboard]::GetText()

    # Check if there is text on the clipboard
    if ([string]::IsNullOrWhiteSpace($Text)) {
        Write-Host "The clipboard does not contain text. Exiting script."
        return
    }

    # Alert the user and wait for 3 seconds
    Write-Host "You have 3 seconds to switch to the window where you want the text to be typed out..."
    Start-Sleep -Seconds 3

    # Split the text into individual characters and send each one as a keystroke without delay
    $Text.ToCharArray() | ForEach-Object {
        $key = $_.ToString()
        # Check for special characters that SendKeys might need to escape
        if ($key -match '[+\^%~(){}[\]]') {
            $key = "{$key}"
        }
        [System.Windows.Forms.SendKeys]::SendWait($key)
    }
}

# Call the function to send keystrokes from clipboard content
Send-KeystrokesFromClipboard
