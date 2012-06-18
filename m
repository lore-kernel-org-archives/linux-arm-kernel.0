From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 18 Jun 2012 16:01:10 -0300
Subject: [PATCH] ARM: imx23-evk.dts: Fix total RAM size
Message-ID: <1340046070-1955-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx23evk has 64MB of RAM, so fix the RAM size accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-evk.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 70bffa9..00390fb 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -17,7 +17,7 @@
 	compatible = "fsl,imx23-evk", "fsl,imx23";
 
 	memory {
-		reg = <0x40000000 0x08000000>;
+		reg = <0x40000000 0x04000000>;
 	};
 
 	apb at 80000000 {
-- 
1.7.1
