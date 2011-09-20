From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 21:34:50 +0200
Subject: [PATCH REPOST 1/2] arm/dt: Tegra: Update SDHCI nodes to match
	bindings
In-Reply-To: <20110920180731.GL7781@ponder.secretlab.ca>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
	<201109201943.29510.arnd@arndb.de>
	<20110920180731.GL7781@ponder.secretlab.ca>
Message-ID: <201109202134.50242.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 September 2011, Grant Likely wrote:
> On Tue, Sep 20, 2011 at 07:43:29PM +0200, Arnd Bergmann wrote:
> > On Tuesday 20 September 2011, Stephen Warren wrote:
> > > The bindings were recently updated to have separate properties for each
> > > type of GPIO. Update the Device Tree source to match that.
> > > 
> > > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > > Acked-by: Olof Johansson <olof@lixom.net>
> > > ---
> > > I'd previously sent these to Grant assuming they'd go in his dt/next branch,
> > > but perhaps these should go in through Arnd's arm-soc next/dt branch?
> > > 
> > 
> > Which tree has the update that changed the bindings? I think it should
> > go into the same one.
> > 
> > If it's already upstream, I can take it into the fixes branch.
> 
> Already upstream

Ok, I see. I've applied both patches to the fixes branch and will send
it out with the next pull request for 3.1 to Linus then.

Thanks,

	Arnd
