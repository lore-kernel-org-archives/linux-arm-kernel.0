From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Mon, 16 Mar 2015 20:01:21 +0100
Subject: [PATCH v6 3/4] MAINTAINERS: Add myself as maintainer of Allwinner
 Security System
In-Reply-To: <1426532482-28830-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1426532482-28830-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1426532482-28830-4-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e1abe8..ebca296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10923,6 +10923,12 @@ L:	linux-mm at kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+ALLWINNER SECURITY SYSTEM
+M:	Corentin Labbe <clabbe.montjoie@gmail.com>
+L:	linux-crypto at vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/sunxi-ss/
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel at vger.kernel.org
-- 
2.0.5
