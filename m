From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Dec 2009 18:15:36 +0900
Subject: [PATCH 0/7] ARM: S5P6440: Add support for Samsung's S5P6440 SoC
Message-ID: <000601ca7fc2$a9484830$fbd8d890$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patches add basic support for Samsung's S5P6440 SoC.
The feature set that is added are clock, timer, uart and interrupts.

The clock changes are based on Harald Welte's patch. This patch is
also based on Ben's plat-samsung patch.

This patch set includes the following patches.

[PATCH v2 1/7] ARM: S5P6440: Add new CPU initialization support
[PATCH v2 2/7] ARM: S5P6440: Add Clock and PLL support
[PATCH v2 3/7] ARM: S5P6440: Add IRQ support
[PATCH v2 4/7] ARM: S5P6440: Add Timer support
[PATCH v2 5/7] ARM: S5P6440: Add new Kconfig and Makefiles
[PATCH v2 6/7] ARM: S5P6440: Add Board and configuration file
[PATCH v2 7/7] ARM: S5P6440: Add serial port support

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
