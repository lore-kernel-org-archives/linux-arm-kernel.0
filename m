From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Tue, 17 Feb 2015 11:20:19 -0800
Subject: [PATCH 0/2] USB PHY driver for Broadcom's Cygnus chipset
Message-ID: <1424200821-16368-1-git-send-email-arun.ramamurthy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the USB phy driver and documentation 
for Broadom's Cygnus chipset. The phy is configurable from device tree
and is capable of both device and host functions. It also provides
a clock and reset to the host controller

Arun Ramamurthy (2):
  phy: usbphy: Add dt documentation for Broadcom Cygnus USB PHY driver
  phy: usbphy: Add Broadcom Cygnus USB PHY driver

 .../bindings/phy/brcm,cygnus-usb-phy.txt           |  50 +++
 drivers/phy/Kconfig                                |  12 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-bcm-cygnus-usb.c                   | 491 +++++++++++++++++++++
 4 files changed, 555 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
 create mode 100644 drivers/phy/phy-bcm-cygnus-usb.c

-- 
2.3.0
