From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Apr 2013 01:40:02 +0900
Subject: [GIT PULL] Samsung fixes-1 for v3.10
Message-ID: <51795C62.8070500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 58a7bbf75442ea439a4d3b7993ad87023e406063:

   ARM: dts: add PDMA0 changes for exynos5440 (2013-04-09 01:39:27 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-1-for-v3.10

for you to fetch changes up to bf49cd7f8d560497cf39065a537f4c722e456cbb:

   ARM: dts: Disable the RTC by default on exynos5 (2013-04-26 01:26:54 
+0900)

----------------------------------------------------------------
Disables the RTC by default on exynos5 to remove lots of warnings in the 
kernel boot log and Fixes build warning on exynos4x12

----------------------------------------------------------------
Doug Anderson (1):
       ARM: dts: Disable the RTC by default on exynos5

Thomas Abraham (1):
       ARM: dts: add mshc controller node for Exynos4x12 SoCs

  arch/arm/boot/dts/exynos4412.dtsi | 8 ++++++++
  arch/arm/boot/dts/exynos5250.dtsi | 1 +
  arch/arm/boot/dts/exynos5440.dtsi | 1 +
  3 files changed, 10 insertions(+)
