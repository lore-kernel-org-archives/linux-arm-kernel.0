From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Mar 2015 15:45:59 +0000 (UTC)
Subject: [PATCH 2/2] ARM: dts: dra7: remove ti,hwmod property from pcie phy
In-Reply-To: <550AEDA1.50109@linaro.org>
References: <1424422274-27946-1-git-send-email-kishon@ti.com>
 <1424422274-27946-2-git-send-email-kishon@ti.com> <5509A998.2080509@ti.com>
 <20150318165706.GQ31346@atomide.com> <5509D3BD.6030004@linaro.org>
 <alpine.DEB.2.02.1503191455020.9480@utopia.booyaka.com>
 <550AEDA1.50109@linaro.org>
Message-ID: <alpine.DEB.2.02.1503191541270.9480@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015, Grygorii.Strashko at linaro.org wrote:

> On 03/19/2015 04:55 PM, Paul Walmsley wrote:
> > On Wed, 18 Mar 2015, Grygorii.Strashko at linaro.org wrote:
> > 
> > > On 03/18/2015 06:57 PM, Tony Lindgren wrote:
> > > > * Grygorii Strashko <grygorii.strashko@ti.com> [150318 09:37]:
> > > > > As I can see Patch 1 from this series was merged in 4.0-rc4,
> > > > > but this patch wasn't. As result, I can see below warning all the time
> > > > > during boot now:
> > > > > 
> > > > > [    0.594591] platform 4a094000.pciephy: Cannot lookup hwmod
> > > > > 'pcie1-phy'
> > > > 
> > > > OK. Is this needed as a fix for the v4.0-rc series, or can this wait
> > > > for v4.1?
> > > 
> > > I think, Yes. These two patches should go all together, because they are
> > > interrelated.
> > 
> > Does the warning result in a functional problem, or is it just a warning?
> > 
> 
> PCE1 PHY device is not registered any more.

How does the second patch fix that?

- Paul
