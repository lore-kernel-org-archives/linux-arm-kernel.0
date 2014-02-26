From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 26 Feb 2014 14:24:06 +0900
Subject: [PATCH 2/3] ARM: select COMMON_CLK_SAMSUNG for ARCH_EXYNOS and
 ARCH_S3C64XX
In-Reply-To: <1393392247-6247-1-git-send-email-pankaj.dubey@samsung.com>
References: <1393392247-6247-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1393392247-6247-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e254198..cc8868d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -756,6 +756,7 @@ config ARCH_S3C64XX
 	select CLKDEV_LOOKUP
 	select CLKSRC_SAMSUNG_PWM
 	select COMMON_CLK
+	select COMMON_CLK_SAMSUNG
 	select CPU_V6K
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
@@ -835,6 +836,7 @@ config ARCH_EXYNOS
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_GIC
 	select COMMON_CLK
+	select COMMON_CLK_SAMSUNG
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C2410_I2C if I2C
-- 
1.7.9.5
