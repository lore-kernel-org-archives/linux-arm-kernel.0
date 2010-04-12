From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 20:12:11 +0100
Subject: [PATCH 01/16] rtc: remove unused #include <linux/version.h>
In-Reply-To: <1270727313-1212-1-git-send-email-weiyi.huang@gmail.com>
References: <1270727313-1212-1-git-send-email-weiyi.huang@gmail.com>
Message-ID: <20100412191211.GK3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Weiyi <weiyi.huang@gmail.com>

Remove unused #include <linux/version.h>('s) in
  drivers/rtc/rtc-pl031.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/rtc/rtc-pl031.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 3587d99..cfbe129 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -23,7 +23,6 @@
 #include <linux/io.h>
 #include <linux/bcd.h>
 #include <linux/delay.h>
-#include <linux/version.h>
 #include <linux/slab.h>
 
 /*
-- 
1.6.1.3
