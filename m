From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 13 Feb 2018 15:15:34 +0100
Subject: [PATCH 8/9] ARM: dts: Ux500: Fix "debounce-interval" property
 misspelling
In-Reply-To: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
References: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1518531335-5170-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"debounce_interval" was never supported.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
Please apply to your tree when appropriate.

 arch/arm/boot/dts/ste-snowball.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index ade1d0d4e5f45c59..b0b94d05309855f4 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -46,35 +46,35 @@
 		#size-cells = <0>;
 
 		button at 1 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <2>;
 			label = "userpb";
 			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 		};
 		button at 2 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <3>;
 			label = "extkb1";
 			gpios = <&gpio4 23 GPIO_ACTIVE_HIGH>;
 		};
 		button at 3 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <4>;
 			label = "extkb2";
 			gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
 		};
 		button at 4 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <5>;
 			label = "extkb3";
 			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 		};
 		button at 5 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <6>;
 			label = "extkb4";
-- 
2.7.4
