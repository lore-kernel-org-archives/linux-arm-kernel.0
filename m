From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 23 Jun 2016 12:58:43 +0800
Subject: [PATCH 2/2] arm64: dts: hikey: set bluetooth led trigger
In-Reply-To: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
References: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1466657923-5776-2-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set bluetooth led trigger to hci0-rx, and so LED blinks on hci
frame receiving.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e92a30c..5032792 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -132,7 +132,7 @@
 		bt_active_led {
 			label = "bt_active";
 			gpios = <&gpio4 7 0>; /* <&gpio_bt_active_led>; */
-			linux,default-trigger = "hci0rx";
+			linux,default-trigger = "hci0-rx";
 			default-state = "off";
 		};
 	};
-- 
1.9.1
