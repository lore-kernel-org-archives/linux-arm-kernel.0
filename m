From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Jan 2016 17:11:08 +0100
Subject: [PATCH v4 09/13] ARM: at91: remove useless includes and function
 prototypes
In-Reply-To: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1453911072-23608-10-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove leftover from the previous cleanup

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-at91/generic.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index d224e195706a..28ca57a2060f 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -11,13 +11,6 @@
 #ifndef _AT91_GENERIC_H
 #define _AT91_GENERIC_H
 
-#include <linux/of.h>
-#include <linux/reboot.h>
-
- /* Map io */
-extern void __init at91_map_io(void);
-extern void __init at91_alt_map_io(void);
-
 #ifdef CONFIG_PM
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9260_pm_init(void);
-- 
2.5.0
