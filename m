From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:37 +0200
Subject: [PATCH 02/20] ARM: dts: axp209: Rename usb_power_supply node to avoid
 warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b00bd68196621f396076dbdc5e84e3d59e558953.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB power supply node in the AXP209 DTSI is using underscores in its
node name, which is generating a warning. Change those underscores for
hyphens.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/axp209.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 3c8fa26e87b7..897103e0a79b 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -107,7 +107,7 @@
 		};
 	};
 
-	usb_power_supply: usb_power_supply {
+	usb_power_supply: usb-power-supply {
 		compatible = "x-powers,axp202-usb-power-supply";
 		status = "disabled";
 	};
-- 
git-series 0.9.1
