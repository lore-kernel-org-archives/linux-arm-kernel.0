From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 26 Sep 2012 10:47:05 +0900
Subject: [PATCH v4 0/3] ARM: Exynos: Add support for MSHC controller
In-Reply-To: <1346238072-7324-1-git-send-email-thomas.abraham@linaro.org>
References: <1346238072-7324-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <135f01cd9b88$d557efe0$8007cfa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> This patch series adds Exynos5250 platform support for MSHC controllers.
> 
> Thomas Abraham (3):
>   ARM: Samsung: Add support for MSHC controller clocks
>   ARM: Exynos5: Add AUXDATA support for MSHC controllers
>   ARM: dts: Add nodes for dw_mmc controllers for Samsung Exynos5250
> platforms
> 
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |   55
> +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi         |   32 +++++++++++++++++
>  arch/arm/mach-exynos/clock-exynos5.c      |   45 ++++++++---------------
>  arch/arm/mach-exynos/include/mach/map.h   |    4 ++
>  arch/arm/mach-exynos/mach-exynos5-dt.c    |    8 ++++
>  5 files changed, 115 insertions(+), 29 deletions(-)

Applied this series.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
