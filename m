From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 9 Nov 2009 08:00:48 +0100
Subject: [PATCH 2/3] pxa: select CPU_PXA310 for MACH_COLIBRI300
In-Reply-To: <f17812d70911082250h2368468em84e2a8f1b1c9698f@mail.gmail.com>
References: <f17812d70911082250h2368468em84e2a8f1b1c9698f@mail.gmail.com>
Message-ID: <20091109070048.GA14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2009 at 02:50:42PM +0800, Eric Miao wrote:
> MACH_COLIBRI300 is supposed to support both PXA300 and PXA310, select
> the missing CPU_PXA310.

Yes, that's correct. I don't have a PXA310 module here, that is why it
didn't hit me.

Thanks!

Acked-by: Daniel Mack <daniel@caiaq.de>


> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index ca2bd59..4bd0f87 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -254,6 +254,7 @@ config MACH_COLIBRI300
>  	bool "Toradex Colibri PXA300/310"
>  	select PXA3xx
>  	select CPU_PXA300
> +	select CPU_PXA310
> 
>  config MACH_COLIBRI320
>  	bool "Toradex Colibri PXA320"
> -- 
> 1.6.3.3
