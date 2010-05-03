From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon,  3 May 2010 02:54:20 +0200
Subject: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
Message-ID: <1272848060-28049-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set intended for Dan Williams tree includes:

- A fixed up COH 901 318 PrimeCell extension (unless applied
  to your tree already)
- Two DMA40 bug fixes.
- The latest iteration of the PrimeCell DMA extensions,
  altered and tested to work as Russell wants them. The PL011
  driver was tested:
  - on Versatile QEMU after I got it working again - OK
  - on U300 with DMA - OK
  - on U300 without DMA - OK
  - on U300 with fault injection, DMA always fail - OK
  - on U300 with fault injection, DMA fails every second time - OK
- Russell is this OK with you now?

Yours,
Linus Walleij
