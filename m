From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:50 -0800
Subject: [PATCH 6/6] MAINTAINERS: Add entry for Renesas arm64 architecture
In-Reply-To: <cover.1447980335.git.horms+renesas@verge.net.au>
References: <cover.1447980335.git.horms+renesas@verge.net.au>
Message-ID: <b138e11931f2fe25cf188ed62b54bc36f59a25ce.1447980335.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial Renesas arm64 architecture support will be for the R-Car H3,
r8a7795, SoC and its Salvator-X board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b28828..2cf10697da29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1420,6 +1420,15 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RENESAS ARM64 ARCHITECTURE
+M:	Simon Horman <horms@verge.net.au>
+M:	Magnus Damm <magnus.damm@gmail.com>
+L:	linux-sh at vger.kernel.org
+Q:	http://patchwork.kernel.org/project/linux-sh/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
+S:	Supported
+F:	arch/arm64/boot/dts/renesas/
+
 ARM/RISCPC ARCHITECTURE
 M:	Russell King <linux@arm.linux.org.uk>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.1.4
