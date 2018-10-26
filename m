From: miyatsu@qq.com (Ding Tao)
Date: Fri, 26 Oct 2018 11:50:27 +0000
Subject: [PATCH 1/2] arm64: dts: marvell: armada37xx: Add emmc/sdio pinctrl
 definition
Message-ID: <20181026115028.193203-1-miyatsu@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add emmc/sdio pinctrl definition for marvell armada37xx SoCs.

Signed-off-by: Ding Tao <miyatsu@qq.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index d9531e242eb4..eeec04a1add6 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -221,6 +221,11 @@
 					groups = "uart2";
 					function = "uart";
 				};
+
+				mmc_pins: mmc-pins {
+					groups = "emmc_nb";
+					function = "emmc";
+				};
 			};
 
 			nb_pm: syscon at 14000 {
@@ -253,6 +258,11 @@
 					function = "mii";
 				};
 
+				sdio_pins: sdio-pins {
+					groups = "sdio_sb";
+					function = "sdio";
+				};
+
 			};
 
 			eth0: ethernet at 30000 {
-- 
2.17.1
