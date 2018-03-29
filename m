From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 29 Mar 2018 13:46:36 +0200
Subject: [PATCH] MAINTAINERS: update entry for entry for ARM/berlin
In-Reply-To: <20180329164240.20cfddbc@xhacker.debian> (Jisheng Zhang's message
 of "Thu, 29 Mar 2018 16:42:40 +0800")
References: <20180329164240.20cfddbc@xhacker.debian>
Message-ID: <87fu4jt883.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,
 
 On jeu., mars 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Change the entry name and move it to its alphabetical location.
> We move to ARM/Synaptics instead of ARM/Marvell.
>
> This patch also updates my email address from marvell to synaptics.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  MAINTAINERS | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e950b8b4a41..0a0da6a8e607 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1578,15 +1578,6 @@ ARM/MAGICIAN MACHINE SUPPORT
>  M:	Philipp Zabel <philipp.zabel@gmail.com>
>  S:	Maintained
>  
> -ARM/Marvell Berlin SoC support
> -M:	Jisheng Zhang <jszhang@marvell.com>
> -M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> -F:	arch/arm/mach-berlin/
> -F:	arch/arm/boot/dts/berlin*
> -F:	arch/arm64/boot/dts/marvell/berlin*
> -
>  ARM/Marvell Dove/MV78xx0/Orion SOC support
>  M:	Jason Cooper <jason@lakedaemon.net>
>  M:	Andrew Lunn <andrew@lunn.ch>
> @@ -2006,6 +1997,15 @@ F:	arch/arm/boot/dts/stm32*
>  F:	arch/arm/mach-stm32/
>  F:	drivers/clocksource/armv7m_systick.c
>  
> +ARM/Synaptics Berlin SoC support
> +M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> +M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm/mach-berlin/
> +F:	arch/arm/boot/dts/berlin*
> +F:	arch/arm64/boot/dts/marvell/berlin*

I though you had move the dts file from
arch/arm64/boot/dts/marvell/berlin* to arch/arm64/boot/dts/synatpics,
according a patch you submitted in September.

What happened?

Gregory

> +
>  ARM/TANGO ARCHITECTURE
>  M:	Marc Gonzalez <marc.w.gonzalez@free.fr>
>  M:	Mans Rullgard <mans@mansr.com>
> -- 
> 2.16.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
