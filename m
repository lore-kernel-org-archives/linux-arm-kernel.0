From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2015 05:53:43 -0800
Subject: OMAP display kconfig options changing
In-Reply-To: <5673CA0D.4000706@ti.com>
References: <5673CA0D.4000706@ti.com>
Message-ID: <20151218135342.GF23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tomi Valkeinen <tomi.valkeinen@ti.com> [151218 00:55]:
> Hi Tony,
> 
> I've just pushed a patch series to fbdev for-next branch which makes the
> OMAP DRM and FB drivers independent of each other. This requires
> changing the related Kconfig options.

OK

> What should I do with omap2plus_defconfig?
> 
> At the moment omap2plus_defconfig enables the omapfb driver and panels
> as modules. Should I change it to do the same with the new code? Or
> should I change it to use omapdrm, which is the better maintained and
> developed driver (although no one has probably tried omapdrm on omap2)?

I'm all for changing omap2plus_defconfnig to use omapdrm.

Do you have a link to a page we can point people to for instructions
for what needs to be changed to get things working with omapdrm?

For omap2, I can try to peek into my rack for n800.

Regards,

Tony
