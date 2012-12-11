From: cesarb@cesarb.net (Cesar Eduardo Barros)
Date: Tue, 11 Dec 2012 19:49:46 -0200
Subject: [PATCH 04/19] MAINTAINERS: fix drivers/rtc/rtc-vt8500.c
In-Reply-To: <1355262601-4263-1-git-send-email-cesarb@cesarb.net>
References: <1355262601-4263-1-git-send-email-cesarb@cesarb.net>
Message-ID: <1355262601-4263-5-git-send-email-cesarb@cesarb.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e013f00..f5df323 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1232,7 +1232,7 @@ F:	drivers/video/vt8500lcdfb.*
 F:	drivers/video/wm8505fb*
 F:	drivers/video/wmt_ge_rops.*
 F:	drivers/tty/serial/vt8500_serial.c
-F:	drivers/rtc/rtc-vt8500-c
+F:	drivers/rtc/rtc-vt8500.c
 
 ARM/ZIPIT Z2 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
-- 
1.7.11.7
