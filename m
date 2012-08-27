From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 09:51:38 -0700
Subject: [PATCH v3 1/4] arm/dts: regulator: Add tps65910 device tree data
In-Reply-To: <20120824201634.GZ11011@atomide.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-2-git-send-email-anilkumar@ti.com>
 <5033ADC5.4030002@wwwdotorg.org>
 <20120821163805.GW7995@opensource.wolfsonmicro.com>
 <5033CDDB.808@wwwdotorg.org>
 <20120821180847.GC7995@opensource.wolfsonmicro.com>
 <20120824201634.GZ11011@atomide.com>
Message-ID: <20120827165137.GL4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 01:16:34PM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [120821 11:09]:

> > The board shouldn't have to define the regulators, the regulator driver
> > really ought to be able to figure out that they're there by itself if
> > there's no configuration based purely on knowing which chip is there.
> > From that point of view it's OK for the chip .dtsi to have them (though
> > ideally the driver wouldn't *need* that either) which was what was
> > happening here.

> So I assume no changes needed here then?

Seems that way.
