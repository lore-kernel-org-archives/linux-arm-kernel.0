From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:22 +0200
Subject: [PATCH 13/32] bcm2837-rpi-3-b.dts: add gpio
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-14-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 6f47dd2..e0f429b 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -25,6 +25,19 @@
 	};
 };
 
+&gpio {
+	pinctrl-0 = <&i2c0_gpio0
+		     &i2c1_gpio2
+		     &gpclk0_gpio4
+		     &gpclk1_gpio5
+		     &spi0_gpio7
+		     &pcm_gpio18
+		     &pwm0_gpio40
+		     &pwm1_gpio45
+		     &gpioout
+		     &alt3>;
+};
+
 &uart1 {
 	status = "okay";
 };
-- 
1.8.3.1
