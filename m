From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Wed, 30 Dec 2015 15:35:30 +0200
Subject: [PATCH v4 0/3] wlcore/wl12xx: spi: add wifi support to cm-t335
Message-ID: <1451482533-8624-1-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support for WLS1271 SPI driver.
Add power operation function to the WLS1271 SPI driver.

Uri Mashiach (3):
  wlcore/wl12xx: spi: add power operation function
  wlcore/wl12xx: spi: add device tree support
  wlcore/wl12xx: spi: add wifi support to cm-t335

 .../bindings/net/wireless/ti,wlcore,spi.txt        | 36 +++++++++
 arch/arm/boot/dts/am335x-cm-t335.dts               | 55 ++++++++++++++
 drivers/net/wireless/ti/wlcore/Kconfig             |  2 +-
 drivers/net/wireless/ti/wlcore/spi.c               | 86 +++++++++++++++++++++-
 4 files changed, 174 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt

-- 
2.5.0
