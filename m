From: b20788@freescale.com (Anson Huang)
Date: Mon, 13 Jan 2014 19:53:48 +0800
Subject: [PATCH V4 3/6] ARM: dts: imx6dl: add common compatible name for
 reused modules
In-Reply-To: <1389614031-7253-1-git-send-email-b20788@freescale.com>
References: <1389614031-7253-1-git-send-email-b20788@freescale.com>
Message-ID: <1389614031-7253-3-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As some modules are common for all i.MX6 SOCs, to avoid
checking cpu type for drivers that needs them, just add a
new compatible name for them.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index e2ec0fb..0d264b7 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -62,7 +62,7 @@
 
 		aips1: aips-bus at 02000000 {
 			iomuxc: iomuxc at 020e0000 {
-				compatible = "fsl,imx6dl-iomuxc";
+				compatible = "fsl,imx6dl-iomuxc", "fsl,iomuxc";
 			};
 
 			pxp: pxp at 020f0000 {
-- 
1.7.9.5
