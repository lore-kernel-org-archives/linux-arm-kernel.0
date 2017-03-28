From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:38 +0200
Subject: [PATCH v2 11/11] ARM: at91: pm: correct typo
In-Reply-To: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170328111938.21297-12-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a missing bracket at the end of Anti's email

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm_suspend.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index ed317657e760..96781daa671a 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -4,7 +4,7 @@
  *  Copyright (C) 2006 Savin Zlobec
  *
  * AT91SAM9 support:
- *  Copyright (C) 2007 Anti Sullin <anti.sullin at artecdesign.ee
+ *  Copyright (C) 2007 Anti Sullin <anti.sullin@artecdesign.ee>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
2.11.0
