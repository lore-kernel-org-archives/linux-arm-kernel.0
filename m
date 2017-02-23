From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 23 Feb 2017 17:45:52 +0100
Subject: [PATCH v2 5/5] MAINTAINERS: Add Realtek section
In-Reply-To: <20170223164553.3715-1-afaerber@suse.de>
References: <20170223164553.3715-1-afaerber@suse.de>
Message-ID: <20170223164553.3715-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as maintainer.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: new
 
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9af886..16f4216 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1647,6 +1647,13 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/REALTEK ARCHITECTURE
+M:	Andreas F?rber <afaerber@suse.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm64/boot/dts/realtek/
+F:	Documentation/devicetree/bindings/arm/realtek.txt
+
 ARM/RENESAS ARM64 ARCHITECTURE
 M:	Simon Horman <horms@verge.net.au>
 M:	Magnus Damm <magnus.damm@gmail.com>
-- 
2.10.2
