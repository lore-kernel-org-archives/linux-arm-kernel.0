From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 May 2012 14:10:18 +0800
Subject: [GIT PULL] clk for next
In-Reply-To: <20120504170533.GO4141@pengutronix.de>
References: <20120504170533.GO4141@pengutronix.de>
Message-ID: <20120505061016.GN2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 07:05:33PM +0200, Sascha Hauer wrote:
> Erm, no, this is not a pull request, more a request for a pull request.
> 
> Currently we are still missing the clk patches for next in -next. It
> should be fine to have these in arm-soc since probably no non-arm
> architecture will convert to the clock framework in the next two weeks.
> 
> Then finally we could merge SoC clk code in the arm-soc tree. BTW there
> are lready spear clk patches in the arm-soc tree which conflict with
> Mikes branch so Viresh might have to fix them (maybe he sent the fixes
> already to the list, can't remember)
> 
> 
> So Mike, please consider sending the following pull request to Arnd:
> 

And please do not forget to pick up the patch below, Mike.

Sascha Hauer (1):
	clk: add a fixed factor clock

Since Russell has published his clkdev branch, with above patch picked
up on clk-next, I have everything ready to send my platform porting.

Thanks,
Shawn
