From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 05 Sep 2012 06:58:41 +0900
Subject: [PATCH v2 0/2] ARM: Exynos4-DT: Enable pinctrl driver support
In-Reply-To: <1345721098-32459-1-git-send-email-thomas.abraham@linaro.org>
References: <1345721098-32459-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <226f01cd8ae8$7236eb60$56a4c220$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> This patch series enables support for pin controller driver for Exynos4210
> SoC
> based device tree enabled platforms. The first patch in this series adds
> the
> pin group nodes for each of the three pin controller instances, but it is
> not
> a exhaustive list of all possible pin group nodes. As the coverage of
> pinctrl
> driver is extended device drivers used on Exynos4210 platforms, additional
> pin group nodes can be added as required.
> 
> Thomas Abraham (2):
>   ARM: dts: Add pinctrl node entries for Samsung Exynos4210 SoC
>   ARM: EXYNOS: Enable pinctrl driver support for Exynos4 device tree
> enabled platform
> 
>  arch/arm/boot/dts/exynos4210-pinctrl.dtsi |  457
> +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4210.dtsi         |   37 +++
>  arch/arm/mach-exynos/Kconfig              |    2 +
>  3 files changed, 496 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos4210-pinctrl.dt?

Looks good to me, will apply this series with Linus Walleij's ack.

Note, this will be applied on top of v4 pinctrl driver will be submitted by
Thomas.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
