From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 May 2010 20:46:47 +0900
Subject: [PATCH 0/0] Adds Touchscreen & ADC Support for Samsung SoCs.
Message-ID: <007b01caf67f$cee9d1b0$6cbd7510$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series moves generic code to common place, 
Implements GPIO configuration function for touchscreen and 
Adds support for S3C64XX, S5PV210/C110 & S5P6440 Boards.

This patch set includes:

[PATCH v3 1/9] ARM: SAMSUNG: Moving ADC device definitions to plat-samsung
ARM: SAMSUNG: Move mach/ts.h to plat/ts.h - already merged to Ben's tree
[PATCH v3 3/9] ARM: SAMSUNG: Implements cfg_gpio function for Samsung
touchscreen
[PATCH v3 4/9] Input: s3c24xx_ts - Implements generic GPIO configuration
function
[PATCH v2 5/9] Input: s3c24xx_ts - Adds FEAT for Samsung touchscreen support
[PATCH v3 6/9] ARM: S3C64XX: Adds Touchscreen support for S3C64XX
[PATCH v2 7/9] ARM: S5P6440: Adds Touchscreen support for S5P6440
[PATCH v3 8/9] ARM: S5PV210: Adds Touchscreen support for S5PV210
[PATCH v3 9/9] Input: s3c24xx_ts - Modify touchscreen Kconfig for Support
Samsung SoCs



Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
