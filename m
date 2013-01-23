From: tobetter@gmail.com (Dongjin Kim)
Date: Thu, 24 Jan 2013 04:09:31 +0900
Subject: [PATCH] ARM: dts: Add EHCI device tree node for Exynos4
Message-ID: <1358968174-28895-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EHCI device node for Exynos4412

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 387aa27..0c8f23b 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -33,4 +33,10 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	ehci at 12580000 {
+		compatible = "samsung,exynos-ehci";
+		reg = <0x12580000 0x100>;
+		interrupts = <0 70 0>;
+	};
 };
-- 
1.7.10.4
