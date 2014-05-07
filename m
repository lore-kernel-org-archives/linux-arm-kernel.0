From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  7 May 2014 15:31:23 +0200
Subject: [PATCH] i.MX25 dts updates
Message-ID: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following contains some updates to the i.MX25 dtsi files
and the Karo TX25 board.

Sascha

----------------------------------------------------------------
Sascha Hauer (6):
      ARM: dts: i.MX25: Add mmc aliases
      ARM: dts: i.MX25: remove disabled property of usbmisc unit
      ARM: dts: i.MX25: Add IRAM node
      ARM: dts: Karo TX25: Add pinctrl nodes
      ARM: dts: Karo TX25: Add phy reset gpio and supply for FEC
      ARM: dts: Karo TX25: use hardware ecc

 arch/arm/boot/dts/imx25-karo-tx25.dts | 72 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx25.dtsi          |  8 +++-
 2 files changed, 79 insertions(+), 1 deletion(-)
