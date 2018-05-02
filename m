From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 May 2018 15:04:23 +0800
Subject: [PATCH 1/2] arm: imx: select imx6sll pinctrl when imx6sll enabled
In-Reply-To: <1523606664-21669-1-git-send-email-ping.bai@nxp.com>
References: <1523606664-21669-1-git-send-email-ping.bai@nxp.com>
Message-ID: <20180502070422.GC3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2018 at 04:04:23PM +0800, Bai Ping wrote:
> select imx6sll pinctrl driver if imx6sll config is enabled.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

s/arm:/ARM: in patch subject.

I fixed it up and applied both patches.

Shawn

> ---
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 8e3a618..cb010a0 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -514,6 +514,7 @@ config SOC_IMX6SL
>  
>  config SOC_IMX6SLL
>  	bool "i.MX6 SoloLiteLite support"
> +	select PINCTRL_IMX6SLL
>  	select SOC_IMX6
>  
>  	help
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
