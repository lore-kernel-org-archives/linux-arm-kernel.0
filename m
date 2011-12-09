From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 9 Dec 2011 18:17:40 -0500 (EST)
Subject: [PATCH] arm: standardize /proc/iomem "Kernel code" name
In-Reply-To: <20111209211157.GA2146@outflux.net>
References: <20111209211157.GA2146@outflux.net>
Message-ID: <alpine.LFD.2.02.1112091815400.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Dec 2011, Kees Cook wrote:

> All other ports use "Kernel code" to identify the Kernel text segment
> in /proc/iomem. Change the ARM resources to do the same.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

Please submit the patch here:
http://www.arm.linux.org.uk/developer/patches/

> ---
>  arch/arm/kernel/setup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 3448a3f..a34dbf6 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -158,7 +158,7 @@ static struct resource mem_res[] = {
>  		.flags = IORESOURCE_MEM
>  	},
>  	{
> -		.name = "Kernel text",
> +		.name = "Kernel code",
>  		.start = 0,
>  		.end = 0,
>  		.flags = IORESOURCE_MEM
> -- 
> 1.7.5.4
> 
> 
> -- 
> Kees Cook                                            @outflux.net
> 
