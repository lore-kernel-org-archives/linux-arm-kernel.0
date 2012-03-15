From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 08:01:12 +0000
Subject: [GIT PULL] ARM: OMAP: i2c, gpio, spi,
 regulator and mmc DTS updates
In-Reply-To: <20120315004638.GW12083@atomide.com>
References: <4F612C29.40608@ti.com> <20120315004638.GW12083@atomide.com>
Message-ID: <201203150801.13183.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Tony Lindgren wrote:
> * Cousson, Benoit <b-cousson@ti.com> [120314 16:41]:
> > Hi Tony,
> > 
> > Here are the remaining DTS patches for 3.4.
> > 
> > On top of the previous pull request, I just added the MMC DTS since the driver adaptation just got queued.
> > 
> > It will be still be good to have that for 3.4 if possible, otherwise we will
> > have a bunch of drivers DT adapted but no DTS file to use them :-(
> 
> This might be doable as a follow-up patch series at the end
> of the merge window or at -rc1 when the related driver changes
> have been merged.
> 
> Arnd and Olof, what do you guys think?

I'll have to look at the patches more closely, but from the diffstat it definitely
looks ok for a later merge once the driver is in. If you can rebase the branch on
top of the mmc tree (or the merge of that tree with whatever else is needed), it
should give us a bisectable history and I can stick it into a late/* branch right
away.

	Arnd
