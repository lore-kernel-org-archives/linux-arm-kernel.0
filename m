From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Aug 2013 13:01:28 +0800
Subject: [PATCH 1/1] arm: imx: Kconfig: select syscon for mx25
In-Reply-To: <1375947809-11694-1-git-send-email-peter.chen@freescale.com>
References: <1375947809-11694-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130812050126.GA25061@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I prefer to use uppercase for "ARM:" in subject.

On Thu, Aug 08, 2013 at 03:43:29PM +0800, Peter Chen wrote:
> We need to use syscon to map one register region for several
> devices, eg, usb non-core register for all usb devices.

So we're changing usb non-core controller to be a syscon?

> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index f546560..5bb21fe 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -109,6 +109,7 @@ config SOC_IMX25
>  	select COMMON_CLK
>  	select CPU_ARM926T
>  	select MXC_AVIC
> +	select MFD_SYSCON

Please sort it alphabetically.

Shawn

>  
>  config SOC_IMX27
>  	bool
> -- 
> 1.7.1
> 
> 
