From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 13 Feb 2018 15:15:30 +0100
Subject: [PATCH 4/9] ARM: dts: exynos: Fix "debounce-interval" property
 misspelling
In-Reply-To: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
References: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1518531335-5170-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"debounce-inteval" was never supported.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
Please apply to your tree when appropriate.

 arch/arm/boot/dts/exynos4412-trats2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index f285790e8e047bb8..a1e506054fba7fde 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -157,7 +157,7 @@
 			gpios = <&gpx0 1 GPIO_ACTIVE_LOW>;
 			linux,code = <139>;
 			label = "ok";
-			debounce-inteval = <10>;
+			debounce-interval = <10>;
 			wakeup-source;
 		};
 	};
-- 
2.7.4
