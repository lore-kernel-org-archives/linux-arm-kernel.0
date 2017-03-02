From: labbott@redhat.com (Laura Abbott)
Date: Wed,  1 Mar 2017 16:15:00 -0800
Subject: [PATCHv2 08/14] intel_th: Use set_memory.h header
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <1488413706-9739-9-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index e88afe1..f0e36c8 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -27,7 +27,7 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include "intel_th.h"
 #include "msu.h"
-- 
2.7.4
