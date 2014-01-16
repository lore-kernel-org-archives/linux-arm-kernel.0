From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 13:44:18 +0100
Subject: [PATCH 1/4] ARM: dts: imx53: Add mmc aliases
In-Reply-To: <1389876261-29087-1-git-send-email-s.hauer@pengutronix.de>
References: <1389876261-29087-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1389876261-29087-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4dbde25..84828b2 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -28,6 +28,10 @@
 		i2c0 = &i2c1;
 		i2c1 = &i2c2;
 		i2c2 = &i2c3;
+		mmc0 = &esdhc1;
+		mmc1 = &esdhc2;
+		mmc2 = &esdhc3;
+		mmc3 = &esdhc4;
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
-- 
1.8.5.2
