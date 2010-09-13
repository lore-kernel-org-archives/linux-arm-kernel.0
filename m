From: vince@kyllikki.org (Vincent Sanders)
Date: Mon, 13 Sep 2010 17:49:05 +0100
Subject: Common warnings
Message-ID: <20100913164905.GC12197@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number or warnings common to numerous builds has been rising
recently. Perhaps some maintainers would care to address these issues
before we become the most noisy kernel build target (currently MIPS).

The worst we have are:

81/156 builds have:

  arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"

  Apariently becuase EABI and unwind tables are not compatible.


39/156 builds have:

  arch/arm/plat-omap/include/plat/usb.h:109: warning: return type defaults to 'int'

24/156 builds have:

  arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead


There are also a large number of slightly different warnings coming
from the numerous different AT91 configurations. Can the maintainers
perhaps look at consolidating some of the AT91 configurations!




-- 
Regards Vincent
http://www.kyllikki.org/
