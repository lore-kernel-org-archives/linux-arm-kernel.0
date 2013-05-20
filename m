From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 May 2013 18:25:58 +0200
Subject: [PATCH 5/7] ARM: at91: sam9x5ek add udc DT support
In-Reply-To: <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130520162149.GC9937@game.jcrosoft.org>
 <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1369067160-3230-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 19c8ebb..5e10027 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -52,6 +52,11 @@
 				status = "okay";
 			};
 
+			usb2: gadget at f803c000 {
+				atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
 			i2c0: i2c at f8010000 {
 				status = "okay";
 			};
-- 
1.7.10.4
