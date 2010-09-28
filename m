From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 28 Sep 2010 16:33:54 +0200
Subject: [PATCH 0/7] PrimeCell Generic DMA v12 
Message-ID: <1285684441-21700-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Still haven't acquired a PB926 Versatile board so rebasing
the patches in the hopes that one will appear.

- Fixed the #ifdefs to be switching on CONFIG_DMA_ENGINE
  rather than CONFIG_DMADEVICES, we're actually dependent
  on the engine leading to the compilation problem Grant
  saw under certain conditions.
  (This is how it was once in the past before I tried to
   be clever)
- Rebased the PL180 extension on top of the out-of-order
  IRQ arrival patch submitted earlier (so that one is
  required).

I can post a complete set of patches that add the PL08x
driver, the MMCI updates pending in Russells tracker
and this stack in case there is interest, but this is
trying to keep it as small as possible.

Yours,
Linus Walleij
