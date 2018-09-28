From: nm@ti.com (Nishanth Menon)
Date: Fri, 28 Sep 2018 17:46:15 -0500
Subject: [PATCH] MAINTAINERS: Drop dt-bindings/genpd/k2g.h
Message-ID: <20180928224615.19862-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop include/dt-bindings/genpd/k2g.h which disappeared from kernel tree
some time back, however MAINTAINERS file was missed to be updated.

Fixes: d16645054d2f ("dt-bindings: Drop k2g genpd device ID macros")
Cc: Rob Herring <robh@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

A big oops.. Sorry about that. will do better next time. I tried to relook and
I think we have'nt missed any other files.

Based off next-20180928 tag.

Santosh, any chance you could pick this up -> Thread:
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1776470.html

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c62b724bb60..633aa6385e37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14550,7 +14550,6 @@ F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 F:	drivers/firmware/ti_sci*
 F:	include/linux/soc/ti/ti_sci_protocol.h
 F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
-F:	include/dt-bindings/genpd/k2g.h
 F:	drivers/soc/ti/ti_sci_pm_domains.c
 F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
-- 
2.15.1
