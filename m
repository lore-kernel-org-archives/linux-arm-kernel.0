From: andrew@lunn.ch (Andrew Lunn)
Date: Fri,  9 Jan 2015 01:26:16 +0100
Subject: [PATCH 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
Message-ID: <1420763178-10115-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a driver for the TI tlc59116 16 Channel i2c LED
driver. This driver is used on the Belkin WRT1900AC access point and
the C code is derived from code Belkin contributed to OpenWRT.
However it has been extensively re-written, and a device tree binding
added to replace platform data.

Cc: Matthew.Fatheree at belkin.com

Andrew Lunn (2):
  leds: tlc59116: Document binding for the TI 16 Channel i2c LED driver
  leds: tlc59116: Driver for the TI 16 Channel i2c LED driver

 .../devicetree/bindings/leds/leds-tlc59116.txt     |  41 ++++
 drivers/leds/Kconfig                               |   7 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-tlc59116.c                       | 253 +++++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc59116.txt
 create mode 100644 drivers/leds/leds-tlc59116.c

-- 
2.1.3
