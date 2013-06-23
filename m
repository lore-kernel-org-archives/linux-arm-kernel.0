From: eagle.alexander923@gmail.com (Alexander Shiyan)
Date: Sun, 23 Jun 2013 10:54:49 +0400
Subject: [PATCH 5/6] ARM: dts: imx27-phytec-phycore-som: Define minimal memory
 layout
In-Reply-To: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
References: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
Message-ID: <1371970490-10874-5-git-send-email-eagle.alexander923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shiyan <shc_work@mail.ru>

Define minimal memory layout for i.MX27 PCM-038 module.
This will help to use appended DTB with non-DT capable bootloaders.

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index f010565..76edf59 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -17,7 +17,7 @@
 	compatible = "phytec,imx27-pcm038", "fsl,imx27";
 
 	memory {
-		reg = <0x0 0x0>;
+		reg = <0xa0000000 0x08000000>;
 	};
 
 	soc {
-- 
1.8.1.5
