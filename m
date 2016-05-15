From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 May 2016 22:13:50 +0200
Subject: [PATCH v4 09/22] ARM: dts: exynos: Prepare for inclusion of
 exynos5.dtsi in exynos5410.dtsi
In-Reply-To: <1463343243-26429-1-git-send-email-krzk@kernel.org>
References: <1463343243-26429-1-git-send-email-krzk@kernel.org>
Message-ID: <1463343243-26429-10-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'sromc' label to SROM memory controller in common exynos5.dtsi so it
can be referenced by inheriting DTSI.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index c5d198c70b86..30a0b63b06c9 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -35,7 +35,7 @@
 		reg = <0x10000000 0x100>;
 	};
 
-	memory-controller at 12250000 {
+	sromc: memory-controller at 12250000 {
 		compatible = "samsung,exynos4210-srom";
 		reg = <0x12250000 0x14>;
 	};
-- 
2.5.0
