From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:13 +0200
Subject: [PATCH v4 15/28] MAINTAINERS: Add Actions Semi Owl section
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-16-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3 -> v4: unchanged
 
 v2: new
 
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f17ffa17abef..a9faa30def9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1036,6 +1036,16 @@ S:	Maintained
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
2.12.3
