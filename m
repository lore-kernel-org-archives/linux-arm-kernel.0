From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Oct 2012 22:22:59 +0200
Subject: [PATCH] ARM: dts: compile Integrator device trees
Message-ID: <1350073379-23512-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes sure that the ARM Integrator device trees get compiled
during build.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c1ce813..f37cf9f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -25,6 +25,8 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-trats.dtb \
 	exynos5250-smdk5250.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
+dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
+	integratorcp.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 	kirkwood-dns325.dtb \
-- 
1.7.11.4
