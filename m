From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 03 Dec 2012 21:19:52 +0100
Subject: [PATCH] ARM: sunxi: Include linux/delay.h
In-Reply-To: <1354462339.24917.0.camel@phoenix>
References: <1354462339.24917.0.camel@phoenix>
Message-ID: <50BD0968.3060405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/12/2012 16:32, Axel Lin a ?crit :
> This fixes below build error:
> 
>   CC      arch/arm/mach-sunxi/sunxi.o
> arch/arm/mach-sunxi/sunxi.c: In function 'sunxi_restart':
> arch/arm/mach-sunxi/sunxi.c:55:3: error: implicit declaration of function 'mdelay' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [arch/arm/mach-sunxi/sunxi.o] Error 1
> make: *** [arch/arm/mach-sunxi] Error 2

A similar patch has already been merged by Arnd:
http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commit;h=5e51651de30677f9d36805de9c261bf80f415790

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
