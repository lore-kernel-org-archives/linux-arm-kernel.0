From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 13 Jan 2016 11:30:48 +0800
Subject: [PATCH v7 04/10] mfd: axp20x: Add missing copyright notice
In-Reply-To: <1452655854-1528-1-git-send-email-wens@csie.org>
References: <1452655854-1528-1-git-send-email-wens@csie.org>
Message-ID: <1452655854-1528-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the driver was merged, the original author did not include a proper
copyright notice. This patch adds the notice, backdated to when the
driver was merged.

Cc: Carlo Caione <carlo@caione.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

New patch in v7.

---
 drivers/mfd/axp20x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 3e186f2dcac3..cec51e689d1d 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -5,6 +5,8 @@
  * converters, LDOs, multiple 12-bit ADCs of voltage, current and temperature
  * as well as configurable GPIOs.
  *
+ * Copyright (C) 2014 Carlo Caione
+ *
  * Author: Carlo Caione <carlo@caione.org>
  *
  * This program is free software; you can redistribute it and/or modify
-- 
2.6.4
