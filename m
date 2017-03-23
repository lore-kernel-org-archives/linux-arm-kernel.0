From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 Mar 2017 17:28:00 +0100
Subject: [PATCH v2 05/23] MAINTAINERS: Add file patterns for dove device
 tree bindings
In-Reply-To: <1489324627-19126-6-git-send-email-geert@linux-m68k.org> (Geert
 Uytterhoeven's message of "Sun, 12 Mar 2017 14:16:49 +0100")
References: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
 <1489324627-19126-6-git-send-email-geert@linux-m68k.org>
Message-ID: <87a88cdkkv.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,
 
 On dim., mars 12 2017, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org


Applied on mvebu/soc

Thanks,

Gregory

> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
>
> v2:
>   - No changes.
>
> Impact on next-20170310:
>
> +Jason Cooper <jason@lakedaemon.net> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
> +Andrew Lunn <andrew@lunn.ch> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
> +Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
> +Gregory Clement <gregory.clement@free-electrons.com> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
>  Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> +linux-arm-kernel at lists.infradead.org (moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support)
>  devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  linux-kernel at vger.kernel.org (open list)
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6428d3c82fce9670..ce461fefec6c9463 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1486,6 +1486,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>  M:	Gregory Clement <gregory.clement@free-electrons.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/dove/
>  F:	arch/arm/mach-dove/
>  F:	arch/arm/mach-mv78xx0/
>  F:	arch/arm/mach-orion5x/
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
