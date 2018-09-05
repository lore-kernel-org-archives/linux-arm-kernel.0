From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed,  5 Sep 2018 17:31:37 +0900
Subject: [PATCH] ASoC: uniphier: change status to orphan
Message-ID: <20180905083137.23153-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since I'm leaving from Socionext, I'll unable to access specification
documents of this hardware (these are not public). So change the
state to orphan until someone will maintain this driver.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8683e549777..4788a5335d35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13450,9 +13450,8 @@ F:	drivers/i2c/busses/i2c-synquacer.c
 F:	Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 
 SOCIONEXT UNIPHIER SOUND DRIVER
-M:	Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-S:	Maintained
+S:	Orphan
 F:	sound/soc/uniphier/
 
 SOEKRIS NET48XX LED SUPPORT
-- 
2.18.0
