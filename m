From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Tue, 15 Apr 2014 16:25:07 +0200
Subject: [PATCH] arm: dts: exynos4412-trats2: rename alias for i2c_ak8975 label
Message-ID: <534D4143.3050801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c_ak8975 controler uses label i2c8.
This alias is already used for I2C controller 8 defined
in file arch/arm/boot/dts/exynos4.dtsi.

This patch renames a label for i2c_ak8975 to i2c9.

Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index c16b315..5add765 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -20,7 +20,7 @@
 	compatible = "samsung,trats2", "samsung,exynos4412", "samsung,exynos4";

 	aliases {
-		i2c8 = &i2c_ak8975;
+		i2c9 = &i2c_ak8975;
 	};

 	memory {
