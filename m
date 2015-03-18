From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 18 Mar 2015 16:58:44 +0200
Subject: [PATCH] MAINTAINERS: add amlogic meson git tree and website
Message-ID: <fc786af5b6700345b6c7d38b4c323d69d843194a.1426690724.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e1abe8cc684..bfedf32979dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -877,6 +877,8 @@ F:	drivers/clk/sunxi/
 ARM/Amlogic MesonX SoC support
 M:	Carlo Caione <carlo@caione.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://github.com/carlocaione/linux-meson
+W:	http://linux-meson.com
 S:	Maintained
 F:	drivers/media/rc/meson-ir.c
 N:	meson[x68]
-- 
2.1.4
