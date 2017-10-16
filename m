From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 16 Oct 2017 17:46:26 +0530
Subject: [PATCH 8/9] ARM: dts: rockchip: Add io domains for rk3288-vyasa
In-Reply-To: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1508156187-27519-9-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add io domains supported by rk3288-vyasa board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index 2f1389a..0e0995f 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -374,6 +374,21 @@
 	};
 };
 
+&io_domains {
+	status = "okay";
+
+	audio-supply = <&vcc_18>;
+	bb-supply = <&vcc_io>;
+	dvp-supply = <&vcc_io>;
+	flash0-suuply = <&vcc_18>;
+	flash1-supply = <&vcc_lan>;
+	gpio30-supply = <&vcc_io>;
+	gpio1830 = <&vcc_io>;
+	lcdc-supply = <&vcc_io>;
+	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vcc_18>;
+};
+
 &i2c2 {
 	status = "okay";
 };
-- 
2.7.4
