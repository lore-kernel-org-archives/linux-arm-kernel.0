From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Nov 2012 18:07:06 +0100
Subject: [PATCH 3/7] net: mvneta: update MAINTAINERS file for the mvneta
 maintainers
In-Reply-To: <1352740030-12801-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352740030-12801-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352740030-12801-4-git-send-email-thomas.petazzoni@free-electrons.com>
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
