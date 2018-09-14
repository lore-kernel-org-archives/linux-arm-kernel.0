From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 14 Sep 2018 16:40:07 +0200
Subject: [PATCH v4 18/22] nvmem: use SPDX license identifiers
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Message-ID: <20180914144011.27614-19-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use SPDX license identiefiers to core nvmem files and remove GPL 2.0
license boilerplate.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 10 +---------
 include/linux/nvmem-consumer.h |  5 +----
 include/linux/nvmem-provider.h |  5 +----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index da441019b609..ea05219e60b4 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * nvmem framework core.
  *
  * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
  * Copyright (C) 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/device.h>
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 0326b52e906b..d18caae2f7ac 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * nvmem framework consumer.
  *
  * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
  * Copyright (C) 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef _LINUX_NVMEM_CONSUMER_H
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 5c9f205cac8f..8ae012f6545a 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * nvmem framework provider.
  *
  * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
  * Copyright (C) 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef _LINUX_NVMEM_PROVIDER_H
-- 
2.18.0
