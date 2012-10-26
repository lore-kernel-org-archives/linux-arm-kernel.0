From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Oct 2012 12:03:22 +0200
Subject: [PATCH 2/4] net: mvneta: update MAINTAINERS file for the mvneta
 maintainers
In-Reply-To: <1351245804-31478-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351245804-31478-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351245804-31478-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 027ec2b..e698ea0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4691,6 +4691,12 @@ S:	Maintained
 F:	drivers/net/ethernet/marvell/mv643xx_eth.*
 F:	include/linux/mv643xx.h
 
+MARVELL MVNETA ETHERNET DRIVER
+M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+L:	netdev at vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/marvell/mvneta.*
+
 MARVELL MWIFIEX WIRELESS DRIVER
 M:	Bing Zhao <bzhao@marvell.com>
 L:	linux-wireless at vger.kernel.org
-- 
1.7.9.5
