From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:38 +0300
Subject: [PATCH 09/37] ARM: dts: omap3-tao3530: Remove invalid
 enable-active-low regulator property
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-10-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property isn't part of the regulator-fixed DT bindings and isn't
used by the driver. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap3-tao3530.dtsi | 1 -
 1 file changed, 1 deletion(-)

Cc: linux-omap at vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index 7bd8d9a4f67f..a520b4fdcf20 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -63,7 +63,6 @@
 		regulator-min-microvolt = <3150000>;
 		regulator-max-microvolt = <3150000>;
 		gpio = <&gpio5 29 GPIO_ACTIVE_LOW>;		/* gpio_157 */
-		enable-active-low;
 		startup-delay-us = <10000>;
 	};
 };
-- 
2.4.9
