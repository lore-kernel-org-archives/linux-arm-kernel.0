From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 19 Nov 2014 16:56:21 +0100
Subject: [PATCH 1/4] ARM: dts: Add usb3503 pinctrl to exynos5250-spring
In-Reply-To: <1416412585-10809-1-git-send-email-afaerber@suse.de>
References: <1416412585-10809-1-git-send-email-afaerber@suse.de>
Message-ID: <1416412585-10809-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5250-spring.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index f5566f84d885..310764b6e28d 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -52,6 +52,8 @@
 	usb-hub {
 		compatible = "smsc,usb3503a";
 		reset-gpios = <&gpe1 0 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hsic_reset>;
 	};
 
 	fixed-rate-clocks {
-- 
2.1.2
