From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  3 Feb 2014 17:37:23 +0100
Subject: [PATCH 3/3] ARM: v7m: add trivial suspend support
In-Reply-To: <1391445443-28971-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1391445443-28971-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1391445443-28971-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e25419817791..41266af5dfc8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2270,7 +2270,7 @@ source "kernel/power/Kconfig"
 config ARCH_SUSPEND_POSSIBLE
 	depends on !ARCH_S5PC100
 	depends on CPU_ARM920T || CPU_ARM926T || CPU_FEROCEON || CPU_SA1100 || \
-		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
+		CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
 	def_bool y
 
 config ARM_CPU_SUSPEND
-- 
1.8.5.3
