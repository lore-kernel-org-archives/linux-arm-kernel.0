From: marex@denx.de (Marek Vasut)
Date: Fri, 15 Jun 2012 13:49:46 +0200
Subject: [PATCH v2 3/3] ARM: mxs_defconfig: Let AUART driver be built by
 default
In-Reply-To: <1339759950-5507-3-git-send-email-festevam@gmail.com>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
 <1339759950-5507-3-git-send-email-festevam@gmail.com>
Message-ID: <201206151349.47150.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Let AUART driver be built by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Not much to review, but ...

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
> Changes since v1:
> - No changes
>  arch/arm/configs/mxs_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mxs_defconfig
> b/arch/arm/configs/mxs_defconfig index 5406c23..66b76c1 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -77,6 +77,7 @@ CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  # CONFIG_DEVKMEM is not set
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> +CONFIG_SERIAL_MXS_AUART=y
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_I2C=y
>  # CONFIG_I2C_COMPAT is not set

Best regards,
Marek Vasut
