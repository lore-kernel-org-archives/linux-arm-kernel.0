From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:39 +0100
Subject: [PATCH 42/47] ARM: dts: kzm9d: Fix "debounce-interval" property
 misspelling
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <b1798f2a97dacade8c6db97074b0f36327c77bcc.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

"debounce_interval" was never supported.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 60d0a732833a..c238407133bf 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -38,28 +38,28 @@
 		#size-cells = <0>;
 
 		one {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			label = "DSW2-1";
 			linux,code = <KEY_1>;
 			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
 		};
 		two {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			label = "DSW2-2";
 			linux,code = <KEY_2>;
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
 		three {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			label = "DSW2-3";
 			linux,code = <KEY_3>;
 			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 		};
 		four {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			label = "DSW2-4";
 			linux,code = <KEY_4>;
-- 
2.11.0
