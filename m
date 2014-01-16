From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 13:44:21 +0100
Subject: [PATCH 4/4] ARM: dts: imx51: Add mmc aliases
In-Reply-To: <1389876261-29087-1-git-send-email-s.hauer@pengutronix.de>
References: <1389876261-29087-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1389876261-29087-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index a462163..54e9063 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -25,6 +25,10 @@
 		gpio3 = &gpio4;
 		i2c0 = &i2c1;
 		i2c1 = &i2c2;
+		mmc0 = &esdhc1;
+		mmc1 = &esdhc2;
+		mmc2 = &esdhc3;
+		mmc3 = &esdhc4;
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
-- 
1.8.5.2
