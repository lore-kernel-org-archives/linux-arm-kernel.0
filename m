From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 11 May 2016 20:15:12 +0800
Subject: [GIT PULL] i.MX clock fixes for 4.6, take 2
In-Reply-To: <20160506180217.GW3492@codeaurora.org>
References: <20160503133605.GN5874@tiger>
 <20160506180217.GW3492@codeaurora.org>
Message-ID: <20160511121512.GP5874@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2016 at 11:02:17AM -0700, Stephen Boyd wrote:
> On 05/03, Shawn Guo wrote:
> > The following changes since commit 7196c52c9377df0175b510ff5896bda524f7345e:
> > 
> >   clk: imx6q: fix typo in CAN clock definition (2016-04-13 15:27:15 +0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-fixes-4.6-2
> > 
> > for you to fetch changes up to 3397c2c45b1b6f54834dfeae30a73046f33ca943:
> > 
> >   ARM: dts: imx35: restore existing used clock enumeration (2016-04-18 12:37:21 +0800)
> > 
> > ----------------------------------------------------------------
> > The i.MX clock fixes for 4.6, take 2:
> >  - Fix the commit 3713e3f5e927 ("clk: imx35: define two clocks for rtc")
> >    which messed up the clock enumeration when adding new clock.
> 
> This commit wasn't introduced in this merge window, so I'm going
> to pull this into clk-next unless you have some justification.

That's fine.  Thanks, Stephen.

Shawn
