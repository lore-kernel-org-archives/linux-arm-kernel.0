From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Mon,  6 Jul 2015 21:10:48 +0200
Subject: [PATCH v10 5/5] MAINTAINERS: Add myself as maintainer of Allwinner
 Security System
In-Reply-To: <1436209848-16530-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1436209848-16530-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1436209848-16530-6-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bbb6aeb..33851b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -556,6 +556,12 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALLWINNER SECURITY SYSTEM
+M:	Corentin Labbe <clabbe.montjoie@gmail.com>
+L:	linux-crypto at vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/sunxi-ss/
+
 ALPHA PORT
 M:	Richard Henderson <rth@twiddle.net>
 M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
-- 
2.3.6
