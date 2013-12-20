From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 Dec 2013 14:20:25 +0100
Subject: [GIT PULL] get rid of <mach/timex.h>
In-Reply-To: <20131219221758.GS14866@pengutronix.de>
References: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
 <87bo0clved.fsf@linaro.org> <20131219221758.GS14866@pengutronix.de>
Message-ID: <20131220132024.GO17135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:17:58PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> darn, I missed these because my compile testing was done without
> removing the dummy value of CLOCK_TICK_RATE in <asm/timex.h> and I then
> relied on the 0day bot who obviously didn't build the critical configs.
> :-\
> 
> The problems are fixed by:
>  - "ARM: rpc: stop using <mach/timex.h>" which I just sent in this
>    thread.
>  - "ARM: u300: fix timekeeping when periodic mode is used", a patch I
>    sent earlier and that Linus W. wanted to merge. It's not yet in
>    -next. Maybe I can take it instead into this series? Linus?
>  - The patch pasted below distributed on the respective commits.
>    Apart from the netx patch these don't have any affected acks. Sascha,
>    I assume I can keep your Ack?

Yes, go ahead.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
