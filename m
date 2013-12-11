From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 11 Dec 2013 14:07:35 +0100
Subject: [PATCH 4/8] Makefile: disable generating Thumb code
In-Reply-To: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1386767259-15693-5-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 29575cc..bddec8b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
-CFLAGS+=-Wall -ffreestanding
+CFLAGS+=-Wall -ffreestanding -marm
 LDFLAGS=-static -nostdlib
 GCC=$(CROSS_COMPILE)gcc
 OBJCOPY=$(CROSS_COMPILE)objcopy
-- 
1.7.9.5
