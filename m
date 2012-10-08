From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 08 Oct 2012 15:12:48 +0200
Subject: [PATCH] ARM: dts: exynos4: Enable serial controllers on Origen and
 SMDKV310
Message-ID: <1349701968-6675-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds status override of serial nodes to enable used serial ports
on Origen and SMDKV310 board.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts   | 16 ++++++++++++++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index d1a1101..c7295fb 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -57,6 +57,22 @@
 		status = "okay";
 	};
 
+	serial at 13800000 {
+		status = "okay";
+	};
+
+	serial at 13810000 {
+		status = "okay";
+	};
+
+	serial at 13820000 {
+		status = "okay";
+	};
+
+	serial at 13830000 {
+		status = "okay";
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index b87cca2..f634907 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -43,6 +43,22 @@
 		status = "okay";
 	};
 
+	serial at 13800000 {
+		status = "okay";
+	};
+
+	serial at 13810000 {
+		status = "okay";
+	};
+
+	serial at 13820000 {
+		status = "okay";
+	};
+
+	serial at 13830000 {
+		status = "okay";
+	};
+
 	keypad at 100A0000 {
 		samsung,keypad-num-rows = <2>;
 		samsung,keypad-num-columns = <8>;
-- 
1.7.12
