From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 6 Sep 2013 11:40:45 -0700
Subject: [PATCH v8 2/3] ARM: bcm281xx: Enable GPIO driver
In-Reply-To: <1378492846-3112-1-git-send-email-markus.mayer@linaro.org>
References: <1378492846-3112-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1378492846-3112-3-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn on the bcm281xx GPIO driver in the kernel configuration.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Christian Daudt <csd@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f112895..5819126 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -9,7 +9,7 @@ config ARCH_BCM
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_TIME
-	select GPIO_BCM
+	select GPIO_BCM_KONA
 	select SPARSE_IRQ
 	select TICK_ONESHOT
 	help
-- 
1.7.9.5
