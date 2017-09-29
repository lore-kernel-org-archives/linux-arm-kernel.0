From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:51 +0200
Subject: [PATCH 4/8] MAINTAINERS: Add Renesas SoC DT bindings doc to Renesas
 ARM sections
In-Reply-To: <cover.1506676368.git.horms+renesas@verge.net.au>
References: <cover.1506676368.git.horms+renesas@verge.net.au>
Message-ID: <964ca6feefb7136b30597f29bd51447fe9657590.1506676368.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2281af4b41b6..638a9d62177f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1756,6 +1756,7 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm64/boot/dts/renesas/
+F:	Documentation/devicetree/bindings/arm/shmobile.txt
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
@@ -1875,6 +1876,7 @@ F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
+F:	Documentation/devicetree/bindings/arm/shmobile.txt
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
-- 
2.1.4
