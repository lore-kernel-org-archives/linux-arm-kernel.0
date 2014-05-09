From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 May 2014 08:11:13 +0200
Subject: [PATCH v2] i.MX25 dts updates
Message-ID: <1399615879-30781-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:

- Fix mmc1 alias name
- Add enable-active-high to FEC phy regulator
- Fix gpio number for FEC phy reset

Sascha

----------------------------------------------------------------
Sascha Hauer (6):
      ARM: dts: i.MX25: Add mmc aliases
      ARM: dts: i.MX25: remove disabled property of usbmisc unit
      ARM: dts: i.MX25: Add IRAM node
      ARM: dts: Karo TX25: Add pinctrl nodes
      ARM: dts: Karo TX25: Add phy reset gpio and supply for FEC
      ARM: dts: Karo TX25: use hardware ecc

 arch/arm/boot/dts/imx25-karo-tx25.dts | 73 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx25.dtsi          |  8 +++-
 2 files changed, 80 insertions(+), 1 deletion(-)
