From: clabbe@baylibre.com (Corentin Labbe)
Date: Wed, 19 Sep 2018 19:17:54 +0000
Subject: [PATCH RESEND] spi: clps711x: remove unused header
Message-ID: <1537384674-12280-1-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/linux/platform_data/spi-clps711x.h is unused since commit 6acaadc852f1 ("spi: clps711x: Driver refactor")
Let's remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/platform_data/spi-clps711x.h | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-clps711x.h

diff --git a/include/linux/platform_data/spi-clps711x.h b/include/linux/platform_data/spi-clps711x.h
deleted file mode 100644
index 301956e63143..000000000000
--- a/include/linux/platform_data/spi-clps711x.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  CLPS711X SPI bus driver definitions
- *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-#define ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-
-/* Board specific platform_data */
-struct spi_clps711x_pdata {
-	int *chipselect;	/* Array of GPIO-numbers */
-	int num_chipselect;	/* Total count of GPIOs */
-};
-
-#endif
-- 
2.16.4
