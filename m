From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 10 Oct 2018 19:22:49 +0200
Subject: [PATCH 04/15] Platform: OLPC: Remove an unused include
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Message-ID: <20181010172300.317643-5-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, the header is x86 specific, while there are non-x86 OLPC machines.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-ec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index f99b183d5296..35a21c66cd0d 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/olpc-ec.h>
-#include <asm/olpc.h>
 
 struct ec_cmd_desc {
 	u8 cmd;
-- 
2.19.0
