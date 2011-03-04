From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 4 Mar 2011 11:22:50 +0800
Subject: [PATCH 1/2] ARM: imx5x: clean up ARCH_MX5X
In-Reply-To: <20110303105638.GD1655@S2101-09.ap.freescale.net>
References: <1299141603-22148-1-git-send-email-richard.zhao@freescale.com>
	<20110303104823.GC1655@S2101-09.ap.freescale.net>
	<20110303105638.GD1655@S2101-09.ap.freescale.net>
Message-ID: <20110304032249.GC12223@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 06:56:38PM +0800, Shawn Guo wrote:
> On Thu, Mar 03, 2011 at 06:48:23PM +0800, Shawn Guo wrote:
> > On Thu, Mar 03, 2011 at 04:40:02PM +0800, Richard Zhao wrote:
> > > Move to SOC_SOC_IMX5X. Leave only places which prevent multi-soc
> >           ^^^^^^^^^^^^^
> > SOC_IMX51?  Same question on SOC_SOC_IMX3X in the second patch.
> > 
> What I meant is SOC_IMX5X.  Double 'SOC_' bothers me.
> 
My mail box went wrong yesterday.  The messages were not delivered.
As Sascha has picked them up, it may not worth a fix.

-- 
Regards,
Shawn
