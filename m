From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 15 Jun 2016 11:39:00 -0400
Subject: [PATCH 5/5] ARM: config: Get rid of config COMMON_CLK_MAX77802
In-Reply-To: <1466000018-16784-6-git-send-email-ldewangan@nvidia.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-6-git-send-email-ldewangan@nvidia.com>
Message-ID: <3fa0a098-3b28-9baa-8950-a944cce86b65@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laxman,

On 06/15/2016 10:13 AM, Laxman Dewangan wrote:
> The clock driver used by Maxim PMIC MAX77802 is clk-max77686
> which can be enabled with config CONFIG_COMMON_CLK_MAX77686.
> 
> Hence the config CONFIG_COMMON_CLK_MAX77802 is not required.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  arch/arm/configs/exynos_defconfig   | 1 -
>  arch/arm/configs/multi_v7_defconfig | 1 -

Please split these two changes in separate patches, there are just
cleanups needed after 1/5 and they can be picked separately.

The change looks good to me though so feel free to add:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
