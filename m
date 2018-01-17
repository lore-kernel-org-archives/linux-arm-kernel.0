From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 15:38:18 +0100
Subject: [PATCH] arm: zynq: Add mmc alias for zc702/zc706/zed/zybo
Message-ID: <56003f03e66edecb64298317120d4a37b9944a3f.1516199896.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing mmc alias.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-zc702.dts | 1 +
 arch/arm/boot/dts/zynq-zc706.dts | 1 +
 arch/arm/boot/dts/zynq-zed.dts   | 1 +
 arch/arm/boot/dts/zynq-zybo.dts  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index dd1a731ae24c..46f14422b2e7 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -23,6 +23,7 @@
 		ethernet0 = &gem0;
 		i2c0 = &i2c0;
 		serial0 = &uart1;
+		mmc0 = &sdhci0;
 	};
 
 	memory at 0 {
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 8a0c2ff4c5eb..9224b45f9418 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -23,6 +23,7 @@
 		ethernet0 = &gem0;
 		i2c0 = &i2c0;
 		serial0 = &uart1;
+		mmc0 = &sdhci0;
 	};
 
 	memory at 0 {
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 1015edd69ff3..c8fad19e07dd 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -22,6 +22,7 @@
 	aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart1;
+		mmc0 = &sdhci0;
 	};
 
 	memory at 0 {
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index c131dc45e4eb..b0ad94cb9e4a 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -22,6 +22,7 @@
 	aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart1;
+		mmc0 = &sdhci0;
 	};
 
 	memory at 0 {
-- 
1.9.1
