From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Wed, 23 Dec 2015 10:35:41 +0200
Subject: [PATCH 0/3] wlcore/wl12xx: spi: add wifi support to cm-t335
Message-ID: <1450859744-9948-1-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support for WLS1271 SPI driver.
Fix oops by adding a power callback.

Uri Mashiach (3):
  wlcore/wl12xx: spi: fix NULL pointer dereference (Oops)
  wlcore/wl12xx: spi: add device tree support
  wlcore/wl12xx: spi: add wifi support to cm-t335

 .../bindings/net/wireless/ti,wlcore,spi.txt        |  35 +++++++
 arch/arm/boot/dts/am335x-cm-t335.dts               |  58 +++++++++++-
 drivers/net/wireless/ti/wlcore/spi.c               | 104 +++++++++++++++++++--
 3 files changed, 189 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt

-- 
2.5.0
