From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 20 Sep 2011 12:07:31 -0600
Subject: [PATCH REPOST 1/2] arm/dt: Tegra: Update SDHCI nodes to match
	bindings
In-Reply-To: <201109201943.29510.arnd@arndb.de>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
	<201109201943.29510.arnd@arndb.de>
Message-ID: <20110920180731.GL7781@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 07:43:29PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 September 2011, Stephen Warren wrote:
> > The bindings were recently updated to have separate properties for each
> > type of GPIO. Update the Device Tree source to match that.
> > 
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > Acked-by: Olof Johansson <olof@lixom.net>
> > ---
> > I'd previously sent these to Grant assuming they'd go in his dt/next branch,
> > but perhaps these should go in through Arnd's arm-soc next/dt branch?
> > 
> 
> Which tree has the update that changed the bindings? I think it should
> go into the same one.
> 
> If it's already upstream, I can take it into the fixes branch.

Already upstream

g.
