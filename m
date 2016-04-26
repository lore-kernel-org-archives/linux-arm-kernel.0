From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:39 +0200
Subject: [PATCH v3 11/11] MAINTAINERS: update entry for Marvell ARM platform
 maintainers
In-Reply-To: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1461657519-11939-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell platform support is no longer limited to Armada 370, 375,
38x and XP, but now also includes the 32-bits Armada 39x and the
64-bits Armada 3700 and 7K/8K.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7..d03f276 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1310,7 +1310,7 @@ ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
-ARM/Marvell Kirkwood and Armada 370, 375, 38x, XP SOC support
+ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Gregory Clement <gregory.clement@free-electrons.com>
-- 
2.6.4
