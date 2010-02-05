From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri,  5 Feb 2010 08:26:16 -0800
Subject: [PATCHv3 7/7] mxc: MAINTAINERS: Add maintainer for mach-mx5
In-Reply-To: <20ff6a7d4fbb2460f52f982308fbcdb55c3da9c3.1265385421.git.amit.kucheria@canonical.com>
References: <cover.1265385421.git.amit.kucheria@canonical.com>
	<367110fafb57f7340bbffec9b394ed2fa6e89da5.1265385421.git.amit.kucheria@canonical.com>
	<553d86cf968ba78a26b67098c2e1849407a51ba1.1265385421.git.amit.kucheria@canonical.com>
	<bf84de08e5c511325fb94a742f5d6efabece06b6.1265385421.git.amit.kucheria@canonical.com>
	<7739120baf6088e426f3f8bab174f6c6a6df3601.1265385421.git.amit.kucheria@canonical.com>
	<ef6149ed5e1d228262c3d98421a836400095c1b7.1265385421.git.amit.kucheria@canonical.com>
	<20ff6a7d4fbb2460f52f982308fbcdb55c3da9c3.1265385421.git.amit.kucheria@canonical.com>
Message-ID: <1b112656ecc86f894daa468dc0b84f43e34833dd.1265385421.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add self to MAINTAINERS for Freescale i.MX5 SoCs

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03f38c1..c56d092 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -662,6 +662,12 @@ T:	git://git.pengutronix.de/git/imx/linux-2.6.git
 F:	arch/arm/mach-mx*/
 F:	arch/arm/plat-mxc/
 
+ARM/FREESCALE IMX51
+M:	Amit Kucheria <amit.kucheria@canonical.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-mx5/
+
 ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.6.3.3
