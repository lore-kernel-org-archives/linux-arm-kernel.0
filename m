From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 13 Sep 2012 14:38:30 +0800
Subject: [GIT PULL 2/2] imx6q clk device tree lookup
In-Reply-To: <20120913062305.GJ24290@quad.lixom.net>
References: <1347364968-27496-1-git-send-email-shawn.guo@linaro.org>
 <1347364968-27496-3-git-send-email-shawn.guo@linaro.org>
 <20120913062305.GJ24290@quad.lixom.net>
Message-ID: <20120913063826.GD3141@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 11:23:05PM -0700, Olof Johansson wrote:
> On Tue, Sep 11, 2012 at 08:02:48PM +0800, Shawn Guo wrote:
> > The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> > 
> >   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-clk-dt-lookup
> > 
> > for you to fetch changes up to 0e87e0436c0cc3954eb62181a96d7217ca955a4f:
> > 
> >   ARM: imx6q: replace clk_register_clkdev with clock DT lookup (2012-09-11 19:16:14 +0800)
> > 
> > ----------------------------------------------------------------
> > imx-clk-dt-lookup
> > 
> > It replaces the clk_register_clkdev in imx6q clock driver with DT
> > lookup.  It depends on Mike's clk-3.7 branch.
> > 
> > When it gets merged together with imx-dt-3.7, there is a trivial
> > conflict on arch/arm/boot/dts/imx6q.dtsi.
> 
> Pulled into next/dt. Same here, double-check my conflict resolution please.
> 
It's all right.

-- 
Regards,
Shawn
