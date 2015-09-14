From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Sep 2015 11:58:45 -0700
Subject: [PATCH] ARM: dts: omap3-igep: Move eth IRQ pinmux to IGEPv2
 common dtsi
In-Reply-To: <CAFqH_50Hbzu1WDV7O3_jnUKVZ2Hhg_0PvV9jR_R1PkhfJ1MAxQ@mail.gmail.com>
References: <1441643058-8641-1-git-send-email-javier@osg.samsung.com>
 <CAFqH_50Hbzu1WDV7O3_jnUKVZ2Hhg_0PvV9jR_R1PkhfJ1MAxQ@mail.gmail.com>
Message-ID: <20150914185844.GU4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo Serra <eballetbo@gmail.com> [150907 12:43]:
> 2015-09-07 18:24 GMT+02:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> > Only the IGEPv2 boards have a LAN9221i chip connected to the GPMC
> > so the pinmux configuration for the GPIO connected to the IRQ line
> > of the LAN chip should not be defined in the IGEP common dtsi but
> > in the one common to the IGEPv2 boards.
> >
> > While there, use the OMAP3_CORE1_IOPAD() macro for the padconf reg.
> >
> > Suggested-by: Ladislav Michl <ladis@linux-mips.org>
> > Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
...
> 
> Looks good to me.
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applying into omap-for-v4.3/fixes thanks.

Tony
