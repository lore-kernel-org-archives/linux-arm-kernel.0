From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Mar 2017 16:41:31 +0800
Subject: [PATCH 1/4] arm: defconfig: imx6: Added CONFIG_FHANDLE
In-Reply-To: <20170219202801.2082-2-plaes@plaes.org>
References: <20170219202801.2082-1-plaes@plaes.org>
 <20170219202801.2082-2-plaes@plaes.org>
Message-ID: <20170313084129.GA3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2017 at 10:27:58PM +0200, Priit Laes wrote:
> CONFIG_FHANDLE is a must-have for newer distributions with systemd
> support (including Debian stable).
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>

'ARM: imx_v6_v7_defconfig: ...' for subject prefix.

Shawn

> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index cbe7faf..701db9a 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_KERNEL_LZO=y
>  CONFIG_SYSVIPC=y
> +CONFIG_FHANDLE=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_IKCONFIG=y
> -- 
> 2.9.3
> 
