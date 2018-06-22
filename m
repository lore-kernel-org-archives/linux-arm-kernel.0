From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 22 Jun 2018 12:08:18 +0200
Subject: [PATCH v4] MAINTAINERS: Add file patterns for ti device tree bindings
Message-ID: <20180622100818.29469-1-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
---
v3:
  - Update for next-20180622,

v2:
  - Add Acked-by.

Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/soc/ti/":

-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:4/4=100%)
+Santosh Shilimkar <ssantosh@kernel.org> (maintainer:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-WingMan Kwok <w-kwok2@ti.com> (commit_signer:1/4=25%)
-Murali Karicheri <m-karicheri2@ti.com> (commit_signer:1/4=25%,authored:1/4=25%)
-Marco Franchi <marco.franchi@nxp.com> (commit_signer:1/4=25%,authored:1/4=25%)
-Santosh Shilimkar <ssantosh@kernel.org> (commit_signer:1/4=25%)
-Mathieu Malaterre <malat@debian.org> (authored:1/4=25%)
-Dave Gerlach <d-gerlach@ti.com> (authored:1/4=25%)
+linux-kernel at vger.kernel.org (open list:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
+linux-arm-kernel at lists.infradead.org (moderated list:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
 devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-linux-kernel at vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index df246daab5a27af2..5c546cf9a53ca301 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14257,6 +14257,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-kernel at vger.kernel.org
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/soc/ti/
 F:	drivers/soc/ti/*
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
 
-- 
2.17.1
