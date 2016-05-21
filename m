From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:48:14 +0200
Subject: [PATCH 0087/1529] Fix typo
Message-ID: <20160521114814.3868-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/kernel/sys_oabi-compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 087acb5..e3e0c00 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -58,7 +58,7 @@
  * sys_semtimedop:
  *
  *   struct sembuf loses its padding with EABI.  Since arrays of them are
- *   used they have to be copyed to remove the padding. Compatibility wrappers
+ *   used they have to be copied to remove the padding. Compatibility wrappers
  *   provided below.
  *
  * sys_bind:
-- 
2.8.2.534.g1f66975
