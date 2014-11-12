From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 12 Nov 2014 11:41:06 +0900
Subject: [PATCH 0/2] ARM: dts: Fix the number of DMA channels for Exynos3250/4
Message-ID: <1415760068-765-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix minor issuse to correct the number of DMA channels for
Exynos3250 and Exynos4 series. The PL330 DMA of Exynos3250/Exynos4 support
16 channels simultaneously but, PL330 DMA driver don't use 'dma-channels'
property directly. This patchset fix the correct information
of Exynos3250/Exynos4's PL330 DMA simply.

Chanwoo Choi (2):
  ARM: dts: Fix the number of DMA channels for Exynos3250
  ARM: dts: Fix the number of DMA channels for Exynos4

 arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
 arch/arm/boot/dts/exynos4.dtsi    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.5.5
