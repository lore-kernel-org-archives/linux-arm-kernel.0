From: mporter@ti.com (Matt Porter)
Date: Fri, 19 Oct 2012 12:32:37 -0400
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <20121019160041.GB4730@atomide.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at>
 <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
 <20121019160041.GB4730@atomide.com>
Message-ID: <20121019163237.GG25164@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 09:00:41AM -0700, Tony Lindgren wrote:
> * Richard Cochran <richardcochran@gmail.com> [121018 23:18]:
> > On Fri, Oct 19, 2012 at 02:18:29AM +0530, Vaibhav Hiremath wrote:
> > > 
> > > Another important point is, this driver is also required and used for
> > > Davinci family of devices (arch/mach/mach-davinci/).
> > 
> > That is really beside the point. If the code isn't ready yet, then
> > don't merge it.
> > 
> > When I asked about the beaglebone, I was given the impression that it
> > will be ready for v3.7-rc1.  But, as I know realize, at the current
> > rate, it might not even be ready for v3.8.
> > 
> > I don't mind waiting, but please make sure that whatever lands into a
> > release is really, truly working.
> 
> Indeed. This has been a problem with many of the TI patches in
> general. People are working on separate product trees and then produce
> patches for the mainline kernel that are poorly tested.
> 
> The requirement should be: Do your patch on an omap board then send the
> patch from your omap board after booting your board with the patch :)

s/should be/is/

I fixed that for you. :) That's always been the requirement for the
kernel, period. There's also a lot of dead/unused code in the davinci
driver world too...so omap isn't alone with this phenomenon.

-Matt
