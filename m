From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 14 Oct 2013 13:38:32 +0800
Subject: [PATCH 4/5] ARM: at91: enable ssc on at91sam9n12ek board
In-Reply-To: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
References: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1381729113-29714-5-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ssc on at91sam9n12ek board

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 1ba8def..391c532 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -38,6 +38,10 @@
 				status = "okay";
 			};
 
+			ssc0: ssc at f0010000 {
+				status = "okay";
+			};
+
 			i2c0: i2c at f8010000 {
 				status = "okay";
 
-- 
1.7.9.5
