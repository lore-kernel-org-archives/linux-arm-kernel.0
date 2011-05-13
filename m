From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 May 2011 16:51:17 +0200
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <0D753D10438DA54287A00B027084269764D26C443E@AUSP01VMBX24.collaborationhost.net>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<0D753D10438DA54287A00B027084269764D2650215@AUSP01VMBX24.collaborationhost.net>
	<BANLkTikc7B5J0Z_aiS5kXCxMSxcFrfSRxw@mail.gmail.com>
	<0D753D10438DA54287A00B027084269764D26C443E@AUSP01VMBX24.collaborationhost.net>
Message-ID: <BANLkTimSCK1Mc4L7OS=dkijuyNb1uFTtew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/28 H Hartley Sweeten <hartleys@visionengravers.com>:
> On Thursday, April 28, 2011 12:08 AM, Linus Walleij wrote:
>> 2011/4/27 H Hartley Sweeten <hartleys@visionengravers.com>:
>>> The Makefile should probably be reordered, either alphabetically
>>> or grouped by type (arch/mmio/i2c/spi/pci/etc) and then
>>> alphabetically in order to reduce merge conflicts.
>>
>> Yes, but if I do that in my patchset I will screw up Grants GPIO tree
>> completely, so I prefer that Grant do this. And maybe after pulling
>> in my GPIO consolidation tree to his in that case, so we don't get
>> undesired collisions. So leaving this for the GPIO maintainer.
>
> This comment was intended for the GPIO maintainer. ?Sorry for any
> confusion.

Nop problem, I actually made a fix for it that I think Grant can take in
for 2.6.40.

Yours,
Linus Walleij
