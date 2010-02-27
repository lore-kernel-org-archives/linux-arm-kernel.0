From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 27 Feb 2010 17:51:38 +0100
Subject: [PATCH 57/66] arch/arm/plat-omap/include/plat/blizzard.h: Checkpatch
	cleanup
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1267289508-31031-58-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/plat-omap/include/plat/blizzard.h:9: ERROR: spaces prohibited around that ':' (ctx:WxW)

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/plat-omap/include/plat/blizzard.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/blizzard.h b/arch/arm/plat-omap/include/plat/blizzard.h
index 8d160f1..56e7f2e 100644
--- a/arch/arm/plat-omap/include/plat/blizzard.h
+++ b/arch/arm/plat-omap/include/plat/blizzard.h
@@ -6,7 +6,7 @@ struct blizzard_platform_data {
 	void		(*power_down)(struct device *dev);
 	unsigned long	(*get_clock_rate)(struct device *dev);
 
-	unsigned	te_connected : 1;
+	unsigned	te_connected:1;
 };
 
 #endif
-- 
1.7.0.90.g251a4
