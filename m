From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon,  1 Jul 2013 10:39:32 +0200
Subject: [RFC PATCH 07/13] ARM: AT91: DTS: sam9x5ek: enable SSC
In-Reply-To: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1372667978-4718-8-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SSC needed for the WM8731 codec

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 77e4073..4f3584c 100644
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
