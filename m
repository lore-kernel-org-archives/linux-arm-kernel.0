From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 20 Sep 2012 05:26:35 +0200
Subject: [PATCH 0/2] ARM: dts: Add subnode for ocp2scp
In-Reply-To: <1348050772-27819-1-git-send-email-kishon@ti.com>
References: <1348050772-27819-1-git-send-email-kishon@ti.com>
Message-ID: <505A8CEB.6010100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 09/19/2012 12:32 PM, Kishon Vijay Abraham I wrote:
> This patch series contains a patch to explicitly add reg property
> to the ocp2scp dt node and a patch to add the subnode for ocp2scp
> (omap-usb2).
> 
> Since the original patch series that adds ocp2scp driver and ocp2scp
> data are merged in arm-soc, I'm sending this patch series based on the
> same tree.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> 
> But Benoit already pointed out that there's going to be merge conflicts
> as he has sent a bunch of dt data patches to linux-omap (devel-dt) tree.
> So now I'm not sure how that can be actually avoided.

What would you suggest?

I merged arm-soc/drivers/ocp2scp into my dts branch to get a proper base
for that series, but as expected, it conflicts :-(

So I fixed that and pulled this series on top of it.

It is something acceptable for a pull request? We already did that in
the past, but at that time it was not conflicting.

Thanks,
Benoit
