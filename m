From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  2 Dec 2015 14:42:22 +0100
Subject: [PATCH] ARM: dts: imx6qdl: add IPU aliases
Message-ID: <1449063742-949-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This allows for consistent numbering of the IPU output and
input ports.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi   | 1 +
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 399103b8e2c9..a266a564a3f6 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -14,6 +14,7 @@
 
 / {
 	aliases {
+		ipu1 = &ipu2;
 		spi4 = &ecspi5;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2b6cc8bf3c5c..8e203293ba2c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -30,6 +30,7 @@
 		i2c0 = &i2c1;
 		i2c1 = &i2c2;
 		i2c2 = &i2c3;
+		ipu0 = &ipu1;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
-- 
2.6.2
