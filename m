From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 11:11:08 +0100
Subject: STOP THE MADNESS
In-Reply-To: <20131129020149.GU16735@n2100.arm.linux.org.uk>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>
 <20131129020149.GU16735@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdao9ct-fKaUnrdX=dmN+fyuVgcbWQvc_sZTwp8wGdJ0+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 3:01 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> So... EBSA285... where would people like me to start with that.
> VGA... broken.  LEDs... broken.  Several other issues as well (eg,
> my tightening of the vectors page seems to have broken all low-vectors
> platforms.)

It seems that the majority of the world's Versatile "users" are
running the QEMU model of that machine and not really
testing on anything else. Unsurprisingly the QEMU Versatile
is overly forgiving when mistreating virtual hardware. Some
stuff like LEDs I guess are just dummies.

I'm having a look at some stuff on this Versatile AB I have here
(turned out it was not a PB, but hopefully this will suffice).
I'll try to attend to the stuff that I understand atleast.

Yours,
Linus Walleij
