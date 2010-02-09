From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue,  9 Feb 2010 18:59:55 +0200
Subject: [PATCHv3 7/7] mxc: MAINTAINERS: Add maintainer for mach-mx5
In-Reply-To: <51c23a04c39e6a95a37b8af8625a550e674ddef6.1265733173.git.amit.kucheria@canonical.com>
References: <cover.1265733173.git.amit.kucheria@canonical.com>
	<a003708ad4ee9384226251431c7953a24079ff80.1265733173.git.amit.kucheria@canonical.com>
	<0f3332c4fabb2227b1bc15dc7542017d08f10a09.1265733173.git.amit.kucheria@canonical.com>
	<438caa3f6c91ba21c539a8547c4075b619dc6500.1265733173.git.amit.kucheria@canonical.com>
	<a329b48c43e5e2e6b51ce159d99aefeb90c7c066.1265733173.git.amit.kucheria@canonical.com>
	<b996b5830364c1b1d2469be574f4ebe831987ba9.1265733173.git.amit.kucheria@canonical.com>
	<51c23a04c39e6a95a37b8af8625a550e674ddef6.1265733173.git.amit.kucheria@canonical.com>
Message-ID: <3d48e1d0e8701d004ce7e1dd66088f42e429d079.1265733173.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add self to MAINTAINERS for Freescale i.MX5 SoCs

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66f5f7d..6a1773d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -663,6 +663,12 @@ T:	git://git.pengutronix.de/git/imx/linux-2.6.git
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
