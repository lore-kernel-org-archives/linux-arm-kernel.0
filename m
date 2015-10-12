From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:37 +0300
Subject: [PATCH 08/37] ARM: dts: omap3-sb-t35: Remove invalid
 enable-active-low regulator property
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-9-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property isn't part of the regulator-fixed DT bindings and isn't
used by the driver. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap3-sb-t35.dtsi | 1 -
 1 file changed, 1 deletion(-)

Cc: linux-omap at vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index 827f614261f6..b77e25d20e07 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -50,7 +50,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&sb_t35_audio_amp>;
 		gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;   /* gpio_61 */
-		enable-active-low;
 		regulator-always-on;
 	};
 };
-- 
2.4.9
