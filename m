From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 19 May 2015 20:59:21 +0200
Subject: [PATCH] MAINTAINERS: Add entry for NXP LPC18xx/43xx MCUs
Message-ID: <1432061961-29179-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MAINTAINER entry covering all NXP LPC18xx/43xx
machine and drivers files.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

Patch based on arm-soc next/soc branch.

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dcb4392ec10..e556b7f7fea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1189,6 +1189,12 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/LPC18XX ARCHITECTURE
+M:	Joachim Eastwood <manabian@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+N:	lpc18xx
+
 ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
-- 
1.8.0
