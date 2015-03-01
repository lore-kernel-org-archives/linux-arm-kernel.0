From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sun,  1 Mar 2015 21:53:43 +0530
Subject: [PATCH 0/3] Minor exynos7 device tree/config patches
Message-ID: <1425227026-5336-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1 specifies the fifo sizes for UART channels on exnyos7. Without
this the 4210 compatible defaults will be picked up which are different
from that on exynos7.
Patch 2 is based on a patch from Liviu Dudau fixing a similar issue
for arm boards.
Patch 3 is needed to enable support for arm64 based exynos7 platform.

Abhilash Kesavan (2):
  arm64: dts: add fifo size property for uart channels on exynos7
  arm64: dts: Fix interrupt active level for the generic timer on
    exynos7

Alim Akhtar (1):
  arm64: Enable Exynos7 SOC in the defconfig

 arch/arm64/boot/dts/exynos/exynos7.dtsi | 13 +++++++++----
 arch/arm64/configs/defconfig            |  4 ++++
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.1.0
