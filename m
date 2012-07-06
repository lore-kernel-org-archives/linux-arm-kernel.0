From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  6 Jul 2012 17:23:40 +0200
Subject: [PATCH v9 8/9] arm: mach-mvebu: add entry to MAINTAINERS
In-Reply-To: <1341588221-3822-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341588221-3822-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1341588221-3822-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new mach-mvebu directory will be maintained by Andrew Lunn and
Jason Cooper (as the existing maintainers for previous Marvell EBU
SoCs) together with Gr?gory Cl?ment for the Armada 370/XP SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb22272..b8a65fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -894,6 +894,14 @@ ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
+ARM/Marvell Armada 370 and Armada XP SOC support
+M:	Jason Cooper <jason@lakedaemon.net>
+M:	Andrew Lunn <andrew@lunn.ch>
+M:	Gregory Clement <gregory.clement@free-electrons.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-mvebu/
+
 ARM/Marvell Dove/Kirkwood/MV78xx0/Orion SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
-- 
1.7.9.5
