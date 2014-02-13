From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 15:28:43 -0800
Subject: [PATCH] ARM: OMAP2+: Remove MACH_NOKIA_N800
In-Reply-To: <20140209195021.GE573@drone.musicnaut.iki.fi>
References: <1391958088.25424.17.camel@x220>
 <20140209195021.GE573@drone.musicnaut.iki.fi>
Message-ID: <20140213232842.GS28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [140209 11:53]:
> Hi,
> 
> On Sun, Feb 09, 2014 at 04:01:28PM +0100, Paul Bolle wrote:
> > The last caller of machine_is_nokia_n800() was removed in commit
> > 5a87cde490e1 ("ARM: OMAP2+: Remove legacy booting support for n8x0").
> > That means that the Kconfig symbol MACH_NOKIA_N800 is now unused. It can
> > safely be removed.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks applying into omap-for-v3.14/fixes.

Tony
