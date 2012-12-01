From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 1 Dec 2012 16:07:59 +0100
Subject: at91-3.8-pinctrl+mmc+spi branch build failure
Message-ID: <CAGhQ9VzHM6iyt-VBsYKkuReLA+Z+bxRiO1S1bVXitUakePeXUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean-Christophe,

I noticed you created a branch with RM9200 DT support on
github.com/at91linux/linux-at91.git.

But when I tried to build it fails with:
CC arch/arm/mach-at91/board-rm9200-dt.o
arch/arm/mach-at91/board-rm9200-dt.c:25:22: fatal error: at91_aic.h: No
such file or directory
compilation terminated.
make[1]: *** [arch/arm/mach-at91/board-rm9200-dt.o] Error 1
make: *** [arch/arm/mach-at91] Error 2

So I think you need to pull in your header cleanup patches.

One other thing; Can I base my work off this branch?
I have DT support for my custom board coming and the RM9200 device tree is
missing bindings for the stuff that's been added lately; SPI, SSC, MMC and
EMAC.


regards
Joachim Eastwood
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121201/a10e4d8a/attachment-0001.html>
