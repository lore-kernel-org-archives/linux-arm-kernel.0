From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 15 May 2010 02:36:36 +0200
Subject: Anyone knows abot the DMA status on the PB1176JZF-S baseboard?
Message-ID: <AANLkTim4Y5vkPYUWSNigIL72-f9jfTLq-nEKD_apaD0p@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got hold of a baseboard for ARM RealView Versatile 1176JZF-S.

However in the manual that comes with the board the DMA PL081
controller is listed but in recent manuals it has been removed.
It's device entry was commented out in
arch/arm/mach-realview/realview_pb1176.c
when the support was submitted.

When I test it, the hardware is there and responding at
the listed address. However it doesn't seem to work so well,
all kind of odd behaviour... Like loosing bits on the bus.

Is the PL081 instance in the PB1176 known to be broken and is that
the reason for it being removed from the manual?

Yours,
Linus Walleij
