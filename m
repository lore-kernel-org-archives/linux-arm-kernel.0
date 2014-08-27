From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Aug 2014 13:18:23 +0900
Subject: [PATCH] MAINTAINERS: Add dts and dtsi files to Calxeda Highbank ARM
 platform
Message-ID: <1409113103-15937-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94fcad9..5ed5734 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -859,6 +859,8 @@ M:	Rob Herring <robh@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-highbank/
+F:	arch/arm/boot/dts/ecx-2000.dts
+F:	arch/arm/boot/dts/ecx-common.dtsi
 
 ARM/CAVIUM NETWORKS CNS3XXX MACHINE SUPPORT
 M:	Anton Vorontsov <anton@enomsg.org>
-- 
2.0.1
