From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 23 Mar 2016 19:53:31 +0100
Subject: [PATCH] arm64: defconfig: enable basic boot for Amlogic meson
In-Reply-To: <1458758993-14467-1-git-send-email-khilman@baylibre.com>
References: <1458758993-14467-1-git-send-email-khilman@baylibre.com>
Message-ID: <56F2E62B.6070803@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.03.2016 um 19:49 schrieb Kevin Hilman:
> Enables basic arch and serial console support for Amlogic meson family
> SoCs.
> 
> Tested with Amlogic P200 and Hardkernel ODROID-C2 boards.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f70505186820..71c9d21c06ca 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -38,6 +38,7 @@ CONFIG_ARCH_EXYNOS=y
>  CONFIG_ARCH_LAYERSCAPE=y
>  CONFIG_ARCH_HISI=y
>  CONFIG_ARCH_MEDIATEK=y
> +CONFIG_ARCH_MESON=y
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_ARCH_QCOM=y
>  CONFIG_ARCH_ROCKCHIP=y
> @@ -137,6 +138,8 @@ CONFIG_SERIAL_TEGRA=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_SERIAL_SH_SCI_NR_UARTS=11
>  CONFIG_SERIAL_SH_SCI_CONSOLE=y
> +CONFIG_SERIAL_MESON=y
> +CONFIG_SERIAL_MESON_CONSOLE=y
>  CONFIG_SERIAL_MSM=y
>  CONFIG_SERIAL_MSM_CONSOLE=y
>  CONFIG_SERIAL_XILINX_PS_UART=y

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Just noticed again a couple minutes ago. :)

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
