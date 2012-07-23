From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 24 Jul 2012 04:19:37 +1200
Subject: [PATCH] ARM: vt8500: Add maintainer for VT8500 architecture
Message-ID: <1343060377-2606-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MAINTAINERS entry for mach-vt8500 and related files.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Acked-by: Alexey Charkov <alchark@gmail.com>
---
 MAINTAINERS |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb22272..e83a327 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1175,6 +1175,17 @@ S:	Maintained
 F:	arch/arm/mach-pxa/vpac270.c
 F:	arch/arm/mach-pxa/include/mach/vpac270.h
 
+ARM/VT8500 ARM ARCHITECTURE
+M:	Tony Prisk <linux@prisktech.co.nz>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-vt8500/
+F:	drivers/video/vt8500lcdfb.*
+F:	drivers/video/wm8505fb*
+F:	drivers/video/wmt_ge_rops.*
+F:	drivers/tty/serial/vt8500_serial.c
+F:	drivers/rtc/rtc-vt8500-c
+
 ARM/ZIPIT Z2 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.2.5
