From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Thu,  5 Oct 2017 10:58:18 +0200
Subject: [PATCH 1/3] ARM: dts: gr-peach: Fix 'leds' node name indent
In-Reply-To: <1507193900-23801-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1507193900-23801-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1507193900-23801-2-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix 'leds' node name indent as it was wrongly aligned.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index f2ddd11..20309ac 100644
--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -53,7 +53,7 @@
 		};
 	};
 
-leds {
+	leds {
 		status = "okay";
 		compatible = "gpio-leds";
 
-- 
2.7.4
