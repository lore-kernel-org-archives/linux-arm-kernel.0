From: tiny.windzz@gmail.com (Yangtao Li)
Date: Thu,  1 Nov 2018 11:25:31 -0400
Subject: [PATCH] arm64: kdump: fix small typo
Message-ID: <20181101152531.22489-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index f46d57c31443..6b5037ed15b2 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -58,7 +58,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 /**
  * elfcorehdr_read - read from ELF core header
  * @buf: buffer where the data is placed
- * @csize: number of bytes to read
+ * @count: number of bytes to read
  * @ppos: address in the memory
  *
  * This function reads @count bytes from elf core header which exists
-- 
2.17.0
