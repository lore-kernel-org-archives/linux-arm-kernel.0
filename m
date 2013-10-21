From: denis@eukrea.com (Denis Carikli)
Date: Mon, 21 Oct 2013 11:51:36 +0200
Subject: [PATCHv4][ 09/11] ARM: dts: imx25.dtsi: Add an alias for the Audio
 Multiplexer.
In-Reply-To: <1382349098-11502-1-git-send-email-denis@eukrea.com>
References: <1382349098-11502-1-git-send-email-denis@eukrea.com>
Message-ID: <1382349098-11502-9-git-send-email-denis@eukrea.com>
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
 arch/arm/boot/dts/imx25.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 7c0a019..800fe7f 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -281,7 +281,7 @@
 				};
 			};
 
-			audmux at 43fb0000 {
+			audmux: audmux at 43fb0000 {
 				compatible = "fsl,imx25-audmux", "fsl,imx31-audmux";
 				reg = <0x43fb0000 0x4000>;
 				status = "disabled";
-- 
1.7.9.5
