From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 10 Jan 2011 11:08:12 +0800
Subject: [PATCH v4 00/10] net/fec: add dual fec support for i.MX28
In-Reply-To: <20110109.154409.242134862.davem@davemloft.net>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<20110109.154409.242134862.davem@davemloft.net>
Message-ID: <20110110030811.GA415@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 09, 2011 at 03:44:09PM -0800, David Miller wrote:
> From: Shawn Guo <shawn.guo@freescale.com>
> Date: Thu, 6 Jan 2011 15:13:08 +0800
> 
> > This patch series is to add dual fec support for mx28, which is
> > a mxs-based soc. Some code changes related to the following commits
> > are also made in this patch set for some reasons.
> > 
> >  e6b043d512fa8d9a3801bf5d72bfa3b8fc3b3cc8
> >  netdev/fec.c: add phylib supporting to enable carrier detection (v2)
> > 
> >  e3fe8558c7fc182972c3d947d88744482111f304
> >  net/fec: fix pm to survive to suspend/resume
> > 
> > It's been tested on mx28 evk and mx51 babbage. For mx28, it has
> > to work against the tree
> > 
> >  git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-2.6.38
> > 
> > plus patch
> > 
> >  [PATCH v4] ARM: mxs: Change duart device to use amba-pl011
> > 
> > The 3 patches below preceding with * have changes since v3, and
> > the detailed change log can be found in individual patch.
> 
> I've applied all of the "net/fec:" patches (#1 to #5) to net-2.6,
> please push the ARM changes via the appropriate ARM tree.
> 
> Thanks.
> 
Thanks, David.  I will ping Sascha for ARM changes.

-- 
Regards,
Shawn
