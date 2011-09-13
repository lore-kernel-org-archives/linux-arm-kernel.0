From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 Sep 2011 08:07:06 +0800
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <20110912194032.GB23345@ponder.secretlab.ca>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1711465.COqYbTSZES@wuerfel>
	<20110907060501.GE8148@S2100-06.ap.freescale.net>
	<2937243.vrss2TdbGN@wuerfel>
	<20110912161201.GN1258@S2100-06.ap.freescale.net>
	<20110912194032.GB23345@ponder.secretlab.ca>
Message-ID: <20110913000705.GO1258@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 01:40:33PM -0600, Grant Likely wrote:
> On Tue, Sep 13, 2011 at 12:12:02AM +0800, Shawn Guo wrote:
> > On Wed, Sep 07, 2011 at 09:56:21AM +0200, Arnd Bergmann wrote:
> > > On Wednesday 07 September 2011 14:05:03 Shawn Guo wrote:
> > > > > My feeling is that this time, we should wait for the common clock
> > > > > framework to get in and simplify this. I believe Thomas is now planning
> > > > > to do this, but I haven't followed what the current state is.
> > > > > 
> > > > Sadly, if this is the position of entire arm-soc maintainer group,
> > > > I think I have made a wrong decision to start upstreaming imx6q now.
> > > 
> > > We haven't discussed it as a group, it's my own opinion.
> > > 
> > 
> > Hi Thomas, Grant,
> > 
> > Could you please share your opinion here?
> > 
> > I really do not see the hope that clock framework and device tree
> > binding could possibly catch v3.2 window, while I'm hoping that imx6q
> > series can go into v3.2.
> > 
> > Can you please agree that we can let the imx6q clock code in and then
> > migrate it to clock framework and device tree once they get ready?
> 
> I've not looked very deeply at this patch, but I completely agree that
> we cannot block new platforms on infrastructure that isn't remotely
> mergable at this point in time.
> 
> However, imx6 is a new platform.  There isn't any non-DT board support
> code to continue to support.  At the very least, the configurable
> parameters, like what is passed into mx6q_clocks_init() should be
> obtained from the device tree (maybe it already does this though, I
> haven't looked that closely).
> 
Ok, will do in the next post.

> In general, I say merge it.
> 
Thanks, Grant.

-- 
Regards,
Shawn
