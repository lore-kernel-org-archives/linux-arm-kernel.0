From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 13:16:34 -0700
Subject: [PATCH v3 1/4] arm/dts: regulator: Add tps65910 device tree data
In-Reply-To: <20120821180847.GC7995@opensource.wolfsonmicro.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-2-git-send-email-anilkumar@ti.com>
 <5033ADC5.4030002@wwwdotorg.org>
 <20120821163805.GW7995@opensource.wolfsonmicro.com>
 <5033CDDB.808@wwwdotorg.org>
 <20120821180847.GC7995@opensource.wolfsonmicro.com>
Message-ID: <20120824201634.GZ11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120821 11:09]:
> On Tue, Aug 21, 2012 at 12:05:15PM -0600, Stephen Warren wrote:
> > On 08/21/2012 10:38 AM, Mark Brown wrote:
> 
> > > This isn't the general view for the regualtor API - we generally
> > > want all regulators to be registered in order to allow us to see
> > > what's going on with things even if we've not figured them out from
> > > software.
> 
> > Oh, I said the above specifically because when I added the LDO
> > configuration for the regulators that weren't used to the Tegra .dts
> > files, you told me to remove it, based on the comment I put in there
> > that they weren't used on the board.
> 
> The board shouldn't have to define the regulators, the regulator driver
> really ought to be able to figure out that they're there by itself if
> there's no configuration based purely on knowing which chip is there.
> From that point of view it's OK for the chip .dtsi to have them (though
> ideally the driver wouldn't *need* that either) which was what was
> happening here.

So I assume no changes needed here then?

Regards,

Tony
