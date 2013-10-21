From: denis@eukrea.com (Denis Carikli)
Date: Mon, 21 Oct 2013 11:51:35 +0200
Subject: [PATCHv4][ 08/11] ARM: dts: i.MX25: Add sdma script path.
In-Reply-To: <1382349098-11502-1-git-send-email-denis@eukrea.com>
References: <1382349098-11502-1-git-send-email-denis@eukrea.com>
Message-ID: <1382349098-11502-8-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index cce0669..7c0a019 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -556,6 +556,7 @@
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				interrupts = <34>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx25.bin";
 			};
 
 			wdog at 53fdc000 {
-- 
1.7.9.5
