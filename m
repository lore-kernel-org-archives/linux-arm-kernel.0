From: labbott@redhat.com (Laura Abbott)
Date: Wed,  1 Mar 2017 16:15:05 -0800
Subject: [PATCHv2 13/14] ALSA: hda: Use set_memory.h header
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <1488413706-9739-14-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 16108f0e..e3d8756 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -53,7 +53,7 @@
 #ifdef CONFIG_X86
 /* for snoop control */
 #include <asm/pgtable.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/cpufeature.h>
 #endif
 #include <sound/core.h>
-- 
2.7.4
