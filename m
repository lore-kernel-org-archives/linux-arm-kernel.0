From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 22 Oct 2011 08:58:01 +0800
Subject: [GIT PULL] i.MX6Q support
In-Reply-To: <20111021180158.GI23421@pengutronix.de>
References: <20111020171158.GJ32007@S2100-06.ap.freescale.net>
	<20111020211834.GF21648@n2100.arm.linux.org.uk>
	<109937284.AlYUSiDe0P@wuerfel>
	<20111021180158.GI23421@pengutronix.de>
Message-ID: <20111022005800.GC337@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2011 at 08:01:58PM +0200, Sascha Hauer wrote:
> On Fri, Oct 21, 2011 at 12:23:33AM +0200, Arnd Bergmann wrote:
> > On Thursday 20 October 2011 22:18:34 Russell King - ARM Linux wrote:
> > > On Fri, Oct 21, 2011 at 01:11:59AM +0800, Shawn Guo wrote:
> > > > Please pull imx6q series.  It's based on v3.1-rc10 with the following
> > > > branches merged plus a number of cache-l2x0 patches currently sitting
> > > > on rmk/for-next.
> > > 
> > > Don't do that.  If there's something you need, ask me.  The L2x0
> > > patches got shuffled out into their own branch when the SMP and debug
> > > patches got split out of the 'misc' branch.
> > 
> > Since I already had the branches at hand for the highbank tree, I
> > gave this a go and rebased the imx6q branch on top of the stable branches
> > that are there and confirmed that it actually builds.
> > 
> > I have pulled the result into the next/soc branch along with highbank
> > and picoxcell.
> > 
> > Shawn and Sascha, can you confirm that this is correct?
> 
> Adding the following at least gives a compilable result. Works on i.MX3,
> I couldn't test on i.MX6 though.

It works for imx6q.

-- 
Regards,
Shawn

> BTW your patch exporting imx_ioremap is
> missing in your for-next branch.
