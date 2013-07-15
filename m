From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:47 +0200
Subject: [PATCH 02/22] arm/dts: imx25.dtsi: Add an alias for the LCD
 controller.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 6a1633d..4837849 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -393,7 +393,7 @@
 				status = "disabled";
 			};
 
-			lcdc at 53fbc000 {
+			lcdc: lcdc at 53fbc000 {
 				compatible = "fsl,imx21-lcdif";
 				reg = <0x53fbc000 0x4000>;
 				interrupts = <39>;
-- 
1.7.9.5
