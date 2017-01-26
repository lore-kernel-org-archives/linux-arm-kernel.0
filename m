From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 26 Jan 2017 21:48:11 +0200
Subject: [PATCH v2 3/8] pinctrl: samsung: Add support for pad retention
 control for Exynos5433 SoCs
In-Reply-To: <1485419634-28331-4-git-send-email-m.szyprowski@samsung.com>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083402eucas1p187d3d31f62544fc46fae99fc5f74dbfe@eucas1p1.samsung.com>
 <1485419634-28331-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170126194811.rori5j5hmclniqig@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 09:33:49AM +0100, Marek Szyprowski wrote:
> This patch adds support for retention control for Exynos5433 SoCs. Three
> groups of pins has been defined for retention control: common shared group
> for ALIVE, CPIF, eSE, FINGER, IMEM, NFC, PERIC, TOUCH pin banks and
> separate control for FSYS and AUD pin banks, for which PMU retention
> registers match whole banks.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c    | 58 +++++++++++++++++++++++++++++
>  include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++++
>  2 files changed, 74 insertions(+)
>  		.eint_gpio_init = exynos_eint_gpio_init,

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
