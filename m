From: marek@goldelico.com (Marek Belisko)
Date: Tue, 30 Sep 2014 22:17:34 +0200
Subject: [PATCH 3/3] arm: dts: omap3-gta04: Extend touchscreen configs
In-Reply-To: <1412108254-19234-1-git-send-email-marek@goldelico.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com>
Message-ID: <1412108254-19234-4-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding min/max values for various touschscreen properties.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fd34f91..2dafac3b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -284,6 +284,12 @@
 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <600>;
+		ti,min-x = <0x100>;
+		ti,max-x = <0xf00>;
+		ti,min-y = <0xf00>;
+		ti,max-y = <0x100>;
+		ti,min-rt = <0xfff>;
+		ti,max-rt = <0>;
 	};
 };
 
-- 
1.9.3
