From: w-kwok2@ti.com (WingMan Kwok)
Date: Thu, 12 Dec 2013 12:25:28 -0500
Subject: [PATCH v4 0/2] Kesytone II USB host and PHY drivers
Message-ID: <1386869130-2993-1-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending the series with suggested minor updates from v3 [1].

Series adds USB host support for Keystone SOCs. Keystone SOCs
uses dwc3 hardware IP implementation.  On Keystone II platforms,
we use no-op phy driver.

Patchset are tested on Keystone II EVM with USB2.0 and USB3.0
flash drives along with dts changes.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

WingMan Kwok (2):
  usb: dwc3: Add Keystone specific glue layer
  usb: phy: Add keystone usb phy driver

 drivers/usb/dwc3/Kconfig         |    7 ++
 drivers/usb/dwc3/Makefile        |    1 +
 drivers/usb/dwc3/dwc3-keystone.c |  201 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/phy/Kconfig          |    9 ++
 drivers/usb/phy/Makefile         |    1 +
 drivers/usb/phy/phy-keystone.c   |  142 +++++++++++++++++++++++++++
 6 files changed, 361 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-keystone.c
 create mode 100644 drivers/usb/phy/phy-keystone.c

[1] http://www.spinics.net/lists/linux-usb/msg99178.html
-- 
1.7.9.5
