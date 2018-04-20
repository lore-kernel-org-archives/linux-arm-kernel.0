From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 20 Apr 2018 09:05:16 +0100
Subject: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
In-Reply-To: <20180419200015.15095-2-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
Message-ID: <20180420080516.hoa2wlubrnpnkl5z@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Apr 2018, Wolfram Sang wrote:

> This header only contains platform_data. Move it to the proper directory.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  MAINTAINERS                                      | 2 +-
>  arch/arm/mach-ks8695/board-acs5k.c               | 2 +-
>  arch/arm/mach-omap1/board-htcherald.c            | 2 +-
>  arch/arm/mach-pxa/palmz72.c                      | 2 +-
>  arch/arm/mach-pxa/viper.c                        | 2 +-
>  arch/arm/mach-sa1100/simpad.c                    | 2 +-
>  arch/mips/alchemy/board-gpr.c                    | 2 +-
>  drivers/i2c/busses/i2c-gpio.c                    | 2 +-
>  drivers/media/platform/marvell-ccic/mmp-driver.c | 2 +-
>  drivers/mfd/sm501.c                              | 2 +-
>  include/linux/{ => platform_data}/i2c-gpio.h     | 0
>  11 files changed, 10 insertions(+), 10 deletions(-)
>  rename include/linux/{ => platform_data}/i2c-gpio.h (100%)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
