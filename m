From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jun 2014 15:22:42 +0200
Subject: [PATCH 01/16] ARM: mvebu: Sort the headers of pmsu.c in alphabetic
 order
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1403875377-940-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorting the headers in alphabetic order will help to reduce the
conflict when adding new headers later.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index a1d407c0febe..5584d35b8e88 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -19,13 +19,13 @@
 #define pr_fmt(fmt) "mvebu-pmsu: " fmt
 
 #include <linux/cpu_pm.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_address.h>
+#include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/smp.h>
 #include <linux/resource.h>
+#include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
-- 
1.8.1.2
