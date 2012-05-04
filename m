From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 4 May 2012 21:48:28 +0800
Subject: [PATCH] ARM: imx: rename uart and fec device tree nodes
In-Reply-To: <4FA3DB37.8080002@de.bosch.com>
References: <1333350084-5993-1-git-send-email-shawn.guo@linaro.org>
 <4FA39D65.3020007@de.bosch.com>
 <20120504133301.GJ2194@S2101-09.ap.freescale.net>
 <4FA3DB37.8080002@de.bosch.com>
Message-ID: <20120504134825.GK2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 03:35:51PM +0200, Dirk Behme wrote:
> Yes, I think so
> 
> https://github.com/dirkbehme/linux-imx6/commit/ebfac55f157425b5e063cdb2d9668b45a0a6515f#diff-14
> 
> >It reminds me that I should rebase my imx/dt branch on Sascha's clk
> >series to save the conflict.
> 
> My test branch has Sascha's clk series, too. It's mainly based on
> 
> https://github.com/dirkbehme/linux-imx6/commits/linux-imx6-staging
> 
If you have Sascha's clk series merged, the changes on clock-imx6q.c
made by this patch could probably get lost, since Sascha's clk series
will remove clock-imx6q.c.

-- 
Regards,
Shawn
