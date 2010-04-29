From: PeterHuewe@gmx.de (Peter =?iso-8859-1?q?H=FCwe?=)
Date: Thu, 29 Apr 2010 02:29:52 +0200
Subject: [PATCH] arm/mach-msm: Fix wrong include path.
Message-ID: <201004290229.53378.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>

This patch fixes a build failure[1] caused by a wrong include path.

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2535826/

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next-20100429

 arch/arm/mach-msm/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/devices.c b/arch/arm/mach-msm/devices.c
index 29b1cd6..982f1da 100644
--- a/arch/arm/mach-msm/devices.c
+++ b/arch/arm/mach-msm/devices.c
@@ -24,7 +24,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
-#include <asm/mach/mmc.h>
+#include <mach/mmc.h>
 
 static struct resource resources_uart1[] = {
 	{
-- 
1.6.4.4
