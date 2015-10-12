From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Oct 2015 16:28:49 +0200
Subject: [PATCH v2 12/14] ARM: at91: remove useless includes and function
 prototypes
In-Reply-To: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1444660131-14954-13-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove leftover from the previous cleanup

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
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
2.1.4
