From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 25 Mar 2018 08:27:32 +0100
Subject: [PATCH 2/2] MAINTAINERS: demote ARM port to "odd fixes"
In-Reply-To: <E1ezkgn-0002fO-52@rmk-PC.armlinux.org.uk>
References: <E1ezkgn-0002fO-52@rmk-PC.armlinux.org.uk>
Message-ID: <CAKv+Gu8v_+P-VwggmUfE5zq353YN6RqG63YQs+xDZVYUtqc=4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2018 at 15:02, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> As of the start of 2018, I am no longer paid to support the core 32-bit
> ARM architecture code.  This means that this code is no longer
> commercially supported, and is now only supported through voluntary
> effort.
>

Hello Russell,

It is quite obvious what you are doing here, and FWIW, I personally
think you should be on the ARM payroll for looking after the 32-bit
port. However, I don't think it is appropriate to involve the
community into this. If you cannot afford to spend time on this, the
right thing to do would be to either share the responsibility with
co-maintainers (which many architecture ports do these days), or step
down and let someone else take over entirely.

In my opinion, letting the ARM port wither to extort money out of ARM
Ltd. is not something the Linux community should be accessory to.

Regards,
Ard.


> I will continue to merge patches as and when able, but this will be at
> a lower priority than before (which means a longer latency.)  I have
> also be scaled back the amount of time spent reading email, so email
> that is intended for my attention needs to make itself plainly
> obvious, or I will miss it.
>
> In an attempt to reduce the amount of email Cc'd to me, exclude
> arch/arm/boot/dts from the maintainers patterns, but add entries for
> the SolidRun platforms I look after.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  MAINTAINERS | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c4399af21986..fcb49a81a92b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1060,41 +1060,42 @@ ARM PORT
>  M:     Russell King <linux@armlinux.org.uk>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  W:     http://www.armlinux.org.uk/
> -S:     Maintained
> +S:     Odd Fixes
>  T:     git git://git.armlinux.org.uk/~rmk/linux-arm.git
>  F:     arch/arm/
> +X:     arch/arm/boot/dts/
>
>  ARM PRIMECELL AACI PL041 DRIVER
>  M:     Russell King <linux@armlinux.org.uk>
> -S:     Maintained
> +S:     Odd Fixes
>  F:     sound/arm/aaci.*
>
>  ARM PRIMECELL BUS SUPPORT
>  M:     Russell King <linux@armlinux.org.uk>
> -S:     Maintained
> +S:     Odd Fixes
>  F:     drivers/amba/
>  F:     include/linux/amba/bus.h
>
>  ARM PRIMECELL CLCD PL110 DRIVER
>  M:     Russell King <linux@armlinux.org.uk>
> -S:     Maintained
> +S:     Odd Fixes
>  F:     drivers/video/fbdev/amba-clcd.*
>
>  ARM PRIMECELL KMI PL050 DRIVER
>  M:     Russell King <linux@armlinux.org.uk>
> -S:     Maintained
> +S:     Odd Fixes
>  F:     drivers/input/serio/ambakmi.*
>  F:     include/linux/amba/kmi.h
>
>  ARM PRIMECELL MMCI PL180/1 DRIVER
>  M:     Russell King <linux@armlinux.org.uk>
> -S:     Maintained
> +S:     Odd Fixes
>  F:     drivers/mmc/host/mmci.*
>  F:     include/linux/amba/mmci.h
>
>  ARM PRIMECELL UART PL010 AND PL011 DRIVERS
>  M:     Russell King <linux@armlinux.org.uk>
> -S:     Maintained
> +S:     Odd Fixes
>  F:     drivers/tty/serial/amba-pl01*.c
>  F:     include/linux/amba/serial.h
>
> @@ -12859,6 +12860,19 @@ S:     Maintained
>  F:     drivers/net/ethernet/socionext/netsec.c
>  F:     Documentation/devicetree/bindings/net/socionext-netsec.txt
>
> +SOLIDRUN CLEARFOG SUPPORT
> +M:     Russell King <linux@armlinux.org.uk>
> +S:     Maintained
> +F:     arch/arm/boot/dts/armada-388-clearfog*
> +F:     arch/arm/boot/dts/armada-38x-solidrun-*
> +
> +SOLIDRUN CUBOX-I/HUMMINGBOARD SUPPORT
> +M:     Russell King <linux@armlinux.org.uk>
> +S:     Maintained
> +F:     arch/arm/boot/dts/imx6*-cubox-i*
> +F:     arch/arm/boot/dts/imx6*-hummingboard*
> +F:     arch/arm/boot/dts/imx6*-sr-*
> +
>  SONIC NETWORK DRIVER
>  M:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>  L:     netdev at vger.kernel.org
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
