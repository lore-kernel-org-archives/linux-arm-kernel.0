From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 16 Sep 2010 00:27:59 +0200
Subject: PrimeCell Generic DMA v11
Message-ID: <1284589686-28652-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is another release of the PrimeCell DMA extensions.

The current batch now includes the platform data for the
RealView and Versatile as well, I cannot test on Versatile
since I don't have this hardware (if you have one to spare,
you know where to find me, the PB926 seems to be the key
machine to regression test this on).

This is based on:

- The stuff pending in Dan Williams DMAengine tree
- Pending patches for Dans tree for Pl08x
- The stuff for MMCI Rabin has in Russells patch tracker
- Some other CPU updates from the patch tracker

It compiles for U300, Ux500, RealView and Versatile. It
is tested on U300, Ux500 and RealView PB11MPCore.

If someone wants to try it out on some real Versatile
hardware, tell me what git tree you would like as baseline
and I can hopefully supply the entire patchset on your
desired base.

Yours,
Linus Walleij
