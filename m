From: marek@goldelico.com (Marek Belisko)
Date: Sat,  1 Mar 2014 14:58:51 +0100
Subject: [PATCH v2 4/7] ARM: dts: omap3-gta04: Add twl4030 charger
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Message-ID: <1393682334-26805-5-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neilb@suse.de>

Define twl4030 charger node used for charging.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 7f29315..42fc12e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -186,3 +186,7 @@
 	pinctrl-0 = <&uart3_pins>;
 };
 
+&charger {
+	bb_uvolt = <3200000>;
+	bb_uamp = <150>;
+};
-- 
1.8.3.2
