From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 06:51:41 +0200
Subject: [PATCH 3/5] rtc-pxa: remove unused TIMER_FREQ define
Message-ID: <20101020045141.GZ12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 drivers/rtc/rtc-pxa.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 29e867a..486b72d 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -30,7 +30,6 @@
 
 #include <mach/hardware.h>
 
-#define TIMER_FREQ		CLOCK_TICK_RATE
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
 #define MAXFREQ_PERIODIC	1000
-- 
1.7.2.3
