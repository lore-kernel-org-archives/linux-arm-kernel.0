From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 10:14:45 +0800
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120502015650.GE17311@gmail.com>
References: <20120426095135.GG17184@pengutronix.de>
 <4F9EE84C.90106@codeaurora.org>
 <CAJOA=zNCagT6GaeHi_jq7-LU9P-SfJZ8PA9bo-oeswjC0tHyYA@mail.gmail.com>
 <4F9F1659.1010804@codeaurora.org>
 <20120501081103.GC2194@S2101-09.ap.freescale.net>
 <20120501091334.GG15541@lunn.ch>
 <20120501170001.GB4089@opensource.wolfsonmicro.com>
 <4FA0258D.8020807@codeaurora.org>
 <20120501181922.GD4089@opensource.wolfsonmicro.com>
 <20120502015650.GE17311@gmail.com>
Message-ID: <20120502021443.GQ2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 06:56:50PM -0700, Mike Turquette wrote:
> I could use some suggestions on the best way to resolve the merge issues
> we have currently.  It appears that we have three bases that platforms
> need to port over the common clk framework:
> 
> Russell's clkdev
> Arnd's arm-soc
> My clk-next branch
> 
> I was happy to push my changes to Linus directly (as discussed in
> previous mails) but I'm starting to think that maybe having Arnd absorb
> the clk-next branch as part of arm-soc would be the fastest way to
> assist platforms that are porting over.
> 
> Do the platform folks agree?  Is this suggestion sane?
> 
As one of the people who are working on platform porting, I'm not
concerned about the path that clk core goes to Linus, but the time
when we have a stable clk core branch appears on arm-soc either as
a dependency or a downstream tree.  Once we have stable branches for
both rmk's clkdev and clk core appear on arm-soc, we can start asking
Arnd to pull platform porting.

-- 
Regards,
Shawn
