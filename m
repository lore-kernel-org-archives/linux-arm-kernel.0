From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 30 Jul 2013 11:59:50 +0200
Subject: [PATCH v6 6/8] ARM: AT91: DTS: sam9x5ek: enable SSC
In-Reply-To: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
References: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1375178392-26060-7-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SSC needed for the WM8731 codec

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index e6fb309..f3e83f7 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -95,6 +95,10 @@
 			watchdog at fffffe40 {
 				status = "okay";
 			};
+
+			ssc0: ssc at f0010000 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci at 00600000 {
-- 
1.7.10.4
