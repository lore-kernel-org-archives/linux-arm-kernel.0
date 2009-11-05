From: tbm@cyrius.com (Martin Michlmayr)
Date: Thu, 5 Nov 2009 18:15:31 +0000
Subject: [PATCH] Kirkwood: Add QNAP TS-110/TS-210 to Kconfig help text
Message-ID: <20091105181531.GA10076@deprecation.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two new models from QNAP to the help text.  They are compatible
with the TS-119/TS-219 and therefore supported by the current code.
The only difference is that they have less RAM (256 MB instead of
512 MB), a slower CPU (800 MHz vs 1.2 GHz) and a plastic case.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index d58e8b0..8bf09ae 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -33,10 +33,11 @@ config MACH_SHEEVAPLUG
 	  Marvell SheevaPlug Reference Board.
 
 config MACH_TS219
-	bool "QNAP TS-119 and TS-219 Turbo NAS"
+	bool "QNAP TS-110, TS-119, TS-210, TS-219 and TS-219P Turbo NAS"
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  QNAP TS-119 and TS-219 Turbo NAS devices.
+	  QNAP TS-110, TS-119, TS-210, TS-219 and TS-219P Turbo NAS
+	  devices.
 
 config MACH_TS41X
 	bool "QNAP TS-410, TS-410U, TS-419P and TS-419U Turbo NAS"
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index cb0f56d..a7c209d 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -1,6 +1,6 @@
 /*
  *
- * QNAP TS-119/TS-219 Turbo NAS Board Setup
+ * QNAP TS-11x/TS-21x Turbo NAS Board Setup
  *
  * Copyright (C) 2009  Martin Michlmayr <tbm@cyrius.com>
  * Copyright (C) 2008  Byron Bradley <byron.bbradley@gmail.com>

-- 
Martin Michlmayr
http://www.cyrius.com/
