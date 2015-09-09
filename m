From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Wed,  9 Sep 2015 14:30:51 +0200
Subject: [PATCH v3 7/9] ARM: dts: imx6dl-nitrogen6x: change manufacturer to
 Boundary Devices
In-Reply-To: <1441801853-10264-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441801853-10264-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1441801853-10264-8-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-nitrogen6x.dts b/arch/arm/boot/dts/imx6dl-nitrogen6x.dts
index 54bc4cd..8398f97 100644
--- a/arch/arm/boot/dts/imx6dl-nitrogen6x.dts
+++ b/arch/arm/boot/dts/imx6dl-nitrogen6x.dts
@@ -46,6 +46,6 @@
 #include "imx6qdl-nitrogen6x.dtsi"
 
 / {
-	model = "Freescale i.MX6 DualLite Nitrogen6x Board";
-	compatible = "fsl,imx6dl-nitrogen6x", "fsl,imx6dl";
+	model = "Boundary Devices i.MX6 DualLite Nitrogen6x Board";
+	compatible = "boundary,imx6dl-nitrogen6x", "fsl,imx6dl";
 };
-- 
2.5.1
