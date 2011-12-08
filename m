From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 Dec 2011 15:20:13 +0800
Subject: [PATCH] ARM: imx6q: generate imx6q dtb files
In-Reply-To: <1323269051-29007-1-git-send-email-eric.miao@linaro.org>
References: <1323269051-29007-1-git-send-email-eric.miao@linaro.org>
Message-ID: <20111208072011.GA7913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, Dec 07, 2011 at 10:44:11PM +0800, Eric Miao wrote:
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Eric Miao <eric.miao@linaro.org>
> ---
>  arch/arm/mach-imx/Makefile.boot |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
> index cfede57..67b76f5 100644
> --- a/arch/arm/mach-imx/Makefile.boot
> +++ b/arch/arm/mach-imx/Makefile.boot
> @@ -25,3 +25,6 @@ initrd_phys-$(CONFIG_SOC_IMX35)	:= 0x80800000
>  zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
>  params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
>  initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
> +
> +dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-sabreauto.dtb \
> +			   imx6q-sabrelite.dtb

We do not have imx6q-sabrelite.dts hit mainline yet.

-- 
Regards,
Shawn
