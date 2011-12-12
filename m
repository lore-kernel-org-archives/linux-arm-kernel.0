From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 12 Dec 2011 21:46:53 +0000
Subject: [PATCH 4/5] MAINTAINERS: add maintainer entry for Picochip picoxcell
In-Reply-To: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
References: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1323726414-3319-5-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer entry for the picoxcell machine support and associated
drivers.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 071a996..543f5a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5114,6 +5114,14 @@ L:	linux-mtd at lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/devices/phram.c
 
+PICOXCELL SUPPORT
+M:	Jamie Iles <jamie@jamieiles.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://github.com/jamieiles/linux-2.6-ji.git
+S:	Supported
+F:	arch/arm/mach-picoxcell
+F:	drivers/*/picoxcell*
+
 PIN CONTROL SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
-- 
1.7.5.4
