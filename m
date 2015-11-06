From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Nov 2015 09:11:17 +0900
Subject: [PATCH v6 3/4] drivers: exynos-srom: Add support for bank
 configuration
In-Reply-To: <ea4f9f2d5bac035c56156dfaf3119033478f5f3d.1446724046.git.p.fedin@samsung.com>
References: <cover.1446724046.git.p.fedin@samsung.com>
 <ea4f9f2d5bac035c56156dfaf3119033478f5f3d.1446724046.git.p.fedin@samsung.com>
Message-ID: <563BF025.3070308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 21:03, Pavel Fedin wrote:
> Implement handling properties in subnodes and adding child devices to the
> system. Child devices will not be added if configuration fails.
> 
> Since the driver now does more than suspend-resume support, dependency on
> CONFIG_PM is removed.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig      |  2 +-
>  drivers/soc/samsung/Kconfig       |  2 +-
>  drivers/soc/samsung/exynos-srom.c | 61 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 61 insertions(+), 4 deletions(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
