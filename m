From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 13 Feb 2018 15:15:33 +0100
Subject: [PATCH 7/9] ARM: dts: OMAP5: uevm: Fix "debounce-interval" property
 misspelling
In-Reply-To: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
References: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1518531335-5170-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"debounce_interval" was never supported.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Please apply to your tree when appropriate.

 arch/arm/boot/dts/omap5-uevm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index ec2c8baef62ac00b..592e17fd4eeb7ccd 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -47,7 +47,7 @@
 			gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;	/* gpio3_83 */
 			wakeup-source;
 			autorepeat;
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 		};
 	};
 
-- 
2.7.4
