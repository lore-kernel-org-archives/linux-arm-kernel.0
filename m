From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon,  6 Nov 2017 12:38:16 +0530
Subject: [PATCH v2 4/4] arm64: dts: hisilicon: hi3660-hikey960: Allow USR4 LED
 to notify kernel panic
In-Reply-To: <cover.1509951550.git.amit.kucheria@linaro.org>
References: <cover.1509951550.git.amit.kucheria@linaro.org>
Message-ID: <ff7260c53afbe5d1c8d7f6bdf1d297fec2750d8d.1509951550.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Blink the LED on a kernel panic.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Guodong Xu <guodong.xu@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index e9f87cb..1cf77ee 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -109,6 +109,7 @@
 			label = "user_led4";
 			/* gpio_190_user_led4 */
 			gpios = <&gpio23 6 0>;
+			panic-indicator;
 			linux,default-trigger = "cpu0";
 		};
 
-- 
2.7.4
