From: tim.kryger@linaro.org (Tim Kryger)
Date: Mon, 18 Nov 2013 10:55:00 -0800
Subject: [PATCH 4/5] ARM: dts: Enable the PWM for bcm28155 AP board
In-Reply-To: <1384800901-21711-1-git-send-email-tim.kryger@linaro.org>
References: <1384800901-21711-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1384800901-21711-5-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark the PWM as enabled on the bcm28155 AP board.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 08e47c2..2dfca32 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -43,4 +43,8 @@
 		cd-gpios = <&gpio 14 0>;
 		status = "okay";
 	};
+
+	pwm: pwm at 3e01a000 {
+		status = "okay";
+	};
 };
-- 
1.8.0.1
