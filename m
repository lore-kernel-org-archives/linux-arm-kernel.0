From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 10 Jul 2013 17:51:09 +0800
Subject: [PATCH 3/3] arm: atmel: at91sam9n12: correct pin number of gpio-key
In-Reply-To: <1373449869-5083-1-git-send-email-voice.shen@atmel.com>
References: <1373449869-5083-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1373449869-5083-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

correct pin number of gpio-key for at91sam9n12ek board
the pioB4 is connect to LED, the pioB3 use as gpio-key

Signed-off-by: Bo Shen <voice.shen@atmel.com>

---
 arch/arm/boot/dts/at91sam9n12ek.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 3acac62..9f4c601 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -137,7 +137,7 @@
 
 		enter {
 			label = "Enter";
-			gpios = <&pioB 4 GPIO_ACTIVE_LOW>;
+			gpios = <&pioB 3 GPIO_ACTIVE_LOW>;
 			linux,code = <28>;
 			gpio-key,wakeup;
 		};
-- 
1.7.9.5
