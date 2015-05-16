From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 16 May 2015 19:27:55 +0200
Subject: [PATCH 0/2] USB OTG PHY driver for NXP LPC18xx family
Message-ID: <1431797277-4906-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the internal USB OTG PHY found
on NXP LPC18xx and LPC43xx devices. Driver takes care of
enabling the PHY and setting the clock rate which is need for
USB0 support on this platform.

Base support for this platform can now be found in arm-soc next.

Joachim Eastwood (2):
  phy: add lpc18xx usb otg phy driver
  doc: dt: add documentation for nxp,lpc1850-usb-otg-phy

 .../bindings/phy/nxp,lpc1850-usb-otg-phy.txt       |  19 +++
 drivers/phy/Kconfig                                |  11 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-lpc18xx-usb-otg.c                  | 145 +++++++++++++++++++++
 4 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
 create mode 100644 drivers/phy/phy-lpc18xx-usb-otg.c

-- 
1.8.0
