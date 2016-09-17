From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sat, 17 Sep 2016 13:25:26 +0530
Subject: [PATCH 3/3] arm: dts: imx6qdl-wandboard-revb: Fix "ERROR: trailing
 whitespace"
In-Reply-To: <1474098926-5236-1-git-send-email-jagan@amarulasolutions.com>
References: <1474098926-5236-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1474098926-5236-3-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jteki@openedev.com>

Fixed error in trailing whitespace in wandboard-rev1 dtsi.

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jteki@openedev.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
index ef7fa62..a320891 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
@@ -28,7 +28,7 @@
 				MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x80000000	/* RGMII_nRST */
 				MX6QDL_PAD_EIM_DA13__GPIO3_IO13		0x80000000	/* BT_ON */
 				MX6QDL_PAD_EIM_DA14__GPIO3_IO14		0x80000000	/* BT_WAKE */
-				MX6QDL_PAD_EIM_DA15__GPIO3_IO15		0x80000000	/* BT_HOST_WAKE */				
+				MX6QDL_PAD_EIM_DA15__GPIO3_IO15		0x80000000	/* BT_HOST_WAKE */
 			>;
 		};
 	};
-- 
2.7.4
