From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 6 Aug 2010 13:50:06 +0200
Subject: [PATCH 0/5] ARM: add PrimeCell generic DMA
Message-ID: <1281095406-15534-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a ninth iteration of this patch set after
the updates to the DMAengine framework allowing for
generic runtime channel control which match the needs
of the PrimeCells.

DMA is working for PL011 serial on the PB11MPCore with
the posted PL08x driver, more testing on this later.
I'll likely post a patch set including the platform
data for PB11MPCore as well.

Yours,
Linus Walleij
