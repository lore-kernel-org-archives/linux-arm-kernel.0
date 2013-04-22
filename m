From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 22 Apr 2013 17:05:06 +0530
Subject: [PATCH v2 0/2] ARM: Exynos: Add DT based I/O mapping for Chip-ID
 controller
Message-ID: <1366630508-26101-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Rebased to v3.9-rc8

This patch series allows device tree enabled platforms to setup a runtime
I/O mapping for the chip-id controller. This helps to remove statically
defined I/O mapping for the Chip-ID controller. This series is based on
linux-next master branch and tested for Exynos4210, Exynos5250 and
Exynos5440.

Thomas Abraham (2):
  ARM: Exynos: Create virtual I/O mapping for Chip-ID controller using device tree
  ARM: dts: Add chip-id controller node on Exynos4/5 SoC
