From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Mar 2017 14:17:03 +0100
Subject: [PATCH v2 19/23] MAINTAINERS: Add file patterns for ti device tree
 bindings
In-Reply-To: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
References: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1489324627-19126-20-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.

v2:
  - Add Acked-by.

Impact on next-20170310:

-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:1/1=100%)
+Santosh Shilimkar <ssantosh@kernel.org> (maintainer:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-Eric Engestrom <eric@engestrom.ch> (commit_signer:1/1=100%,authored:1/1=100%)
+linux-kernel at vger.kernel.org (open list:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
+linux-arm-kernel at lists.infradead.org (moderated list:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
 devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-linux-kernel at vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 271b2df4bc27f28b..6cd9daf3a2f9a44a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12493,6 +12493,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-kernel at vger.kernel.org
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/soc/ti/
 F:	drivers/soc/ti/*
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
 
-- 
2.7.4
