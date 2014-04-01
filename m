From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  1 Apr 2014 16:03:47 +0800
Subject: [PATCH v1 5/8] ARM: mcpm: change max clusters to 4
In-Reply-To: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
References: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1396339430-21084-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support 4 clusters with 4 Cortex A15 Cores in each cluster,
enlarge maximum clusters from 2 to 4 in MCPM.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/include/asm/mcpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 608516e..68f82cf 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -20,7 +20,7 @@
  * to consider dynamic allocation.
  */
 #define MAX_CPUS_PER_CLUSTER	4
-#define MAX_NR_CLUSTERS		2
+#define MAX_NR_CLUSTERS		4
 
 #ifndef __ASSEMBLY__
 
-- 
1.8.3.2
