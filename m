From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Sep 2014 09:56:26 +0900
Subject: [PATCH v2] MAINTAINERS: Add dts and dtsi files to Calxeda Highbank
 ARM platform
Message-ID: <1409705786-6568-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Added highbank.dts
* Sorted entries alphabetically
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa948..d73eaef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -858,6 +858,9 @@ ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	arch/arm/boot/dts/ecx-2000.dts
+F:	arch/arm/boot/dts/ecx-common.dtsi
+F:	arch/arm/boot/dts/highbank.dts
 F:	arch/arm/mach-highbank/
 
 ARM/CAVIUM NETWORKS CNS3XXX MACHINE SUPPORT
-- 
2.0.1
