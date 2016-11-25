From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 25 Nov 2016 15:26:56 +0100
Subject: [PATCH v5 0/2] ARM: dts: add support for Turris Omnia
Message-ID: <20161125142658.21690-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is basicly my v3 plus some of the changes that Tomas changed for
his RFC patch (implicitly "v4"). So compared to v3 the following
changed:

 - Add more documentation (mostly from Tomas)
 - Add more mbus ranges (by Tomas)
 - Move link to schematic below copyright header (suggested by Andrew)
 - reenable rtc as this is not that broken on production board
 - fix spi chip select pinmuxing

Uwe Kleine-K?nig (2):
  devicetree: Add vendor prefix for CZ.NIC
  ARM: dts: add support for Turris Omnia

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-385-turris-omnia.dts      | 334 +++++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-turris-omnia.dts

-- 
2.10.2
