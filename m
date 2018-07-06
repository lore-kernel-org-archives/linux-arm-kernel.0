From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  6 Jul 2018 11:16:58 +0200
Subject: [PATCH v2] ARM: dts: atlas7: Fix "debounce-interval" property
 misspelling
Message-ID: <20180706091658.596-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"debounce_interval" was never supported.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 arch/arm/boot/dts/atlas7-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7-evb.dts b/arch/arm/boot/dts/atlas7-evb.dts
index 900e03b7a7b21011..d2972c3205e5dbff 100644
--- a/arch/arm/boot/dts/atlas7-evb.dts
+++ b/arch/arm/boot/dts/atlas7-evb.dts
@@ -120,7 +120,7 @@
 				label = "rearview key";
 				linux,code = <KEY_CAMERA>;
 				gpios = <&gpio_1 3 GPIO_ACTIVE_LOW>;
-				debounce_interval = <100>;
+				debounce-interval = <100>;
 			};
 		};
 
-- 
2.17.1
