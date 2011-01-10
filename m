From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 10 Jan 2011 19:00:00 +0100
Subject: [GIT PULL] ux500-core leftovers
Message-ID: <AANLkTimHzjRLxGLabXgh7bvoD+f9jOC8CRS0YFeKzMDz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus, could you please pull:

      git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
for-torvalds

This is based on commit 0c21e3a and contains
the following patches that couldn't be merged through
Russell's ARM tree due to cross-branch dependencies
now sorted out in your tree:

Rabin Vincent (5):
      ux500: remove build-time changing macros
      ux500: rename MOP board Kconfig
      ux500: dynamic SOC detection
      ux500: modem_irq is only for 5500
      ux500: allow 5500 and 8500 to be built together

Yours,
Linus Walleij
