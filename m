From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 2 Feb 2015 14:51:45 +0800
Subject: [PATCH 2/4] ARM: at91: dt: sama5d4ek: enable ssc0
In-Reply-To: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
References: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1422859907-14881-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SSC0 node, which will be used for audio.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d4ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 9198b71..32e9a9a 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -115,6 +115,10 @@
 				};
 			};
 
+			ssc0: ssc at f8008000 {
+				status = "okay";
+			};
+
 			spi0: spi at f8010000 {
 				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
 				status = "okay";
-- 
2.3.0.rc0
