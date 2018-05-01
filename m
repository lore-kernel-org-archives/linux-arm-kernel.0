From: linux.amoon@gmail.com (Anand Moon)
Date: Wed,  2 May 2018 00:29:01 +0530
Subject: [PATCH 1/2] ARM64: dts: meson-gxbb: odroidc2: enable sdcard UHS modes
Message-ID: <20180501185902.3556-1-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable UHS modes for sdcard, on odroidc2.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 54954b314a45..c90f8b46c60c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -258,6 +258,11 @@
 	cap-sd-highspeed;
 	max-frequency = <100000000>;
 	disable-wp;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
-- 
2.17.0
