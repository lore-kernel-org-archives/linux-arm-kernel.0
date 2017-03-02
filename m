From: labbott@redhat.com (Laura Abbott)
Date: Wed,  1 Mar 2017 16:15:04 -0800
Subject: [PATCHv2 12/14] PM / hibernate: Use set_memory.h header
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <1488413706-9739-13-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 kernel/power/snapshot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 905d5bb..4302815 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -35,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>
+#include <asm/set_memory.h>
 
 #include "power.h"
 
-- 
2.7.4
