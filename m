From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 14 May 2017 04:24:29 +0200
Subject: [PATCH v3 5/5] MAINTAINERS: Add Realtek section
In-Reply-To: <20170514022429.11555-1-afaerber@suse.de>
References: <20170514022429.11555-1-afaerber@suse.de>
Message-ID: <20170514022429.11555-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as maintainer.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Changed status to Maintained
 
 v2: new
 
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ae4f7975b19..92c65bbc4ef3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1678,6 +1678,13 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/REALTEK ARCHITECTURE
+M:	Andreas F?rber <afaerber@suse.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/realtek/
+F:	Documentation/devicetree/bindings/arm/realtek.txt
+
 ARM/RENESAS ARM64 ARCHITECTURE
 M:	Simon Horman <horms@verge.net.au>
 M:	Magnus Damm <magnus.damm@gmail.com>
-- 
2.12.0
