From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu, 14 May 2015 14:59:00 +0200
Subject: [PATCH v9 3/4] MAINTAINERS: Add myself as maintainer of Allwinner
 Security System
In-Reply-To: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1431608341-10936-4-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d87ccb..f2518d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -555,6 +555,12 @@ S:	Maintained
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
