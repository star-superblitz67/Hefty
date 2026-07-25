$tickers = 'AAPL', 'MSFT', 'GOOG', 'AMZN', 'NVDA', 'META', 'TSLA', 'BRK.B', 'LLY', 'V', 'UNH', 'JPM', 'XOM', 'WMT', 'JNJ', 'MA', 'PG', 'AVGO', 'HD', 'CVX', 'MRK', 'ABBV', 'COST', 'PEP', 'ADBE', 'DLQI', 'TAET', 'FEVT', 'DPMA', 'QQPT', 'TBNM', 'IEAC', 'XPOW', 'NUDV', 'SCOJ', 'CSQE', 'CUOW', 'PJOG', 'OCZH', 'FGWK', 'BJDC', 'HJUP', 'EXAP', 'CTJI', 'HGBM', 'ETJS', 'OVXX', 'YZJH', 'FQHI', 'BPAS', 'RJGZ', 'ZTBE', 'MVUV', 'ZXMP', 'CLNP', 'KWIT', 'RRGR', 'YGZJ', 'NSHB', 'GHIU', 'TLIJ', 'KYHK', 'VIFZ', 'ZMQS'

$banks = New-Object 'string[][]' 4
for ($i = 0; $i -lt 4; $i++) {
    $banks[$i] = New-Object 'string[]' 64
    for ($j = 0; $j -lt 64; $j++) {
        $banks[$i][$j] = "0000000000000"
    }
}

foreach ($ticker in $tickers) {
    $padded = $ticker.PadRight(6, ' ').Substring(0, 6)
    $h_idx = 0
    $hex_str = ""
    foreach ($char in $padded.ToCharArray()) {
        $h_idx = $h_idx -bxor [int]$char
        $hex_str += "{0:X2}" -f [int]$char
    }
    $h_idx = $h_idx -band 0x3F
    $valid_hex = "1" + $hex_str

    $placed = $false
    for ($bank_idx = 0; $bank_idx -lt 4; $bank_idx++) {
        if ($banks[$bank_idx][$h_idx] -eq "0000000000000") {
            $banks[$bank_idx][$h_idx] = $valid_hex
            $placed = $true
            break
        }
    }
    if (-not $placed) {
        Write-Host "FATAL OVERFLOW for $ticker"
    }
}

New-Item -ItemType Directory -Force -Path "rtl/mem" | Out-Null
New-Item -ItemType Directory -Force -Path "mem" | Out-Null
for ($i = 0; $i -lt 4; $i++) {
    $content = $banks[$i] -join "`n"
    Set-Content -Path "rtl/mem/bank$i.hex" -Value $content
    Set-Content -Path "mem/bank$i.hex" -Value $content
}
Write-Host "Generated hex files in mem and rtl/mem directory"
