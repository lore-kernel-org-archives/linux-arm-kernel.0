From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 11:50:08 +0200
Subject: [PATCH 1/1] ARM: dts: kirkwood: add kirkwood-ds112.dtb to Makefile
In-Reply-To: <1459152228-4345-1-git-send-email-xypron.glpk@gmx.de> (Heinrich
 Schuchardt's message of "Mon, 28 Mar 2016 10:03:48 +0200")
References: <1459152228-4345-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <87mvpguwfj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heinrich,
 
 On lun., mars 28 2016, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> Commit 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology
> NAS devices") created the new file kirkwood-ds112.dts but did not
> add it to the Makefile.
>
> Fixes: 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology NAS devices")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b25621a..f8308db 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -177,6 +177,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-ds109.dtb \
>  	kirkwood-ds110jv10.dtb \
>  	kirkwood-ds111.dtb \
> +	kirkwood-ds112.dtb \
>  	kirkwood-ds209.dtb \
>  	kirkwood-ds210.dtb \
>  	kirkwood-ds212.dtb \
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
