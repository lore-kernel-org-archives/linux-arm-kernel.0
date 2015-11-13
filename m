From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Nov 2015 19:10:25 +0900
Subject: [PATCH v13 7/7] MAINTAINERS: Add entry Renesas arm64 architecture
In-Reply-To: <1447409425-14831-1-git-send-email-horms+renesas@verge.net.au>
References: <1447409425-14831-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1447409425-14831-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial Renesas arm64 architecture support will be for the R-Car H3,
r8a7795, SoC and its Salvator-X board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes since v12:
- Added Ack from Geert Uytterhoeven

Changes since v11:
- As suggested by Khiem Nguyen:
  + Removed reference to http://oss.renesas.com as that web site is closed

Changes since v10:
- New Patch
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab749c85..e35134f7d128 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1392,6 +1392,15 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
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
