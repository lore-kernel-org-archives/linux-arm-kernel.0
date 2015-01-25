From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 25 Jan 2015 13:19:15 +0800
Subject: [PATCH] MAINTAINERS: update timer-marco to timer-atlas7
Message-ID: <1422163155-7764-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

as the driver name of timer-marco has been changed to timer-atlas7,
this patch changes the MAINTAINER entry.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bed045..819730f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -958,7 +958,7 @@ S:	Maintained
 F:	arch/arm/mach-prima2/
 F:	drivers/clk/sirf/
 F:	drivers/clocksource/timer-prima2.c
-F:	drivers/clocksource/timer-marco.c
+F:	drivers/clocksource/timer-atlas7.c
 N:	[^a-z]sirf
 
 ARM/EBSA110 MACHINE SUPPORT
-- 
1.9.1
