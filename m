From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 06 Dec 2011 15:30:08 +0900
Subject: [PATCH v2 0/3] Support Samsung Exynos OHCI device and driver
Message-ID: <001101ccb3e0$7fe48270$7fad8750$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

This patch series adds USB OHCI device and initial driver for Samsung
Exynos SoCs and is based from linux-samsung for-next branch.
I have tested on SMDKV310 board using EXYNOS4.

Thanks.

Jingoo Han (3) :
       ARM: EXYNOS: Add USB OHCI device
	   ARM: EXYNOS: Add USB OHCI support to SMDKV310 board
	   USB: Add Samsung Exynos OHCI diver

Changes since v1:
	- Replace ohci-s5p with ohci-exynos
	- Check phy control
