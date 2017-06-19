From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 19 Jun 2017 04:44:42 +0200
Subject: [PATCH v5 13/26] MAINTAINERS: Add Actions Semi Owl section
In-Reply-To: <c68b8edf-9609-0147-6eeb-83793dc3adef@suse.de>
References: <c68b8edf-9609-0147-6eeb-83793dc3adef@suse.de>
Message-ID: <20170619024443.10487-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v4 -> v5:
 * Updated arm dts file pattern
 * Added clocksource file patterns
 
 v2 -> v3 -> v4: unchanged
 
 v2: new
 
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d56524402f36..831bfd5cc68b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1036,6 +1036,18 @@ S:	Maintained
 F:	drivers/amba/
 F:	include/linux/amba/bus.h
 
+ARM/ACTIONS SEMI ARCHITECTURE
+M:	Andreas F?rber <afaerber@suse.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+N:	owl
+F:	arch/arm/mach-actions/
+F:	arch/arm/boot/dts/owl-*
+F:	arch/arm64/boot/dts/actions/
+F:	drivers/clocksource/owl-*
+F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+
 ARM/ADS SPHERE MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.12.3
