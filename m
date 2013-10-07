From: tim.kryger@linaro.org (Tim Kryger)
Date: Mon, 7 Oct 2013 12:15:01 -0700
Subject: [PATCH 4/4] ARM: dts: bcm28155-ap: Enable all the i2c busses
In-Reply-To: <1381173301-23830-1-git-send-email-tim.kryger@linaro.org>
References: <1381173301-23830-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1381173301-23830-5-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all available i2c busses.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Christian Daudt <csd@broadcom.com>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 08e47c2..bab302d 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -27,6 +27,26 @@
 		status = "okay";
 	};
 
+	i2c at 3e016000 {
+		status="okay";
+		clock-frequency = <400000>;
+	};
+
+	i2c at 3e017000 {
+		status="okay";
+		clock-frequency = <400000>;
+	};
+
+	i2c at 3e018000 {
+		status="okay";
+		clock-frequency = <400000>;
+	};
+
+	i2c at 3500d000 {
+		status="okay";
+		clock-frequency = <400000>;
+	};
+
 	sdio1: sdio at 3f180000 {
 		max-frequency = <48000000>;
 		status = "okay";
-- 
1.8.0.1
