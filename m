From: jteki@openedev.com (Jagan Teki)
Date: Fri, 14 Oct 2016 15:09:30 +0530
Subject: [PATCH v2 3/3] arm: dts: imx6qdl-wandboard-revb: Fix "ERROR: trailing
 whitespace"
In-Reply-To: <1476437970-15800-1-git-send-email-jteki@openedev.com>
References: <1476437970-15800-1-git-send-email-jteki@openedev.com>
Message-ID: <1476437970-15800-4-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed error in trailing whitespace in wandboard-rev1 dtsi.

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jteki@openedev.com>
---
Changes for v2:
	- none

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
