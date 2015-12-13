From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Sun, 13 Dec 2015 10:55:34 +0200
Subject: [PATCH 0/5] ARM: dts: cm-t335: add peripheral support
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the following CM-T335 module peripherals:
USB, I2C controller, LCD/DVI, bluetooth

Ilya Ledvich (1):
  ARM: dts: cm-t335: add support for USB0

Uri Mashiach (4):
  ARM: dts: cm-t335: add support for SBC-T335
  ARM: dts: cm-t335: add support for I2C GPIO expander
  ARM: dts: cm-t335: add support for DVI/LCD
  ARM: dts: cm-t335: add support for bluetooth

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-cm-t335.dts               |  51 ++++-
 arch/arm/boot/dts/am335x-sbc-t335.dts              | 219 +++++++++++++++++++++
 4 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-sbc-t335.dts

-- 
2.5.0
