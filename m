From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 Jan 2014 10:10:06 +0100
Subject: [PATCH] ARM: sunxi: change the AllWinner A1X to sunxi
In-Reply-To: <20140109153404.GA21055@kvmhost>
References: <20140109153404.GA21055@kvmhost>
Message-ID: <20140115091006.GF3377@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 04:34:04PM +0100, Gerardo Di Iorio wrote:
> Change the AllWinner A1X SOCs to Allwinner Sunxi SOCs
> 
> Signed-off-by: Gerardo Di Iorio <arete74@gmail.com>
> ---
>  arch/arm/mach-sunxi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 547004c..adb2574 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_SUNXI
> -       bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
> +       bool "Allwinner Sunxi SOCs" if ARCH_MULTI_V7

I wonder if the sunxi (apart the weird letter case) is actually
needed. Maybe we can just put "Allwinner SoCs" (it would be great if
you could fix the SoCs case too).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140115/fce18948/attachment-0001.sig>
