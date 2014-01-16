From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 13:44:17 +0100
Subject: [PATCH] dts: i.MX: Add aliases
Message-ID: <1389876261-29087-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds some aliases to the i.MX5/6 dts files.

Sascha

----------------------------------------------------------------
Sascha Hauer (4):
      ARM: dts: imx53: Add mmc aliases
      ARM: dts: imx6q: Add spi4 alias
      ARM: dts: imx6qdl: Add mmc aliases
      ARM: dts: imx51: Add mmc aliases

 arch/arm/boot/dts/imx51.dtsi   | 4 ++++
 arch/arm/boot/dts/imx53.dtsi   | 4 ++++
 arch/arm/boot/dts/imx6q.dtsi   | 4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 4 files changed, 16 insertions(+)
