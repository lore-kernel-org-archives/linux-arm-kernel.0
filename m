From: andrej@inversepath.com (andrej at inversepath.com)
Date: Mon,  5 Sep 2016 12:11:15 +0200
Subject: [PATCH v3 0/2] imx53: add support for USB armory board
Message-ID: <20160905101117.27473-1-andrej@inversepath.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrej Rosano <andrej@inversepath.com>

This patchset add the support for USB armory board:
https://inversepath.com/usbarmory

v3: Changes proposed by Shawn Guo <shawnguo@kernel.org>
- various fixes in dts file

v2: Changes proposed by Shawn Guo <shawnguo@kernel.org>
- re-licensing dts to dual GPL/X11 license
- various fixes in dts file

Andrej Rosano (2):
  devicetree: Add vendor prefix for Inverse Path
  ARM: dts: imx53: add support for USB armory board

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx53-usbarmory.dts              | 224 +++++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-usbarmory.dts

-- 
2.9.3
