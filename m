From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 11:11:45 +0000
Subject: [PATCH 3/5] mtd: st_spi_fsm: Correct vendor name spelling issue -
 missing "M"
In-Reply-To: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395313907-25318-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 27f9ec9..9de753d 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -3,7 +3,7 @@
  *
  * Author: Angus Clark <angus.clark@st.com>
  *
- * Copyright (C) 2010-2014 STicroelectronics Limited
+ * Copyright (C) 2010-2014 STMicroelectronics Limited
  *
  * JEDEC probe based on drivers/mtd/devices/m25p80.c
  *
-- 
1.8.3.2
