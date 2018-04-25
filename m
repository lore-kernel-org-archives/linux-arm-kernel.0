From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 25 Apr 2018 14:17:55 +0800
Subject: [PATCH] phy: phy-mtk-tphy: fix checkpatch.pl warning about
 SPDX_LICENSE_TAG
Message-ID: <13d5ecd89f312af71dde347aadb18b65b1fac462.1524636174.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use SPDX-License-Identifier tag instead of the GPL license text

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/Makefile       |  1 +
 drivers/phy/mediatek/phy-mtk-tphy.c | 10 +---------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index 763a92e..1bdab14 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the phy drivers.
 #
diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 38c281b..b962339 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015 MediaTek Inc.
  * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #include <dt-bindings/phy/phy.h>
-- 
1.9.1
