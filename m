From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Dec 2011 13:58:05 +0100
Subject: Massive log spam loading modules on ARM after 3.2-rc5 (regression)
In-Reply-To: <20111215094733.GI14542@n2100.arm.linux.org.uk>
References: <20111214215133.GA7780@elliptictech.com>
 <20111215092633.GD24496@pengutronix.de>
 <20111215094733.GI14542@n2100.arm.linux.org.uk>
Message-ID: <20111215125805.GF24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, Dec 15, 2011 at 09:47:33AM +0000, Russell King - ARM Linux wrote:
> > Can you provide me your .config please? I cannot reproduce your problems
> > with modprobe on an i.MX28 based tx28 machine.
> > 
> > Russell, maybe this makes you a bit less annoyed?
> 
> Why should it?
If you consider my statement to relate to your "And wtf wasn't it
tested with modules?" it might convince you that my testing included
modules, too.

Assuming that the fix I send to Nick solves his problem, this problem
only affects the last function before and first function after the .idx
section and that only in approx. one out of two cases. (And additionally
for me the unwinder isn't used on modprobe.) So I still think my testing
was OK.

> 1. Your change is totally unaffected by whether XIP is being used or not,
>    so this is irrelevant.
> 2. You plainly said in your previous message (and I quote) "IMHO this is
>    merge window material even though it has "fix" in the title.".
> 
> The fact of the matter is that you _never_ said that you didn't consider
> your patch -rc material - and that alone is what I'm complaining at you
> about.  It is _YOUR_ responsibility to indicate where a patch should be
> applied.  You failed to do that.
I don't think that it makes sense to continue arguing here. If you have
to name someone to Linus who is responsible for this regression, feel
free to say my name. (Ah, I see he's on Cc: ...)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
