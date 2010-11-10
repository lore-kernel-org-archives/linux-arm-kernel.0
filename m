From: saeed@marvell.com (Saeed Bishara)
Date: Wed, 10 Nov 2010 16:48:57 +0200
Subject: [PATCH] ARM: add MAINTAINERS entry for Marvell Dove SoC
Message-ID: <1289400537-23131-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0094224..39d9575 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -769,6 +769,13 @@ ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
+ARM/Marvell Dove SoC support
+M:	Saeed Bishara <saeed@marvell.com>
+M:	Mike Rapoport <mike@compulab.co.il>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+F:	arch/arm/mach-dove/
+S:	Maintained
+
 ARM/Marvell Loki/Kirkwood/MV78xx0/Orion SOC support
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 M:	Nicolas Pitre <nico@fluxnic.net>
-- 
1.6.0.4
