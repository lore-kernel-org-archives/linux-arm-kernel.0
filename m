From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Apr 2017 11:18:24 +0100
Subject: [GIT PULL] mfd: exynos-lpass: Pinctrl dependency
In-Reply-To: <20170328154217.5405-1-krzk@kernel.org>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <20170328154217.5405-1-krzk@kernel.org>
Message-ID: <20170403101824.rpvkqzyigonyi77p@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Mar 2017, Krzysztof Kozlowski wrote:

> 
> Hi Lee,
> 
> 
> This is dependency for mfd/exynos-lpass driver changes from Marek Szyprowski.
> That's a material for v4.12 and I will be pushing this later to Linus Walleij.

This does not work, and *may* still break.

The only way to guarantee the order of the patches is to have them
*all* as part of the pull-request.  Not just some of them.

> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-retention-4.12
> 
> for you to fetch changes up to e1d7eb0c8fc9c33ef60ac31172fb0fbb78c24271:
> 
>   pinctrl: samsung: Add support for pad retention control for Exynos5433 SoCs (2017-03-23 21:07:02 +0200)
> 
> ----------------------------------------------------------------
> Add retention control to Exynos5433 pinctrl driver, necessary for proper
> handling of runtime Power Management of Exynos Audio SubSystem and effectively
> allowing to power down the domain.
> 
> ----------------------------------------------------------------
> Marek Szyprowski (2):
>       pinctrl: samsung: Ensure that pad retention is disabled on driver init
>       pinctrl: samsung: Add support for pad retention control for Exynos5433 SoCs
> 
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 63 ++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
