From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 30 Jul 2013 12:03:07 +0200
Subject: [PATCH] clocksource: em_sti: Convert to devm_* managed helpers
In-Reply-To: <51F7229D.7090706@linaro.org>
References: <1374848897-18545-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130730020640.GA27724@verge.net.au> <51F7229D.7090706@linaro.org>
Message-ID: <2725526.9tXHptSQgN@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, John,

On Monday 29 July 2013 19:19:09 John Stultz wrote:
> On 07/29/2013 07:06 PM, Simon Horman wrote:
> > [ CC John Stultz, Thomas Gleixner ]
> > 
> > On Fri, Jul 26, 2013 at 04:28:17PM +0200, Laurent Pinchart wrote:
> >> Replace kzalloc, clk_get, ioremap and request_irq by their managed
> >> counterparts to simplify error paths.
> >> 
> >> Signed-off-by: Laurent Pinchart
> >> <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Hi Laurent,
> > 
> > I was recently asked for shmobile clocksource patches to be reviewed
> > by the clocksource maintainers. I believe that means John Stultz
> > and Thomas Gleixner who I have CCed on this email accordingly.
> 
> Daniel Lezcano (cc'ed) is picking up maintainership of
> clocksource/clockevent code in drivers/clocksource, so please cc him in
> the future.

Sure, will do so (I suppose Daniel will show up in MAINTAINERS, otherwise I 
might forget).

-- 
Regards,

Laurent Pinchart
