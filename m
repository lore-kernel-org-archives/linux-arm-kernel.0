From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 12 Nov 2014 11:50:27 +0900
Subject: [PATCHv2 0/2] ARM: dts: Fix the number of DMA channels for
 Exynos3250/4
Message-ID: <1415760629-1531-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix minor issuse to correct the number of DMA channels for
Exynos3250 and Exynos4 series. The PL330 DMA of Exynos3250/Exynos4 support
16 channels simultaneously but, PL330 DMA driver don't use 'dma-channels'
property directly. This patchset fix the correct information
of Exynos3250/Exynos4's PL330 DMA simply.

Changes from v1:
- Fix the nubmer for DMA channesl for Exynos4415

Chanwoo Choi (2):
  ARM: dts: Fix the number of DMA channels for Exynos3250
  ARM: dts: Fix the number of DMA channels for Exynos4

 arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
 arch/arm/boot/dts/exynos4.dtsi    | 4 ++--
 arch/arm/boot/dts/exynos4415.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.8.5.5
