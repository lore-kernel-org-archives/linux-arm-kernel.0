From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Nov 2012 17:16:21 +0800
Subject: [PATCH] ARM i.MX6: Fix ethernet PLL clocks
In-Reply-To: <20121122084707.GA10369@pengutronix.de>
References: <1353505652-28200-1-git-send-email-s.hauer@pengutronix.de>
 <20121122084228.GF24693@S2100-06.ap.freescale.net>
 <20121122084707.GA10369@pengutronix.de>
Message-ID: <20121122091618.GH24693@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 09:47:07AM +0100, Sascha Hauer wrote:
> On Thu, Nov 22, 2012 at 04:42:31PM +0800, Shawn Guo wrote:
> > On Wed, Nov 21, 2012 at 02:47:32PM +0100, Sascha Hauer wrote:
> > > In current code the ethernet PLL (according to code pll8, according to datasheet
> > > pll6)
> > 
> > Yes, just checked the latest RM, it gets renumbered so.
> 
> So do we want to keep current code or change it according to the
> datasheet?
> 
While you are there, yeah, let's make it match doc :)

Shawn
