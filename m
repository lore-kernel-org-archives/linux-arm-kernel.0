From: cjb@laptop.org (Chris Ball)
Date: Tue, 19 Oct 2010 20:45:16 +0100
Subject: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
In-Reply-To: <20101019193638.GB31336@pengutronix.de>
References: <1287492541-3060-1-git-send-email-eric@eukrea.com>
	<20101019150743.GA26784@pengutronix.de>
	<4CBDB694.4000209@eukrea.com>
	<20101019193638.GB31336@pengutronix.de>
Message-ID: <20101019194516.GA28424@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 09:36:38PM +0200, Wolfram Sang wrote:
> > I do have, but I can't do the tests until next week because of other priorities.
> 
> I'd suggest to add a proper patch next week then (maybe together with correct
> usage of the MULTIBLOCK-quirk, too?). It's a new driver, so adding update
> patches late in the cycle should not cause problems? Of course, Chris makes the
> final decision about that.

Fine with me, tested patches are good.  There's no need to rush to get
it in before -rc1. 

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
