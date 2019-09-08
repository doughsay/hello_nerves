# H (press shift and H)
echo -ne "\\x20\\0\\xb\\0\\0\\0\\0\\0" > /dev/hidg0

# e
echo -ne "\\0\\0\\x8\\0\\0\\0\\0\\0" > /dev/hidg0

# ll
echo -ne "\\0\\0\\xf\\0\\0\\0\\0\\0" > /dev/hidg0
echo -ne "\\0\\0\\0\\0\\0\\0\\0\\0" > /dev/hidg0
echo -ne "\\0\\0\\xf\\0\\0\\0\\0\\0" > /dev/hidg0

# o
echo -ne "\\0\\0\\x12\\0\\0\\0\\0\\0" > /dev/hidg0

# SPACE
echo -ne "\\0\\0\\x2c\\0\\0\\0\\0\\0" > /dev/hidg0

# W (press shift and W)
echo -ne "\\x20\\0\\x1a\\0\\0\\0\\0\\0" > /dev/hidg0

# o
echo -ne "\\0\\0\\x12\\0\\0\\0\\0\\0" > /dev/hidg0

# r
echo -ne "\\0\\0\\x21\\0\\0\\0\\0\\0" > /dev/hidg0

# l
echo -ne "\\0\\0\\xf\\0\\0\\0\\0\\0" > /dev/hidg0

# d
echo -ne "\\0\\0\\x7\\0\\0\\0\\0\\0" > /dev/hidg0

# ! (press shift and 1)
echo -ne "\\x20\\0\\x1e\\0\\0\\0\\0\\0" > /dev/hidg0

# Release al keys
echo -ne "\\0\\0\\0\\0\\0\\0\\0\\0" > /dev/hidg0
