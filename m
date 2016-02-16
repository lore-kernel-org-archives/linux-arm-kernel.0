From: rabin.vincent@axis.com (Rabin Vincent)
Date: Tue, 16 Feb 2016 12:28:41 +0100
Subject: [PATCH] clocksource: arm_global_timer: register delay timer
In-Reply-To: <55D62468.4050404@linaro.org>
References: <1439991818-31989-1-git-send-email-rabin.vincent@axis.com>
 <55D62468.4050404@linaro.org>
Message-ID: <20160216112841.GA26773@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 09:03:04PM +0200, Daniel Lezcano wrote:
> On 08/19/2015 03:43 PM, Rabin Vincent wrote:
> > Provide a delay timer using the lower 32-bits of the global timer so
> > that we can use that instead of having to calibrating delays.
> >
> > Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
> 
> Applied to my tree for 4.4

This seems to have got lost?  I don't see it in v4.4 or current mainline
(v4.5-rc4).  It still applies cleanly.

Thanks.
