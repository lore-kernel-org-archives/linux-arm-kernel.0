From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue,  8 Sep 2015 16:34:43 +0200
Subject: [PATCH v2 6/9] ARM: dts: imx6q-nitrogen6x: change manufacturer to
 Boundary Devices
In-Reply-To: <1441722886-22798-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441722886-22798-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1441722886-22798-7-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6q-nitrogen6x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-nitrogen6x.dts b/arch/arm/boot/dts/imx6q-nitrogen6x.dts
index 8088cfc..d168633 100644
--- a/arch/arm/boot/dts/imx6q-nitrogen6x.dts
+++ b/arch/arm/boot/dts/imx6q-nitrogen6x.dts
@@ -46,8 +46,8 @@
 #include "imx6qdl-nitrogen6x.dtsi"
 
 / {
-	model = "Freescale i.MX6 Quad Nitrogen6x Board";
-	compatible = "fsl,imx6q-nitrogen6x", "fsl,imx6q";
+	model = "Boundary Devices i.MX6 Quad Nitrogen6x Board";
+	compatible = "boundary,imx6q-nitrogen6x", "fsl,imx6q";
 };
 
 &sata {
-- 
2.5.1
