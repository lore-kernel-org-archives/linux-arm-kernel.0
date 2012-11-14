From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Nov 2012 15:56:47 +0100
Subject: [PATCH v7 3/6] net: mvneta: update MAINTAINERS file for the mvneta
 maintainers
In-Reply-To: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352905010-24172-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59203e7..3010f1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4700,6 +4700,12 @@ S:	Maintained
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
