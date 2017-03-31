From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Mar 2017 09:40:51 +0200
Subject: [PATCH 1/2] MAINTAINERS: Update the Allwinner sunXi entry
Message-ID: <20170331074052.28878-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen-Yu and I have a shared git tree to host the sunxi patches now, so
let's document it.

And while we're at it, enhance our regex and document a few directories
that have been asked for in the past.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4084e2fa39c9..c18a2b89ce83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1047,8 +1047,13 @@ M:	Chen-Yu Tsai <wens@csie.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 N:	sun[x456789]i
-F:	arch/arm/boot/dts/ntc-gr8*
+N:	sun50i
+F:	arch/arm/mach-sunxi/
 F:	arch/arm64/boot/dts/allwinner/
+F:	drivers/clk/sunxi-ng/
+F:	drivers/pinctrl/sunxi/
+F:	drivers/soc/sunxi/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
 
 ARM/Allwinner SoC Clock Support
 M:	Emilio L?pez <emilio@elopez.com.ar>
-- 
2.11.0
