From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 13 Jul 2015 19:43:13 +0800
Subject: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
In-Reply-To: <20150709132736.GG23464@tiger>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
 <20150709075032.GD23464@tiger>
 <20150709092949.GB3917@shlinux1.ap.freescale.net>
 <20150709132736.GG23464@tiger>
Message-ID: <20150713114310.GA9453@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 09:27:36PM +0800, Shawn Guo wrote:
> On Thu, Jul 09, 2015 at 05:29:50PM +0800, Dong Aisheng wrote:
> > I agree with you.
> > One difference is that i'd like to fix it ASAP without reverting 8d86e4f
> > due to more patches depends on it is already there as i mentioned above..
> > Revert it may need to revert a lot others.
> > 
> > The pain is that v4.1 is left broken.
> 
> Oh, crap!  I thought it's been there with only v4.2-rc1, and did not
> know v4.1 is already broken.  In that case, reverting 8d86e4f isn't
> the best option.  I suggest you rebase the dts series on top of
> v4.2-rc1, and send it via mmc tree.
> 

Yes, will go that way.

Then you may need help take care of new dts going through your tree
to make sure no broken code in again.

Thanks

Regards
Dong Aisheng

> Shawn
