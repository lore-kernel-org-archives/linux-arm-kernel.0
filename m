From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Apr 2018 14:17:37 +0100
Subject: [PATCH] ARM: Assume maintainership of ARM reference designs
In-Reply-To: <20180412131426.18011-1-linus.walleij@linaro.org>
References: <20180412131426.18011-1-linus.walleij@linaro.org>
Message-ID: <20180412131737.GF16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I haven't given up my maintainership, as I had already stated.

NAK.

On Thu, Apr 12, 2018 at 03:14:26PM +0200, Linus Walleij wrote:
> With this I assume maintainership of the Integrator, Versatile
> and RealView ARM reference machines.
> 
> It's no big secret that I've been maintaining them for years,
> but might as well make it official so I get the mails and
> don't miss anything.
> 
> I have also included some drivers that are closely associated
> with the ARM reference designs and yet orphaned in the
> MAINTAINERS file. I can surely maintain them too, or route
> the question to the right people so it doesn't fall on the
> floor of upward to the subsystem maintainers who have too much
> to do already as it is.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> If someone has an active interest and wants to comaintain the
> old ARMv4, ARMv5, ARMv6 and ARMv7 reference designs in this
> family, you are most welcome.
> 
> If you feel that I am expropriating
> a driver from you, tell me and I will create a separate
> MAINATINERS entry for that driver and drop it from this one.
> I put all relevant subsystem mainatainers on CC I think.
> 
> If you feel I should split some drivers to separate entries
> I can do that too.
> ---
>  MAINTAINERS | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7182d2a9f5c..2991d20cb406 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1026,6 +1026,31 @@ F:	arch/arm/include/asm/arch_timer.h
>  F:	arch/arm64/include/asm/arch_timer.h
>  F:	drivers/clocksource/arm_arch_timer.c
>  
> +ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
> +M:	Linus Walleij <linus.walleij@linaro.org>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/arm-boards
> +F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
> +F:	Documentation/devicetree/bindings/clock/arm-integrator.txt
> +F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
> +F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
> +F:	arch/arm/mach-integrator/
> +F:	arch/arm/mach-realview/
> +F:	arch/arm/mach-versatile/
> +F:	arch/arm/plat-versatile/
> +F:	arch/arm/boot/dts/arm-realview-*
> +F:	arch/arm/boot/dts/integrator*
> +F:	arch/arm/boot/dts/versatile*
> +F:	drivers/clk/versatile/
> +F:	drivers/i2c/busses/i2c-versatile.c
> +F:	drivers/irqchip/irq-versatile-fpga.c
> +F:	drivers/irqchip/irq-vic.c
> +F:	drivers/mtd/maps/physmap_of_versatile.c
> +F:	drivers/power/reset/arm-versatile-reboot.c
> +F:	drivers/soc/versatile/
> +F:	drivers/spi/spi-pl022.c
> +
>  ARM HDLCD DRM DRIVER
>  M:	Liviu Dudau <liviu.dudau@arm.com>
>  S:	Supported
> -- 
> 2.14.3
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
