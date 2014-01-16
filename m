From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 13:44:19 +0100
Subject: [PATCH 2/4] ARM: dts: imx6q: Add spi4 alias
In-Reply-To: <1389876261-29087-1-git-send-email-s.hauer@pengutronix.de>
References: <1389876261-29087-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1389876261-29087-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The quad version has a SPI controller more than the other
versions. Add an alias for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 021e0cb..52a9a2b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -14,6 +14,10 @@
 #include "imx6qdl.dtsi"
 
 / {
+	aliases {
+		spi4 = &ecspi5;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.5.2
