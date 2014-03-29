From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 29 Mar 2014 10:48:25 +0400
Subject: [PATCH] ARM: dts: imx27-phytec-phycore-rdk: Add display control
 signal definitions
Message-ID: <1396075706-25384-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds display control signal definitions.
These fields are not used in the driver yet, but will be used for
reference to indicate the polarity of the signals.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 4a43bfd..9117a3c 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -30,6 +30,10 @@
 				vback-porch = <7>;
 				vsync-len = <1>;
 				vfront-porch = <9>;
+				pixelclk-active = <1>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <0>;
 			};
 		};
 	};
-- 
1.8.3.2
