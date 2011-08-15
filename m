From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Aug 2011 16:33:38 +0100
Subject: [PATCH] arm: footbridge: Netwinder: Add KConfig select
	CLKEVT_I8253 to fix build failure
In-Reply-To: <1313422280-21942-1-git-send-email-peterhuewe@gmx.de>
References: <1313422280-21942-1-git-send-email-peterhuewe@gmx.de>
Message-ID: <20110815153338.GA525@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 05:31:20PM +0200, Peter Huewe wrote:
> diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
> index dc26fff..c8e7afc 100644
> --- a/arch/arm/mach-footbridge/Kconfig
> +++ b/arch/arm/mach-footbridge/Kconfig
> @@ -62,6 +62,7 @@ config ARCH_EBSA285_HOST
>  config ARCH_NETWINDER
>  	bool "NetWinder"
>  	select CLKSRC_I8253
> +	select CLKEVT_I8253

Could you please add this in alphabetical order, just like the rest of the
'select' options here?

>  	select FOOTBRIDGE_HOST
>  	select ISA
>  	select ISA_DMA

Then I'll take it through the patch system into my fixes branch.  Thanks.
