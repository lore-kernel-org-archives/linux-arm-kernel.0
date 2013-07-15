From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:52 +0200
Subject: [PATCH 07/22] arm/dts: i.MX25: Add sdma script path.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-8-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index fb37111..f7f024f 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -506,6 +506,7 @@
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				interrupts = <34>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx25-to1.bin";
 			};
 
 			wdog at 53fdc000 {
-- 
1.7.9.5
