From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 5 Jan 2012 13:47:54 +0800
Subject: [PATCH] ARM: imx6q: add support for IRAM
In-Reply-To: <20120105051047.GB2687@weitway>
References: <1324898123-13973-1-git-send-email-jason.chen@linaro.org>
 <20120103124501.GD13477@S2100-06.ap.freescale.net>
 <20120105051047.GB2687@weitway>
Message-ID: <20120105054753.GD14741@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 01:10:48PM +0800, Jason Chen wrote:
> On Tue, Jan 03, 2012 at 08:45:02PM +0800, Shawn Guo wrote:
> > On Mon, Dec 26, 2011 at 07:15:23PM +0800, Jason Chen wrote:
> > > +DEF_CLK(ocram_clk,   	  CCGR3, CG14, &ahb_clk,	  NULL);
> > 
> >   CC      arch/arm/mach-imx/clock-imx6q.o
> > arch/arm/mach-imx/clock-imx6q.c:1782:1: warning: ?ocram_clk? defined but not used
> it should be a dependcy of vpu/sdma who using IRAM, they can be added.

My point is your patch should not introduce any warning at any time.

-- 
Regards,
Shawn
