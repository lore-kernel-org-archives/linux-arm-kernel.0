From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:48:21 +0200
Subject: [PATCH 0088/1529] Fix typo
Message-ID: <20160521114821.3925-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 97b22fa..a6fb752 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -98,7 +98,7 @@ void read_boot_clock64(struct timespec64 *ts)
 int __init register_persistent_clock(clock_access_fn read_boot,
 				     clock_access_fn read_persistent)
 {
-	/* Only allow the clockaccess functions to be registered once */
+	/* Only allow the clock access functions to be registered once */
 	if (__read_persistent_clock == dummy_clock_access &&
 	    __read_boot_clock == dummy_clock_access) {
 		if (read_boot)
-- 
2.8.2.534.g1f66975
