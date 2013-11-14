From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 14 Nov 2013 14:02:08 -0700
Subject: [PATCH 2/8] ARM: dts: imx: imx6qdl.dtsi: add mipi_csi tag
In-Reply-To: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1384462934-17390-3-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will reference mipi_csi from board
dts files.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index dcab03b..8a38161 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -839,7 +839,7 @@
 				status = "disabled";
 			};
 
-			mipi at 021dc000 { /* MIPI-CSI */
+			mipi_csi: mipi at 021dc000 {
 				reg = <0x021dc000 0x4000>;
 			};
 
-- 
1.8.1.2
