import os

# Hash function — XOR all 6 bytes of the ticker name to get a table index
def compute_hash(ticker_str):
    # Pad short tickers (like "V") to 6 chars with spaces
    padded = ticker_str.ljust(6)[:6]
    xor_val = 0
    for c in padded:
        xor_val ^= ord(c)
    return xor_val & 0x3F # 6-bit index

def string_to_hex(ticker_str):
    padded = ticker_str.ljust(6)[:6]
    hex_str = "".join(f"{ord(c):02X}" for c in padded)
    return hex_str

# All 64 tickers we want the hardware to recognize
tickers = ['AAPL', 'MSFT', 'GOOG', 'AMZN', 'NVDA', 'META', 'TSLA', 'BRK.B', 'LLY', 'V', 'UNH', 'JPM', 'XOM', 'WMT', 'JNJ', 'MA', 'PG', 'AVGO', 'HD', 'CVX', 'MRK', 'ABBV', 'COST', 'PEP', 'ADBE', 'DLQI', 'TAET', 'FEVT', 'DPMA', 'QQPT', 'TBNM', 'IEAC', 'XPOW', 'NUDV', 'SCOJ', 'CSQE', 'CUOW', 'PJOG', 'OCZH', 'FGWK', 'BJDC', 'HJUP', 'EXAP', 'CTJI', 'HGBM', 'ETJS', 'OVXX', 'YZJH', 'FQHI', 'BPAS', 'RJGZ', 'ZTBE', 'MVUV', 'ZXMP', 'CLNP', 'KWIT', 'RRGR', 'YGZJ', 'NSHB', 'GHIU', 'TLIJ', 'KYHK', 'VIFZ', 'ZMQS']

# Set up 4 empty banks (64 slots each) — all zeros means "no ticker here"
banks = [["0000000000000" for _ in range(64)] for _ in range(4)]

print("Generating BRAM hex files...")
for ticker in tickers:
    h_idx = compute_hash(ticker)
    hex_val = string_to_hex(ticker)
    
    # The leading "1" is the valid bit — tells the hardware this slot is occupied
    valid_hex = f"1{hex_val}"
    
    # Try to place this ticker in the first bank that has room at this hash slot
    placed = False
    for bank_idx in range(4):
        if banks[bank_idx][h_idx] == "0000000000000":
            banks[bank_idx][h_idx] = valid_hex
            placed = True
            print(f"Placed {ticker.strip()} (Hash {h_idx}) in Bank {bank_idx}")
            break
            
    if not placed:
        print(f"FATAL OVERFLOW: Hash {h_idx} has more than 4 collisions! Cannot place {ticker}")

os.makedirs("mem", exist_ok=True)
for i in range(4):
    filepath = f"mem/bank{i}.hex"
    with open(filepath, "w") as f:
        f.write("\n".join(banks[i]) + "\n")
    print(f"Wrote {filepath}")
