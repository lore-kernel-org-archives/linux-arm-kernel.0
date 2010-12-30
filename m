From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 30 Dec 2010 19:25:02 +0800
Subject: [PATCH v4 3/8] arm: mx51: define mx51's own MXC_GPIO_IRQS
In-Reply-To: <1293708306-20170-2-git-send-email-richard.zhao@freescale.com>
References: <1293708306-20170-1-git-send-email-richard.zhao@freescale.com>
	<1293708306-20170-2-git-send-email-richard.zhao@freescale.com>
Message-ID: <1293708306-20170-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx5 SoCs have different GPIO port count.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 86781f7..769a137 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -29,7 +29,7 @@
 #define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MX25
 #define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MX5
+#elif defined CONFIG_ARCH_MX51
 #define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MXC91231
 #define MXC_GPIO_IRQS		(32 * 4)
-- 
1.6.3.3
