From: dh09.lee@samsung.com (Donghwa Lee)
Date: Wed, 21 Dec 2011 13:24:18 +0900
Subject: [PATCH v5 0/2] video: support MIPI-DSI controller driver
Message-ID: <4EF15F72.1090201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

Samsung S5PC210 and EXYNOS SoC platform has MIPI-DSI controller and LCD panel 
based on MIPI-DSI could be used with it.

This patch set includes MIPI-DSI master driver and MIPI-DSI slave amoled panel
driver.

It consists of the flowing patches.

[PATCH v5 1/2]video: support MIPI-DSI controller driver
[PATCH v5 2/2]video: backlight: support s6e8ax0 panel driver based on MIPI DSI

Changes since v4:
	- include s6e8ax0 amoled panel driver based on MIPI DSI
	- remove compile warnings and useless code

Best regards,
Donghwa LEE
