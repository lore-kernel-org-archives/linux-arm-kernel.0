From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Aug 2011 00:29:19 +0900
Subject: [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110802095141.GA2095@pengutronix.de>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<20110802095141.GA2095@pengutronix.de>
Message-ID: <20110802152918.GD25884@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 11:51:41AM +0200, Wolfram Sang wrote:

> So, do I get it right, that my initial patch (attached below again)
> might be interesting after all, because it makes the register layout
> truly flat (also makes the driver usable for me). Then, based on that, a
> new cache type which takes step size into account could be added to the
> soc-core and the codec driver can be later switched to the new cache
> type?

Yes, this is entirely sensible.  Even if there are issues with this
approach they're kept local to the CODEC driver.  Please send normally
for review.
