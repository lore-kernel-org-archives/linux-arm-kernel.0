From: cesarb@cesarb.net (Cesar Eduardo Barros)
Date: Sat,  2 Mar 2013 22:53:40 -0300
Subject: [PATCH 02/14] MAINTAINERS: remove arch/arm/plat-nomadik/
In-Reply-To: <1362275632-20242-1-git-send-email-cesarb@cesarb.net>
References: <1362275632-20242-1-git-send-email-cesarb@cesarb.net>
Message-ID: <1362275632-20242-3-git-send-email-cesarb@cesarb.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The files within that directory were moved to other places over the
course of several commits. I only added the ones moved in the patch
series which finally removed the directory; untangling the rest will
take more work, since some seem to be shared with ux500.

In fact, the ARM/Ux500 ARM ARCHITECTURE block has patterns for files
named "nomadik" too. The patterns in this pair of MAINTAINER blocks
really need a review from the respective maintainters.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b64aa5..3c074d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1009,8 +1009,11 @@ M:	STEricsson <STEricsson_nomadik_linux@list.st.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-nomadik/
-F:	arch/arm/plat-nomadik/
+F:	drivers/clocksource/nomadik-mtu.c
 F:	drivers/i2c/busses/i2c-nomadik.c
+F:	include/linux/platform_data/clocksource-nomadik-mtu.h
+F:	include/linux/platform_data/dma-ste-dma40.h
+F:	include/linux/platform_data/pinctrl-nomadik.h
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 
 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
-- 
1.7.11.7
