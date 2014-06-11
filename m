From: nick.dyer@itdev.co.uk (Nick Dyer)
Date: Wed, 11 Jun 2014 13:06:51 +0100
Subject: [RFC PATCH] input, touch, atmel_mxt_ts: use atmel driver
In-Reply-To: <1402468526-9165-1-git-send-email-hs@denx.de>
References: <1402468526-9165-1-git-send-email-hs@denx.de>
Message-ID: <5398465B.7060101@itdev.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko Schocher wrote:
> try to bring the driver from
> https://github.com/ndyer/linux for-next
> 
> to mainline. Post this as a RFC, to see if this is possible...
> 
> based on:
> commit dda0a5570574cfe467c1c794cf7a17e1d742ec02 ("Input:
> atmel_mxt_ts - implement improved debug message interface")
> 
> from Nick Dyer <nick.dyer@itdev.co.uk>
> 
> added:
> - remove some (not all) checkpatch warnings
> - Add support for voltage regulator
> - Add support for Device Tree support

My thinking has been that the maintainers will more likely accept a series
of small patches than to make such a huge change to the entire driver, my
for-next tree is where I'm working on this, and I plan to post another set
of 15 patches soon, when I've fixed up some issues to do with probe/remove
cycles.

You should note that my for-next branch has moved on slightly since you
have taken this, because I have implemented device tree support and changed
the config download to use the request_firmware_async() function.

Your device tree stuff for mach-goni.c looks really useful, however - if
you can send me a patch for that against my current for-next branch I can
include it with my version of the device tree support.

all the best

Nick
