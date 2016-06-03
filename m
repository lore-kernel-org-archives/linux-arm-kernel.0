From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Fri,  3 Jun 2016 11:56:27 +0200
Subject: [PATCH 2/5] MAINTAINERS: Add myself as maintainers of sun8i-emac
In-Reply-To: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1464947790-22991-3-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed42cb6..d8f5c14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -581,6 +581,12 @@ S:	Maintained
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
