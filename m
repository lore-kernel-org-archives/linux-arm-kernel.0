From: cesarb@cesarb.net (Cesar Eduardo Barros)
Date: Fri, 23 Nov 2012 22:26:28 -0200
Subject: [PATCH 04/24] MAINTAINERS: fix drivers/rtc/rtc-vt8500.c
In-Reply-To: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
Message-ID: <1353716808-16375-5-git-send-email-cesarb@cesarb.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bdd5f3..c67b991 100644
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
