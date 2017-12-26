From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 26 Dec 2017 19:09:42 +0100
Subject: [PATCH] pinctrl: samsung: Add SPDX license identifiers
Message-ID: <1514311782-5187-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL license statements with SPDX GPL-2.0+ license identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/Kconfig                |  1 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 33 ++++++++++-------------
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 33 ++++++++++-------------
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 33 ++++++++++-------------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |  6 +----
 drivers/pinctrl/samsung/pinctrl-exynos5440.c   | 21 ++++++---------
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c      | 23 +++++++---------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c      | 27 ++++++++-----------
 drivers/pinctrl/samsung/pinctrl-samsung.c      | 37 +++++++++++---------------
 drivers/pinctrl/samsung/pinctrl-samsung.h      |  6 +----
 10 files changed, 89 insertions(+), 131 deletions(-)

diff --git a/drivers/pinctrl/samsung/Kconfig b/drivers/pinctrl/samsung/Kconfig
index ecfb90059eeb..11b5eeb14c4a 100644
--- a/drivers/pinctrl/samsung/Kconfig
+++ b/drivers/pinctrl/samsung/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Samsung Pin control drivers
 #
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index 071084d3ee9c..c32399faff57 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -1,22 +1,17 @@
-/*
- * Exynos specific support for Samsung pinctrl/gpiolib driver with eint support.
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- * Copyright (c) 2012 Linaro Ltd
- *		http://www.linaro.org
- *
- * Author: Thomas Abraham <thomas.ab@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This file contains the Samsung Exynos specific information required by the
- * the Samsung pinctrl/gpiolib driver. It also includes the implementation of
- * external gpio and wakeup interrupt support.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Exynos specific support for Samsung pinctrl/gpiolib driver with eint support.
+//
+// Copyright (c) 2012 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+// Copyright (c) 2012 Linaro Ltd
+//		http://www.linaro.org
+//
+// Author: Thomas Abraham <thomas.ab@samsung.com>
+//
+// This file contains the Samsung Exynos specific information required by the
+// the Samsung pinctrl/gpiolib driver. It also includes the implementation of
+// external gpio and wakeup interrupt support.
 
 #include <linux/device.h>
 #include <linux/of_address.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 08e9fdb58fd2..fc8f7833bec0 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -1,22 +1,17 @@
-/*
- * Exynos ARMv8 specific support for Samsung pinctrl/gpiolib driver
- * with eint support.
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- * Copyright (c) 2012 Linaro Ltd
- *		http://www.linaro.org
- * Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This file contains the Samsung Exynos specific information required by the
- * the Samsung pinctrl/gpiolib driver. It also includes the implementation of
- * external gpio and wakeup interrupt support.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Exynos ARMv8 specific support for Samsung pinctrl/gpiolib driver
+// with eint support.
+//
+// Copyright (c) 2012 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+// Copyright (c) 2012 Linaro Ltd
+//		http://www.linaro.org
+// Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
+//
+// This file contains the Samsung Exynos specific information required by the
+// the Samsung pinctrl/gpiolib driver. It also includes the implementation of
+// external gpio and wakeup interrupt support.
 
 #include <linux/slab.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index c8d0de7ea160..0a625a64ff5d 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -1,22 +1,17 @@
-/*
- * Exynos specific support for Samsung pinctrl/gpiolib driver with eint support.
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- * Copyright (c) 2012 Linaro Ltd
- *		http://www.linaro.org
- *
- * Author: Thomas Abraham <thomas.ab@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This file contains the Samsung Exynos specific information required by the
- * the Samsung pinctrl/gpiolib driver. It also includes the implementation of
- * external gpio and wakeup interrupt support.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Exynos specific support for Samsung pinctrl/gpiolib driver with eint support.
+//
+// Copyright (c) 2012 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+// Copyright (c) 2012 Linaro Ltd
+//		http://www.linaro.org
+//
+// Author: Thomas Abraham <thomas.ab@samsung.com>
+//
+// This file contains the Samsung Exynos specific information required by the
+// the Samsung pinctrl/gpiolib driver. It also includes the implementation of
+// external gpio and wakeup interrupt support.
 
 #include <linux/device.h>
 #include <linux/interrupt.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 7639b926c5c1..abd43aa7eb0d 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Exynos specific definitions for Samsung pinctrl and gpiolib driver.
  *
@@ -10,11 +11,6 @@
  * pinctrl/gpiolib interface drivers.
  *
  * Author: Thomas Abraham <thomas.ab@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #ifndef __PINCTRL_SAMSUNG_EXYNOS_H
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index 32a3a9fd65c4..3d8d5e812839 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -1,16 +1,11 @@
-/*
- * pin-controller/pin-mux/pin-config/gpio-driver for Samsung's EXYNOS5440 SoC.
- *
- * Author: Thomas Abraham <thomas.ab@samsung.com>
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// pin-controller/pin-mux/pin-config/gpio-driver for Samsung's EXYNOS5440 SoC.
+//
+// Author: Thomas Abraham <thomas.ab@samsung.com>
+//
+// Copyright (c) 2012 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index edf27264b603..10187cb0e9b9 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -1,17 +1,12 @@
-/*
- * S3C24XX specific support for Samsung pinctrl/gpiolib driver.
- *
- * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This file contains the SamsungS3C24XX specific information required by the
- * Samsung pinctrl/gpiolib driver. It also includes the implementation of
- * external gpio and wakeup interrupt support.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// S3C24XX specific support for Samsung pinctrl/gpiolib driver.
+//
+// Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+//
+// This file contains the SamsungS3C24XX specific information required by the
+// Samsung pinctrl/gpiolib driver. It also includes the implementation of
+// external gpio and wakeup interrupt support.
 
 #include <linux/init.h>
 #include <linux/device.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index e63663b32907..679628ac4b31 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -1,19 +1,14 @@
-/*
- * S3C64xx specific support for pinctrl-samsung driver.
- *
- * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
- *
- * Based on pinctrl-exynos.c, please see the file for original copyrights.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This file contains the Samsung S3C64xx specific information required by the
- * the Samsung pinctrl/gpiolib driver. It also includes the implementation of
- * external gpio and wakeup interrupt support.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// S3C64xx specific support for pinctrl-samsung driver.
+//
+// Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+//
+// Based on pinctrl-exynos.c, please see the file for original copyrights.
+//
+// This file contains the Samsung S3C64xx specific information required by the
+// the Samsung pinctrl/gpiolib driver. It also includes the implementation of
+// external gpio and wakeup interrupt support.
 
 #include <linux/init.h>
 #include <linux/device.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index e04f7fe0a65d..da58e4554137 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1,24 +1,19 @@
-/*
- * pin-controller/pin-mux/pin-config/gpio-driver for Samsung's SoC's.
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- * Copyright (c) 2012 Linaro Ltd
- *		http://www.linaro.org
- *
- * Author: Thomas Abraham <thomas.ab@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This driver implements the Samsung pinctrl driver. It supports setting up of
- * pinmux and pinconf configurations. The gpiolib interface is also included.
- * External interrupt (gpio and wakeup) support are not included in this driver
- * but provides extensions to which platform specific implementation of the gpio
- * and wakeup interrupts can be hooked to.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// pin-controller/pin-mux/pin-config/gpio-driver for Samsung's SoC's.
+//
+// Copyright (c) 2012 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+// Copyright (c) 2012 Linaro Ltd
+//		http://www.linaro.org
+//
+// Author: Thomas Abraham <thomas.ab@samsung.com>
+//
+// This driver implements the Samsung pinctrl driver. It supports setting up of
+// pinmux and pinconf configurations. The gpiolib interface is also included.
+// External interrupt (gpio and wakeup) support are not included in this driver
+// but provides extensions to which platform specific implementation of the gpio
+// and wakeup interrupts can be hooked to.
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 9af07af6cad6..e204f609823b 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * pin-controller/pin-mux/pin-config/gpio-driver for Samsung's SoC's.
  *
@@ -7,11 +8,6 @@
  *		http://www.linaro.org
  *
  * Author: Thomas Abraham <thomas.ab@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #ifndef __PINCTRL_SAMSUNG_H
-- 
2.7.4
