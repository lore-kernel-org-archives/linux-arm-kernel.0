From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 1 Oct 2009 20:05:21 -0400
Subject: [PATCH 1/2] ep93xx/micro9: Update maintainer
In-Reply-To: <385aa7580909240739v5e80a95p7de0d09d08a671ce@mail.gmail.com>
References: <385aa7580909240739v5e80a95p7de0d09d08a671ce@mail.gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7424@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

Manfred Gruber has Acked the maintainer change for the Micro9 (ep93xx)
platform.  Is this ok for your patch system?

Regards,
Hartley


-----Original Message-----
From: h.feurstein [mailto:h.feurstein at gmail.com] 
Sent: Thursday, September 24, 2009 7:39 AM
To: Ryan Mallon; linux-arm-kernel
Cc: H Hartley Sweeten; Hubert Feurstein; Manfred Gruber
Subject: [PATCH 1/2] ep93xx/micro9: Update maintainer

ARM: Update Contec Micro9 maintainer and add entry in MAINTAINERS

Signed-off-by: Hubert Feurstein <hubert.feurstein@contec.at>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Manfred Gruber <m.gruber@tirol.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
---
 MAINTAINERS                   |    5 +++++
 arch/arm/mach-ep93xx/micro9.c |   10 ++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1c0b0..1ba98ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -576,6 +576,11 @@ M:	Mike Rapoport <mike@compulab.co.il>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained

+ARM/CONTEC MICRO9 MACHINE SUPPORT
+M:	Hubert Feurstein <hubert.feurstein@contec.at>
+S:	Maintained
+F:	arch/arm/mach-ep93xx/micro9.c
+
 ARM/CORGI MACHINE SUPPORT
 M:	Richard Purdie <rpurdie@rpsys.net>
 S:	Maintained
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 0a313e8..72e7a7d 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -2,7 +2,9 @@
  *  linux/arch/arm/mach-ep93xx/micro9.c
  *
  * Copyright (C) 2006 Contec Steuerungstechnik & Automation GmbH
- *                   Manfred Gruber <manfred.gruber@contec.at>
+ *                    Manfred Gruber <m.gruber@tirol.com>
+ * Copyright (C) 2009 Contec Steuerungstechnik & Automation GmbH
+ *                    Hubert Feurstein <hubert.feurstein@contec.at>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -66,7 +68,7 @@ static void __init micro9h_init_machine(void)
 }

 MACHINE_START(MICRO9, "Contec Hypercontrol Micro9-H")
-	/* Maintainer: Manfred Gruber <manfred.gruber@contec.at> */
+	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
@@ -88,7 +90,7 @@ static void __init micro9m_init_machine(void)
 }

 MACHINE_START(MICRO9M, "Contec Hypercontrol Micro9-M")
-	/* Maintainer: Manfred Gruber <manfred.gruber@contec.at> */
+	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
@@ -110,7 +112,7 @@ static void __init micro9l_init_machine(void)
 }

 MACHINE_START(MICRO9L, "Contec Hypercontrol Micro9-L")
-	/* Maintainer: Manfred Gruber <manfred.gruber@contec.at> */
+	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
-- 
1.6.0.2
