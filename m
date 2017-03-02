From: labbott@redhat.com (Laura Abbott)
Date: Wed,  1 Mar 2017 16:15:02 -0800
Subject: [PATCHv2 10/14] bpf: Use set_memory.h header
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <1488413706-9739-11-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0c167fd..c2b403f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -18,7 +18,7 @@
 
 #include <net/sch_generic.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include <uapi/linux/filter.h>
 #include <uapi/linux/bpf.h>
-- 
2.7.4
