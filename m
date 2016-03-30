From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 11:50:16 +0200
Subject: [PATCH 1/1] ARM: dts: kirkwood: add kirkwood-nsa320.dtb to
 Makefile
In-Reply-To: <1459154311-4770-1-git-send-email-xypron.glpk@gmx.de> (Heinrich
 Schuchardt's message of "Mon, 28 Mar 2016 10:38:31 +0200")
References: <1459154311-4770-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <87io04uwfb.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heinrich,
 
 On lun., mars 28 2016, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> Commit be3d7d023b87 ("ARM: kirkwood: Add DTS file for NSA320")
> created the new file kirkwood-nsa320.dts but did not
> add it to the Makefile.
>
> Fixes: be3d7d023b87 ("ARM: kirkwood: Add DTS file for NSA320")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f8308db..e75a340 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -215,6 +215,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-ns2mini.dtb \
>  	kirkwood-nsa310.dtb \
>  	kirkwood-nsa310a.dtb \
> +	kirkwood-nsa320.dtb \
>  	kirkwood-nsa325.dtb \
>  	kirkwood-openblocks_a6.dtb \
>  	kirkwood-openblocks_a7.dtb \
> -- 
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
