From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:46 +0200
Subject: [PATCH 01/22] ARM i.MX25: devicetree: add compatible property for
 imxfb support.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index bcd3171..6a1633d 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -394,6 +394,7 @@
 			};
 
 			lcdc at 53fbc000 {
+				compatible = "fsl,imx21-lcdif";
 				reg = <0x53fbc000 0x4000>;
 				interrupts = <39>;
 				clocks = <&clks 103>, <&clks 66>, <&clks 49>;
-- 
1.7.9.5
