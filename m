From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 27 Jul 2017 13:04:41 -0300
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: Remove unrelated pin from ENET
 group
Message-ID: <1501171481-17171-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00 is connected to the INT1 pin of
the FXLS8471Q accelerometer, so remove it from the unrelated ENET
group.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index b3f72a3..9c23e01 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -307,7 +307,6 @@
 			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
 			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
 			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
-			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x17059
 		>;
 	};
 
-- 
2.7.4
