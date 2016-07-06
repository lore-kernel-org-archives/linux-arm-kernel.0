From: ayaka@soulik.info (ayaka)
Date: Wed,  6 Jul 2016 23:25:22 +0800
Subject: [PATCH 1/3] ARM: dts: add label leds for rk3288-firefly.dtsi
In-Reply-To: <1467818724-21500-1-git-send-email-ayaka@soulik.info>
References: <1467818724-21500-1-git-send-email-ayaka@soulik.info>
Message-ID: <1467818724-21500-2-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The connected leds are different in firefly and firefly reload.
Adding this label making it is possible to add more leds.

Signed-off-by: ayaka <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index d6cf9ad..1d7f03c 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -99,7 +99,7 @@
 		};
 	};
 
-	leds {
+	leds: leds {
 		compatible = "gpio-leds";
 
 		work {
-- 
2.7.4
