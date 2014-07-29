From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jul 2014 04:07:54 -0700
Subject: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <20140725165304.GD29132@saruman.home>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
 <20140725165304.GD29132@saruman.home>
Message-ID: <20140729110754.GN29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140725 09:55]:
> On Tue, Jul 22, 2014 at 09:14:20PM +0000, Paul Walmsley wrote:
> > On Tue, 17 Jun 2014, Tomi Valkeinen wrote:
> > 
> > > From: Sathya Prakash M R <sathyap@ti.com>
> > > 
> > > Add DSS hwmod data for AM43xx.
> > > 
> > > Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> > > [tomi.valkeinen at ti.com: added missing dispc flags]
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Acked-by: Rajendra Nayak <rnayak@ti.com>
> > 
> > This one didn't compile on an AM43xx-only build:
> > 
> > ----
> > arch/arm/mach-omap2/built-in.o:(.data+0x3f2c): undefined reference to `omap2_dss_hwmod_class'
> > arch/arm/mach-omap2/built-in.o:(.data+0x405c): undefined reference to `omap2_rfbi_hwmod_class'
> > make: *** [vmlinux] Error 1
> > test_build: Tue Jul 22 13:48:50 MDT 2014: FAILED on omap2plus_defconfig_am43xx_only hwmod-a-v3.17
> > ----
> > 
> > Have queued the following patch instead.
> 
> queued for v3.17, I assume. Still not available from linux-next though.

Should be in linux-next now.

Tony
