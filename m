From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 15 Oct 2016 22:50:08 +0200
Subject: [PATCH 0/3] ARM-OMAP2+: Fine-tuning for five function implementations
Message-ID: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 15 Oct 2016 22:44:22 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  mux: Replace three seq_printf() calls by seq_puts()
  mux: Use seq_putc() in omap_mux_dbg_signal_show()
  pm-debug: Use seq_putc() in two functions

 arch/arm/mach-omap2/mux.c      | 8 ++++----
 arch/arm/mach-omap2/pm-debug.c | 5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.10.1
