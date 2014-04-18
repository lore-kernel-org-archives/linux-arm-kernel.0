From: tim.kryger@linaro.org (Tim Kryger)
Date: Fri, 18 Apr 2014 09:44:53 -0700
Subject: [PATCH v6 4/5] ARM: dts: Enable the PWM for bcm28155 AP board
In-Reply-To: <1397839494-21049-1-git-send-email-tim.kryger@linaro.org>
References: <1397839494-21049-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1397839494-21049-5-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark the PWM as enabled on the bcm28155 AP board.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index af3da55..9ce91dd 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -69,6 +69,10 @@
 		status = "okay";
 	};
 
+	pwm: pwm at 3e01a000 {
+		status = "okay";
+	};
+
 	usbotg: usb at 3f120000 {
 		vusb_d-supply = <&usbldo_reg>;
 		vusb_a-supply = <&iosr1_reg>;
-- 
1.7.9.5
