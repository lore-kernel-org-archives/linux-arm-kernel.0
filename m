From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Feb 2014 23:01:35 +0800
Subject: [GIT PULL] ARM: imx: device tree changes for 3.15, take 1
In-Reply-To: <201402061445.06234.arnd@arndb.de>
References: <20140205122258.GA13821@S2101-09.ap.freescale.net>
 <201402061445.06234.arnd@arndb.de>
Message-ID: <20140206150131.GC6610@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 02:45:05PM +0100, Arnd Bergmann wrote:
> On Wednesday 05 February 2014, Shawn Guo wrote:
> > Hi arm-soc folks,
> > 
> > This is basically imx-dt-3.14 pull request that missed the 3.14 merge
> > window with the pingrp removal series applied on top of.  It also
> > includes a few additional board support I collected since imx-dt-3.14.
> > There will be another round of IMX DT changes for 3.15 later, but this
> > one should be the majority.  Please pull, thanks.
> 
> Hi Shawn,
> 
> no objections to the stuff you add here, but the way it's organized
> is not good. Instead of adding the controversial patches first and
> then reverting them, please redo the series so you don't actually
> have the patches in the history. I see that you have rebased the
> patches on 3.14-rc1 already so there really shouldn't be any cross-
> tree dependencies that make it necessary to keep them in.

I haven't checked the patches one by one in the pull request, but it
probably means that I will have to redo most of the patches, because
every single new board dts and addition of device for existing board
have new pinctrl data along with them.  I will look at the work/effort
closer tomorrow.

> 
> Also, because of the pure size of the pull request:
> 
>  105 files changed, 14073 insertions(+), 3127 deletions(-)
> 
> it would be nice to split it up into smaller units. A good
> separation would be to have new board support in one pull
> request and the changes to existing boards in another one.

Ok, I will try.

Shawn
