From: labbott@redhat.com (Laura Abbott)
Date: Wed,  1 Mar 2017 16:15:03 -0800
Subject: [PATCHv2 11/14] module: Use set_memory.h header
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <1488413706-9739-12-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 kernel/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module.c b/kernel/module.c
index 7eba6de..c0f04b3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -49,6 +49,7 @@
 #include <linux/rculist.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/mmu_context.h>
 #include <linux/license.h>
 #include <asm/sections.h>
-- 
2.7.4
