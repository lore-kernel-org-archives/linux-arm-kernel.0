From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 20 Dec 2013 10:52:58 +0800
Subject: [PATCH 3/3] ARM: dts: rename hi4511 dts file
In-Reply-To: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
References: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1387507978-4485-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to follow the name style of DTS that is SoC-board.dts.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/boot/dts/Makefile                          | 2 +-
 arch/arm/boot/dts/{hi4511.dts => hi3620-hi4511.dts} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/boot/dts/{hi4511.dts => hi3620-hi4511.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 40e13e3..92e5499 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -71,7 +71,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos5420-smdk5420.dtb \
 	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb
-dtb-$(CONFIG_ARCH_HI3xxx) += hi4511.dtb
+dtb-$(CONFIG_ARCH_HI3xxx) += hi3620-hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 	ecx-2000.dtb
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
diff --git a/arch/arm/boot/dts/hi4511.dts b/arch/arm/boot/dts/hi3620-hi4511.dts
similarity index 100%
rename from arch/arm/boot/dts/hi4511.dts
rename to arch/arm/boot/dts/hi3620-hi4511.dts
-- 
1.8.3.2
