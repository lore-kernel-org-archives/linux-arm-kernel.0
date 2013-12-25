From: zalan.blenessy@gmail.com (Zalan Blenessy)
Date: Wed, 25 Dec 2013 13:11:06 +0100
Subject: [PATCH 1/1] ARM: sunxi: select ARM_PSCI
In-Reply-To: <1387973466-5067-1-git-send-email-zalan.blenessy@gmail.com>
References: <1387973466-5067-1-git-send-email-zalan.blenessy@gmail.com>
Message-ID: <1387973466-5067-2-git-send-email-zalan.blenessy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is necessary for SMP on sun7i.

Signed-off-by: Zalan Blenessy <zalan.blenessy@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 547004c..09df4b81 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -3,6 +3,7 @@ config ARCH_SUNXI
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
+	select ARM_PSCI
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select COMMON_CLK
-- 
1.7.10.4
