From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Sep 2010 16:09:13 +0900
Subject: [PATCH 06/13] ARM: S5P64X0: Update Timer support
In-Reply-To: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1283324960-21629-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates timer support for S5P6440 and S5P6450 SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../include/mach/pwm-clock.h                       |   10 ++++------
 .../include/mach/tick.h                            |   13 +++++++++----
 2 files changed, 13 insertions(+), 10 deletions(-)
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/pwm-clock.h (86%)
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/tick.h (60%)

diff --git a/arch/arm/mach-s5p6440/include/mach/pwm-clock.h b/arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
similarity index 86%
rename from arch/arm/mach-s5p6440/include/mach/pwm-clock.h
rename to arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
index 6a2a02f..19fff8b 100644
--- a/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
+++ b/arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
@@ -1,16 +1,14 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *      Ben Dooks <ben@simtec.co.uk>
  *      http://armlinux.simtec.co.uk/
  *
- * Based on arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
- *
- * S5P6440 - pwm clock and timer support
+ * S5P64X0 - pwm clock and timer support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5p6440/include/mach/tick.h b/arch/arm/mach-s5p64x0/include/mach/tick.h
similarity index 60%
rename from arch/arm/mach-s5p6440/include/mach/tick.h
rename to arch/arm/mach-s5p64x0/include/mach/tick.h
index 2f25c7f..00aa7f1 100644
--- a/arch/arm/mach-s5p6440/include/mach/tick.h
+++ b/arch/arm/mach-s5p64x0/include/mach/tick.h
@@ -1,9 +1,14 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/tick.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/tick.h
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5P6440 - Timer tick support definitions
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S5P64X0 - Timer tick support definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.6.2.5
