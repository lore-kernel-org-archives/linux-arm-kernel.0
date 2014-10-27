From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Oct 2014 17:44:48 -0200
Subject: [PATCH RESEND 2/2] ARM: dts: imx6qdl-rex: Remove unneeded 'fsl,
 mode' property
In-Reply-To: <1414439088-5092-1-git-send-email-festevam@gmail.com>
References: <1414439088-5092-1-git-send-email-festevam@gmail.com>
Message-ID: <1414439088-5092-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6qdl-rex boards use sgtl5000 codec and the machine file (imx-sgtl5000)
already sets SSI in slave mode and codec in master mode, so there is no need
for having this property.

Cc: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-rex.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
index df7bcf8..488a640 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -308,7 +308,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
-- 
1.9.1
