From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Nov 2012 19:12:01 +0900
Subject: [PATCH 0/3] Legacy I2C controller fixes for exynos5
In-Reply-To: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
References: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <0c5601cdc707$7b55a000$7200e000$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> This patchset comprises fixes to enable the legacy I2C controller on
> exynos5.
> Based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-
> samsung.git
> for-next branch.
> 
> Abhilash Kesavan (3):
>   ARM: EXYNOS5: Setup legacy i2c controller interrupts on SMDK5250
>   ARM: EXYNOS5: Add aliases for i2c controller
>   ARM: EXYNOS5: Fix i2c suspend/resume for legacy controller
> 
>  arch/arm/boot/dts/exynos5250.dtsi            |   27
+++++++++++++++++--------
>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    2 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c       |   24
+++++++++++++++++++++++
>  arch/arm/mach-exynos/pm.c                    |    9 ++++++++
>  4 files changed, 53 insertions(+), 9 deletions(-)

Applied this whole series.

Thanks.

K-Gene <kgene@kernel.org>
