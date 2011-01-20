From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Jan 2011 08:43:31 +0200
Subject: [RESEND PATCH 2/3] arm: Kconfig: remove duplicated SPARSE_IRQ entry
In-Reply-To: <1295505812-5062-1-git-send-email-balbi@ti.com>
References: <1295505812-5062-1-git-send-email-balbi@ti.com>
Message-ID: <1295505812-5062-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPARSE_IRQ is defined under kernel/irq/Kconfig so
it's safe to remove the duplicated entry.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9756f07..c231192 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -530,7 +530,7 @@ config ARCH_MMP
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
@@ -611,7 +611,7 @@ config ARCH_PXA
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-- 
1.7.4.rc2
