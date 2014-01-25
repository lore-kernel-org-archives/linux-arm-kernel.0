From: marek@goldelico.com (Marek Belisko)
Date: Sat, 25 Jan 2014 22:29:00 +0100
Subject: [PATCH 6/9] ARM: dts: omap3-gta04: Add twl4030 charger.
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Message-ID: <1390685343-11663-7-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index a924a843..f72e408 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -198,3 +198,7 @@
 	pinctrl-0 = <&uart3_pins>;
 };
 
+&charger {
+	bb_uvolt = <3200000>;
+	bb_uamp = <150>;
+};
-- 
1.8.3.2
