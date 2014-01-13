From: b20788@freescale.com (Anson Huang)
Date: Mon, 13 Jan 2014 13:58:35 +0800
Subject: [PATCH V3 2/5] ARM: dts: imx6dl: Remove unnecessary node
In-Reply-To: <1389592718-9999-1-git-send-email-b20788@freescale.com>
References: <1389592718-9999-1-git-send-email-b20788@freescale.com>
Message-ID: <1389592718-9999-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMUXC node is included in i.mx6qdl.dtsi, so no need
to overwrite it, as it is a reused module from i.mx6q.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index e2ec0fb..d590d8d 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -61,10 +61,6 @@
 		};
 
 		aips1: aips-bus at 02000000 {
-			iomuxc: iomuxc at 020e0000 {
-				compatible = "fsl,imx6dl-iomuxc";
-			};
-
 			pxp: pxp at 020f0000 {
 				reg = <0x020f0000 0x4000>;
 				interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.7.9.5
