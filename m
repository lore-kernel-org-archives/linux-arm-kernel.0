From: stefan@olimex.com (Stefan Mavrodiev)
Date: Mon, 28 Aug 2017 09:32:41 +0300
Subject: [PATCH v2 0/2] Update board support for A20-OLinuXino-MICRO
Message-ID: <1503901963-9457-1-git-send-email-stefan@olimex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From rev.J of A20-OLinuXino-MICRO, the board has new PHY chip
(LAN8710) which replace RTL8201. Also there is option for 4GB
eMMC chip.

Changes in v2:
	* Remove pinctrl request for eMMC reset pin
	* Dump the idea of renaming boards with emmc
	* Using txerr as gmac function

Stefan Mavrodiev (2):
  ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for LAN8710
  ARM: dts: sun7i: Add dts file for A20-OLinuXino-MICRO-eMMC

 arch/arm/boot/dts/Makefile                         |  1 +
 .../boot/dts/sun7i-a20-olinuxino-micro-emmc.dts    | 70 ++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  7 ++-
 3 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts

-- 
2.7.4
