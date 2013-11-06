From: denis@eukrea.com (Denis Carikli)
Date: Wed,  6 Nov 2013 09:52:17 +0100
Subject: [PATCHv12][ 6/8] ARM: dts: imx25.dtsi: label the iomuxc.
In-Reply-To: <1383727939-4190-1-git-send-email-denis@eukrea.com>
References: <1383727939-4190-1-git-send-email-denis@eukrea.com>
Message-ID: <1383727939-4190-6-git-send-email-denis@eukrea.com>
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
ChangeLog v10->v11:
- Only the label addition was kept in this commit.
- The commit message was adapted accordingly.

ChangeLog v9->v10:
- New patch made from the remaining parts of the "ARM: dts: imx25.dtsi: Add
  some pinmux pins." patch in the old serie.
---
 arch/arm/boot/dts/imx25.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index ca8a20f..1a86eab 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -175,7 +175,7 @@
 				status = "disabled";
 			};
 
-			iomuxc at 43fac000{
+			iomuxc: iomuxc at 43fac000 {
 				compatible = "fsl,imx25-iomuxc";
 				reg = <0x43fac000 0x4000>;
 			};
-- 
1.7.9.5
