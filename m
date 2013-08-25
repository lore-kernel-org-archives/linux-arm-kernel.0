From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Aug 2013 17:19:53 +0100
Subject: [PATCH v8 1/8] ARM: debug: support debug ll on hisilicon soc
In-Reply-To: <1377336603-10303-2-git-send-email-haojian.zhuang@linaro.org>
References: <1377336603-10303-1-git-send-email-haojian.zhuang@linaro.org>
 <1377336603-10303-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130825161953.GV6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 24, 2013 at 05:29:56PM +0800, Haojian Zhuang wrote:
> Support UART0 debug ll on Hisilicon Hi3620 SoC & Hi3716 SoC.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/Kconfig.debug | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 814d224..bba9662 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -194,6 +194,22 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on HI3716 UART.
>  

I'm having problems applying this patch - I don't have the above context
lines in my tree, or anything remotely resembling them.  Neither can I
find anything remotely similar in mainline.

What did you generate this patch against?  It can't be v3.11-rc6 as you
put in your KernelVersion: line for the patch system.

Your diff above says that this was generated against blob 814d224, which
doesn't exist in mainline either.  Neither does it seem to appear in
my build tree which includes arm-soc's for-next branch.
