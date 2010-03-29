From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 30 Mar 2010 01:35:28 +0200
Subject: [PATCH 0/5] ARM: PrimeCell DMA patches v4
Message-ID: <1269905728-5452-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a fourth iteration of the PrimeCell DMA API on top of the
generic DMA devices (sibling to the DMA engine). It's based on
the suggestion from Russell to try and define a specific extension
subset for DMA devices.

Since last iteration the changes are:

- Some necessary extensions to the DMA engine were folded into
  the generic DMA engine framework and are now pending in Dan's
  -next tree.

- I have now also implemented support for the PL022 PrimeCell.

PL011, PL022 and PL180 drivers were tested on the U300 with the
COH 901 318 DMA device.

The PL011 driver was also tested on the U8500 with the pending
DMA40 DMA device.

We're running huge and high-speed transfers on all peripherals.
It works.

Patches will be added to the patch tracker soonish, but if this
is eventually OK:ed by Russell I guess it will have to go in
through Dan's DMA tree. Also Grant has to OK it as maintainer of
the SPI subsystem.

Yours,
Linus Walleij
ST-Ericsson SA
