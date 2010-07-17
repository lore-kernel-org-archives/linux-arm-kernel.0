From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 18 Jul 2010 00:10:27 +0200
Subject: [PATCH 1/2] MISC: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <4C41A413.50205@promwad.com>
References: <1279365780-18462-1-git-send-email-triad@df.lth.se>
	<4C41A413.50205@promwad.com>
Message-ID: <AANLkTimJU5-vDLi3ssctgOWl3T6LDgdMlmvkRrm4vh23@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/17 Ivan Kuten <ivan.kuten@promwad.com>:

> ?Hello Linus,
> Any chance to sync your efforts with lcd-linux project
> (http://lcd-linux.sourceforge.net/) ?

If the LCD-linux people make an attempt to go into the mainline, I
promise I will immediately migrate my driver out of drivers/misc
and out into drivers/lcd or wherever it'll end up.

I cannot drive it however, they seem to be using special
hardware I haven't got access to.

> They seems to have a support for HD44780 LCD controller.

That's not the tricky bit of this driver actually, though there
is sure code to be de-duplicated if LCD-linux is merged,
ARM have some special-purpose silicon to handle the
HD44780 e.g. to fire interrupts when the display responds
etc.

Yours,
Linus Walleij
