From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Mar 2014 13:36:38 -0700
Subject: [PATCH] ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM
In-Reply-To: <7hy50ekl8g.fsf@paris.lan>
References: <1394660600-3771-1-git-send-email-nm@ti.com>
 <7hy50ekl8g.fsf@paris.lan>
Message-ID: <20140313203637.GF5981@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [140313 11:30]:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Just like IS_PM34XX_ERRATUM, IS_PM44XX_ERRATUM is valid only if
> > CONFIG_PM is enabled, else, disabling CONFIG_PM results in build
> > failure complaining about the following:
> > arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
> > :(.text+0x8a70): undefined reference to `pm44xx_errata'
> >
> > Fixes: c962184 (ARM: OMAP4: PM: add errata support)
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Applying this into omap-for-v3.15/fixes thanks.

Tony
