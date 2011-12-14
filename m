From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 14 Dec 2011 12:03:10 +0530
Subject: [PATCH V3 4/6] ARM: S5P64X0: Modified files for SPI consolidation
 work
In-Reply-To: <1323875763-21197-5-git-send-email-padma.v@samsung.com>
References: <1323875763-21197-1-git-send-email-padma.v@samsung.com>
 <1323875763-21197-5-git-send-email-padma.v@samsung.com>
Message-ID: <4EE84326.6030903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2011 08:46 PM, Padmavathi Venna wrote:
> As SPI platform devices are consolidated to plat-samsung, some
> corresponding changes are required in the respective machine folder.
> Added SPI Setup file for GPIO configurations and platform data
> initialization.
>
> Signed-off-by: Padmavathi Venna<padma.v@samsung.com>
> ---
>   arch/arm/mach-s5p64x0/Kconfig            |    7 +++-
>   arch/arm/mach-s5p64x0/Makefile           |    1 +
>   arch/arm/mach-s5p64x0/include/mach/map.h |    3 ++
>   arch/arm/mach-s5p64x0/setup-spi.c        |   55 ++++++++++++++++++++++++++++++
>   4 files changed, 64 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/mach-s5p64x0/setup-spi.c
>
[snip]
> diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-s5p64x0/include/mach/map.h
> index 4d3ac8a..c6af0fc 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/map.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/map.h
> @@ -67,6 +67,8 @@
>   #define S3C_PA_RTC		S5P64X0_PA_RTC
>   #define S3C_PA_WDT		S5P64X0_PA_WDT
>   #define S3C_PA_FB		S5P64X0_PA_FB
> +#define S3C_PA_SPI0		S5P64X0_PA_SPI0
> +#define S3C_PA_SPI1		S5P64X0_PA_SPI1
>
>   #define S5P_PA_CHIPID		S5P64X0_PA_CHIPID
>   #define S5P_PA_SROMC		S5P64X0_PA_SROMC
> @@ -75,6 +77,7 @@
>
>   #define SAMSUNG_PA_ADC		S5P64X0_PA_ADC
>
> +

Unncessary insertion of line.

-- 
Tushar Behera
