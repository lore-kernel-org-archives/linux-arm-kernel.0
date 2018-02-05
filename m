From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 5 Feb 2018 18:20:28 +0530
Subject: [PATCH v2 15/16] mmc: sdhci-omap: Add SPDX identifier
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Message-ID: <20180205125029.21570-16-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPDX identifier is a legally binding shorthand, which can be used
instead of the full boiler plate text. Update sdhci-omap driver with the
correct SPDX license identifier.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 863f6736c2fe..d44918172197 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1,21 +1,7 @@
-/**
- * SDHCI Controller driver for TI's OMAP SoCs
- *
- * Copyright (C) 2017 Texas Instruments
- * Author: Kishon Vijay Abraham I <kishon@ti.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Texas Instruments
+// SDHCI Controller driver for TI's OMAP SoCs
+// Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 #include <linux/delay.h>
 #include <linux/mmc/slot-gpio.h>
-- 
2.11.0
