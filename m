From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri,  9 Sep 2016 14:45:10 +0200
Subject: [PATCH v3 2/9] MAINTAINERS: Add myself as maintainer of sun8i-emac
In-Reply-To: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1473425117-18645-3-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add myself as maintainer of the sun8i-emac driver.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6781a3f..43f5be3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -582,6 +582,12 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALLWINNER SUN8I-EMAC ETHERNET DRIVER
+M:	Corentin Labbe <clabbe.montjoie@gmail.com>
+L:	netdev at vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/allwinner/sun8i-emac.c
+
 ALLWINNER SECURITY SYSTEM
 M:	Corentin Labbe <clabbe.montjoie@gmail.com>
 L:	linux-crypto at vger.kernel.org
-- 
2.7.3
