From: horms@verge.net.au (Simon Horman)
Date: Thu, 1 Aug 2013 16:28:28 +0900
Subject: [PATCH/RESEND] clocksource: em_sti: Convert to devm_* managed
 helpers
In-Reply-To: <51F8D467.1030400@linaro.org>
References: <1375194277-2850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <51F8D467.1030400@linaro.org>
Message-ID: <20130801072828.GB26015@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 11:09:59AM +0200, Daniel Lezcano wrote:
> On 07/30/2013 04:24 PM, Laurent Pinchart wrote:
> > Replace kzalloc, clk_get, ioremap and request_irq by their managed
> > counterparts to simplify error paths.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> 
> Sounds good.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks, I have queued this up for v3.12 in the clocksource branch
of my renesas tree on kernel.org.
