From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:05 +0200
Subject: [PATCH 03/12] DMAENGINE: fetch tasklet struct for PL08X include file
In-Reply-To: <1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL08X include file is using struct tasklet so let us bring this
in apropriately.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 include/linux/amba/pl08x.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 8435f4a..2bb7ac4 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -20,6 +20,7 @@
 
 /* We need sizes of structs from this header */
 #include <linux/dmaengine.h>
+#include <linux/interrupt.h>
 
 /**
  * struct pl08x_channel_data - data structure to pass info between
-- 
1.6.3.3
