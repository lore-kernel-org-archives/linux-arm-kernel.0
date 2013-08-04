From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Sun, 4 Aug 2013 14:25:27 +0200
Subject: [ARM ATTEND] Interested in R/M-class (!MMU), automated testing
In-Reply-To: <51FBF93D.8040707@arm.com>
References: <51FBF93D.8040707@arm.com>
Message-ID: <20130804122527.GV3880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Fri, Aug 02, 2013 at 07:23:57PM +0100, Jonathan Austin wrote:
> - How we can get more eyes on the !MMU code in the kernel - is it
>   because nobody's got R/M hardware? R/M isn?t interesting to people so
>   far? etc

Since my team (mainly Uwe) has worked on the Cortex-M port, I still
havn't seen many real usecases where Cortex-M and Linux made sense. The
original idea was to use EFM32 because it was a) very low power and b)
got a high quality network stack with Linux.

Unfortunately, most requests we got since then were from people who
expected an extraordinairy "cheap" system, but that doesn't work if you
look at the BOM for a complete system, both in terms of money and power
consumption.

That may be a reason for having not that many hardware out there.

There are some FPGAs with Cortex-M out there, which might be an
interesting target.

> - Ways to do more automated testing of ARM kernels, including hearing
>   from other people what they use to build/boot/test/benchmark their
>   code (perhaps even get a discussion going about using the diverse
>   range of hardware people have around put to use as test-machines).

That's pretty interesting; we have a test farm at PTX, but it mainly
does nightly build + boot tests on mainline, for systems we care of.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
