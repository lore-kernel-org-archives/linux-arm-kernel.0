From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 7 Jun 2013 19:07:43 +0800
Subject: [PATCH v2 1/1] ARM: imx: clk-pllv3: change wait method for PLL
 lock
In-Reply-To: <20130607084937.GH12361@pengutronix.de>
References: <1370593146-14025-1-git-send-email-peter.chen@freescale.com>
 <20130607082457.GF12361@pengutronix.de>
 <20130607083134.GE21641@nchen-desktop>
 <20130607083528.GG12361@pengutronix.de>
 <20130607084354.GF21641@nchen-desktop>
 <20130607084937.GH12361@pengutronix.de>
Message-ID: <20130607110741.GB20756@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 10:49:38AM +0200, Uwe Kleine-K?nig wrote:
> > I will try your fix, but still it just reduces the possibilities.
> > The problem is not the preemption takes too long, it is the jiffies
> > updates more than one tick at one short preemption.
> If that is really the problem that many more instances that use the same
> incarnation need the same fix. I would be surprised if that was the
> case.

+1

We have plenty of timeout code written like that in the kernel.

Shawn
