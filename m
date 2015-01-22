From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:15 +0100
Subject: [PATCH 09/13] ARM: dts: omap3-gta04: enable power-off for wifi card.
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-10-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neil@brown.name>

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b65b5ed..ab5dd98 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -327,6 +327,7 @@
 	vmmc-supply = <&vaux4>;
 	bus-width = <4>;
 	ti,non-removable;
+	cap-power-off-card;
 };
 
 &mmc3 {
-- 
1.9.1
