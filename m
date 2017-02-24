From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 24 Feb 2017 04:40:52 +0100
Subject: [RFC v2 14/17] MAINTAINERS: Add Actions Semi Owl section
In-Reply-To: <20170224034055.18807-1-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
Message-ID: <20170224034055.18807-15-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: new
 
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9af886..467121e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1026,6 +1026,16 @@ S:	Maintained
 F:	drivers/amba/
 F:	include/linux/amba/bus.h
 
+ARM/ACTIONS SEMI ARCHITECTURE
+M:	Andreas F?rber <afaerber@suse.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+N:	owl
+F:	arch/arm/mach-actions/
+F:	arch/arm/boot/dts/s500*
+F:	arch/arm64/boot/dts/actions/
+F:	Documentation/devicetree/bindings/arm/actions.txt
+
 ARM/ADS SPHERE MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.10.2
