From: tim.kryger@linaro.org (Tim Kryger)
Date: Wed, 19 Mar 2014 17:12:27 -0700
Subject: [PATCH v4 4/5] ARM: dts: Enable the PWM for bcm28155 AP board
In-Reply-To: <1395274348-25259-1-git-send-email-tim.kryger@linaro.org>
References: <1395274348-25259-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1395274348-25259-5-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark the PWM as enabled on the bcm28155 AP board.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 5ff2382..37c72eb 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -66,6 +66,10 @@
 		status = "okay";
 	};
 
+	pwm: pwm at 3e01a000 {
+		status = "okay";
+	};
+
 	usbotg: usb at 3f120000 {
 		status = "okay";
 	};
-- 
1.7.0.4
