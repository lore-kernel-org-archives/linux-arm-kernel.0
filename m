From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:13 +0100
Subject: [PATCH 18/39] arm/imx: remove "NO_PAD_CTRL" from Copyright statements
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-18-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I assume this was introduced by something like

	sed -i -e 's/)/, NO_PAD_CTRL)'

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-mx35.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index 9af494f..a4fbef6 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -7,7 +7,7 @@
  *    Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
  * and
  * arch/arm/plat-mxc/include/mach/iomux-mx35.h
- *    Copyright (C, NO_PAD_CTRL) 2009 by Jan Weitzel Phytec Messtechnik GmbH <armlinux@phytec.de>
+ *    Copyright (C) 2009 by Jan Weitzel Phytec Messtechnik GmbH <armlinux@phytec.de>
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx35.h b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
index c88d407..2a24bae 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx35.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C, NO_PAD_CTRL) 2009 by Jan Weitzel Phytec Messtechnik GmbH <armlinux@phytec.de>
+ * Copyright (C) 2009 by Jan Weitzel Phytec Messtechnik GmbH <armlinux@phytec.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
-- 
1.6.6.2
