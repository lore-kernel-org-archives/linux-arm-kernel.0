From: rabin@rab.in (Rabin Vincent)
Date: Mon, 4 Apr 2016 12:32:57 +0200
Subject: [PATCH] clockevents/drivers/arm_global_timer: Fix erratum 740657
 workaround
In-Reply-To: <56FA8F4F.1000900@linaro.org>
References: <1459238917-2240-1-git-send-email-rabin.vincent@axis.com>
 <56FA8F4F.1000900@linaro.org>
Message-ID: <20160404103257.GA27198@lnxrabinv.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 04:21:03PM +0200, Daniel Lezcano wrote:
> On 03/29/2016 10:08 AM, Rabin Vincent wrote:
> >  <idle>-0 [001] d.h2 99.850527: irq_handler_entry: irq=16 name=gt
> >  <idle>-0 [001] d.h2 99.850538: irq_handler_exit: irq=16 ret=handled
> >  <idle>-0 [001] d.H2 99.850540: irq_handler_entry: irq=16 name=gt
> >  <idle>-0 [001] d.H2 99.850542: irq_handler_exit: irq=16 ret=unhandled
> >  <idle>-0 [001] d.h2 99.987832: irq_handler_entry: irq=16 name=gt
> >  <idle>-0 [001] dnh2 99.987845: irq_handler_exit: irq=16 ret=handled
> >  <idle>-0 [001] dnh2 99.987848: irq_handler_entry: irq=16 name=gt
> >  <idle>-0 [001] dnh2 99.987850: irq_handler_exit: irq=16 ret=unhandled
> 
> what platform are you using to test that ?

ARTPEC-6.
