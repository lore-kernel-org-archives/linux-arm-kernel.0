From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Thu, 22 Feb 2018 08:42:32 +0900
Subject: [PATCH] ASoC: uniphier: evea: fix lisence comment style
Message-ID: <20180221234232.5252-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes lisence comment style from C to C++.
And use SPDX instead of boiler plate of GPLv2, as same as
other audio codec drivers.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/evea.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index ac2d30b55fb6..439f14f91b23 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -1,22 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Socionext UniPhier EVEA ADC/DAC codec driver.
- *
- * Copyright (c) 2016-2017 Socionext Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
+//
+// Socionext UniPhier EVEA ADC/DAC codec driver.
+//
+// Copyright (c) 2016-2017 Socionext Inc.
 
 #include <linux/clk.h>
 #include <linux/module.h>
-- 
2.16.1
