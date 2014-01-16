From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 13:52:26 +0100
Subject: [PATCH] ARM: imx6: dmo edmqmx6 updates
Message-ID: <1389876750-29880-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds some additional features to the recently introduced
DataModul edmqmx6 board.

Sascha

----------------------------------------------------------------
Philipp Zabel (1):
      ARM: dts: imx6: edmqmx6: add PF0100 PMIC to device tree

Sascha Hauer (3):
      ARM: dts: imx6: edmqmx6: Add usdhc4 (emmc) support
      ARM: dts: imx6: edmqmx6: Add sata support
      ARM: dts: imx6: edmqmx6: Add LED support

 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 148 ++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
