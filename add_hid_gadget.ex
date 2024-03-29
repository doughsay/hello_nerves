import File, only: [mkdir!: 1, write!: 2, write!: 3, ln_s!: 2]

gadget_name = "my_keyboard"

# Mount ConfigFS
cmd("mount -t configfs none /sys/kernel/config")

# Create gadget
mkdir!("/sys/kernel/config/usb_gadget/#{gadget_name}")
cd("/sys/kernel/config/usb_gadget/#{gadget_name}")

# Add basic information
# Version 1.0.0
write!("bcdDevice", "0x0100")
# USB 2.0
write!("bcdUSB", "0x0200")
write!("bDeviceClass", "0x00")
write!("bDeviceProtocol", "0x00")
write!("bDeviceSubClass", "0x00")
write!("bMaxPacketSize0", "0x08")
# Multifunction Composite Gadget
write!("idProduct", "0x0104")
# Linux Foundation
write!("idVendor", "0x1d6b")

# Create English locale
mkdir!("strings/0x409")

write!("strings/0x409/manufacturer", "My manufacturer")
write!("strings/0x409/product", "My virtual keyboard")
write!("strings/0x409/serialnumber", "0123456789")

# Create HID function
mkdir!("functions/hid.usb0")

write!("functions/hid.usb0/protocol", "1")
# 8-byte reports
write!("functions/hid.usb0/report_length", "8")
write!("functions/hid.usb0/subclass", "1")

# Write report descriptor
# report_descriptor =
#   <<0x05, 0x01, 0x09, 0x06, 0xA1, 0x01, 0x05, 0x07, 0x19, 0xE0, 0x29, 0xE7, 0x15, 0x00, 0x25,
#     0x01, 0x75, 0x01, 0x95, 0x08, 0x81, 0x02, 0x75, 0x08, 0x95, 0x01, 0x81, 0x01, 0x75, 0x01,
#     0x95, 0x03, 0x05, 0x08, 0x19, 0x01, 0x29, 0x03, 0x91, 0x02, 0x75, 0x01, 0x95, 0x05, 0x91,
#     0x01, 0x75, 0x08, 0x95, 0x06, 0x15, 0x00, 0x26, 0xFF, 0x00, 0x05, 0x07, 0x19, 0x00, 0x2A,
#     0xFF, 0x00, 0x81, 0x00, 0xC0>>
report_descriptor =
  <<0x05, 0x01, 0x09, 0x06, 0xA1, 0x01, 0x05, 0x07, 0x19, 0xE0, 0x29, 0xE7, 0x15, 0x00, 0x25,
    0x01, 0x75, 0x01, 0x95, 0x08, 0x81, 0x02, 0x81, 0x01, 0x19, 0x00, 0x29, 0xFF, 0x15, 0x00,
    0x25, 0xFF, 0x75, 0x08, 0x95, 0x06, 0x81, 0x00, 0x05, 0x08, 0x19, 0x01, 0x29, 0x05, 0x15,
    0x00, 0x25, 0x01, 0x75, 0x01, 0x95, 0x05, 0x91, 0x02, 0x95, 0x03, 0x91, 0x01, 0xC0>>

write!("functions/hid.usb0/report_desc", report_descriptor, [:binary])

# Create configuration
mkdir!("configs/c.1")
mkdir!("configs/c.1/strings/0x409")

write!("configs/c.1/bmAttributes", "0x80")
# 200 mA
write!("configs/c.1/MaxPower", "200")
write!("configs/c.1/strings/0x409/configuration", "Example configuration")

# Link HID function to configuration
cmd("ln -s functions/hid.usb0 configs/c.1/")

# Enable gadget
cmd("ls /sys/class/udc > UDC")
