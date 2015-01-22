From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:18 +0100
Subject: [PATCH 12/13] ARM: dts: omap3-gta04: uart4 is not connected,
 so mark it "disabled"
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-13-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neil@brown.name>

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 228e79b..8d2b0a1 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -357,6 +357,10 @@
 	pinctrl-0 = <&uart3_pins>;
 };
 
+&uart4 {
+	status = "disabled";
+};
+
 &charger {
 	ti,bb-uvolt = <3200000>;
 	ti,bb-uamp = <150>;
-- 
1.9.1
