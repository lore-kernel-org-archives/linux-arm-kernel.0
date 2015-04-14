From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Tue, 14 Apr 2015 13:21:00 +0200
Subject: [PATCH v7 3/4] MAINTAINERS: Add myself as maintainer of Allwinner
 Security System
In-Reply-To: <1429010461-9243-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1429010461-9243-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1429010461-9243-4-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efbcb50..dd3e27f 100644
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
2.0.5
