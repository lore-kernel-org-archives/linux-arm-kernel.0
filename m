From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Apr 2012 16:04:44 -0600 (MDT)
Subject: [PATCH 08/12] arm: omap3: am35x: Fix clockdomain dependencies
In-Reply-To: <20120411215513.GA31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-9-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111540060.29473@utopia.booyaka.com>
 <20120411215513.GA31197@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1204111555360.29473@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> On Wed, Apr 11, 2012 at 03:44:38PM -0600, Paul Walmsley wrote:
> 
> > Looks like there are an extra set of commas here, maybe just use:
> > 
> > static struct clkdm_dep gfx_sgx_am35x_wkdeps[] = {
> > 	{ .clkdm_name = "mpu_clkdm" },
> > 	{ .clkdm_name = "wkup_clkdm" },
> > 	{ NULL },
> 
> Yes, there are extra commas but they come from the code I'm copying
> and removing iva2_clkdm from.  I was keeping things consistent so I
> kept the commas.  Given that, do you still want them removed?
> (I'm indifferent.)

Yes please.  I realize it's a minor issue, but I'd like to keep the format 
of these files internally consistent.


- Paul
