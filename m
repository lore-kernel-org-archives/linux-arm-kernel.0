From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Jan 2012 15:55:35 +0100
Subject: [PATCH 2/7] at91 : declare header name
In-Reply-To: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1326293740-15735-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the header and define the macro to prevent multiple inclusion
like the others headers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/pm.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 92d2223..325ef76 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -1,3 +1,16 @@
+/*
+ * AT91 Power Management
+ *
+ * Copyright (C) 2005 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __ARCH_ARM_MACH_AT91_PM
+#define __ARCH_ARM_MACH_AT91_PM
+
 #ifdef CONFIG_ARCH_AT91RM9200
 #include <mach/at91rm9200_mc.h>
 
@@ -116,3 +129,5 @@ static inline u32 sdram_selfrefresh_enable(void)
 	cpu_do_idle()
 
 #endif
+
+#endif
-- 
1.7.4.1
