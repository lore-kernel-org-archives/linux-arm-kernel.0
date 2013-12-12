From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 12 Dec 2013 17:12:18 +0100
Subject: [PATCH v3 6/6] ARM: dts: exynos4: Add missing unit-address of sysreg
 node
In-Reply-To: <1386864738-19829-1-git-send-email-t.figa@samsung.com>
References: <1386864738-19829-1-git-send-email-t.figa@samsung.com>
Message-ID: <1386864738-19829-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The node contains reg property, so unit-address suffix should be present
in its name.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 4fed2ad..ee173fe 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -99,7 +99,7 @@
 		reg = <0x10440000 0x1000>;
 	};
 
-	sys_reg: sysreg {
+	sys_reg: sysreg at 10010000 {
 		compatible = "samsung,exynos4-sysreg", "syscon";
 		reg = <0x10010000 0x400>;
 	};
-- 
1.8.4.3
