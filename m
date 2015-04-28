From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Apr 2015 08:43:37 +0800
Subject: [PATCH V2] ARM: dts: imx28: Fix AUART4 TX-DMA interrupt name
In-Reply-To: <201504271816.11902.marex@denx.de>
References: <1429874987-5481-1-git-send-email-marex@denx.de>
 <20150427144627.GD1788@dragon> <201504271816.11902.marex@denx.de>
Message-ID: <20150428004336.GA18776@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 06:16:11PM +0200, Marek Vasut wrote:
> On Monday, April 27, 2015 at 04:46:29 PM, Shawn Guo wrote:
> > On Fri, Apr 24, 2015 at 01:29:47PM +0200, Marek Vasut wrote:
> > > Fix a typo in the TX DMA interrupt name for AUART4.
> > > This patch makes AUART4 operational again.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > 
> > Applied, thanks.
> 
> Thanks!
> 
> It'd be really great if this could be applied to stable.
> It's rather obvious that AUART4 is not used very much, so
> noone spotted this before, but it'd still be nice to have
> this fixed.

The stable Cc tag in the patch [1] will just do the job.

Shawn

[1]
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/fixes&id=4ada77e37a773168fea484899201e272ab44ba8b
