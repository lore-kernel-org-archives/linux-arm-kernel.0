From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue,  9 Jul 2013 16:25:33 +0200
Subject: [PATCH v4 7/7] ARM: AT91: DTS: sam9x5ek: enable SSC
In-Reply-To: <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1373379933-32749-8-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SSC needed for the WM8731 codec

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 2bf51cc..0534c58 100644
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
