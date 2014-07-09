From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  9 Jul 2014 15:40:06 +0200
Subject: [PATCHv2 02/17] ARM: mvebu: sort the #include of pmsu.c in alphabetic
 order
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404913221-17343-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Sorting the headers in alphabetic order will help to reduce conflicts
when adding new headers later.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 5fda549..9e18cce 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -19,13 +19,13 @@
 #define pr_fmt(fmt) "mvebu-pmsu: " fmt
 
 #include <linux/cpu_pm.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_address.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/smp.h>
 #include <linux/resource.h>
+#include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
-- 
2.0.0
