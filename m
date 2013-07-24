From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 12:37:52 +0900
Subject: [PATCH 04/08] ARM: shmobile: Remove r8a7779 use of <mach/hardware.h>
In-Reply-To: <20130724033715.30567.82782.sendpatchset@w520>
References: <20130724033715.30567.82782.sendpatchset@w520>
Message-ID: <20130724033752.30567.70305.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on r8a7779.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7779.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2013-07-23 16:02:42.000000000 +0900
@@ -36,7 +36,6 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
