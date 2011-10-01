From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:36 +0200
Subject: [PATCH 04/26] net/pxa168_eth: add missing include of interrupt.h
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

interrupt.h is no longer implicitly included here, so manually
add it instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/pxa168_eth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/pxa168_eth.c b/drivers/net/pxa168_eth.c
index 1a3033d..d5a6cfc 100644
--- a/drivers/net/pxa168_eth.c
+++ b/drivers/net/pxa168_eth.c
@@ -41,6 +41,7 @@
 #include <linux/phy.h>
 #include <linux/io.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/cacheflush.h>
-- 
1.7.5.4
