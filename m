From: gregory.clement@free-electrons.com (Gregory Clement)
Date: Wed, 27 Jun 2012 15:54:49 +0200
Subject: [PATCH v5 8/9] arm: mach-mvebu: add entry to MAINTAINERS
In-Reply-To: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1340805290-9051-9-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb22272..050b7fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -894,6 +894,14 @@ ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
+ARM/Marvell Armada 370 and Armada XP SOC support
+M:	Gregory Clement <gregory.clement@free-electrons.com>
+M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+M:	Lior Amsalem <alior@marvell.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-mvebu/
+
 ARM/Marvell Dove/Kirkwood/MV78xx0/Orion SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
-- 
1.7.9.5
