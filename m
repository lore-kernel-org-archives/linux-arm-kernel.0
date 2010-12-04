From: tony@atomide.com (Tony Lindgren)
Date: Sat, 04 Dec 2010 13:29:42 -0800
Subject: [PATCH 0/5] Few misc patches for v2.6.38 merge window
Message-ID: <20101204212904.25978.22090.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some misc patches for review.

Regards,

Tony

---

Evgeny Kuznetsov (1):
      omap: Ptr "isr_reg" tracked as NULL was dereferenced

Jarkko Nikula (1):
      omap: McBSP: Fix potential memory leak in omap_mcbsp_remove

Shubhrajyoti D (1):
      omap: McBSP: Make the free variable update more readable

Tony Lindgren (2):
      Fix undefined reference to omap2_i2c_mux_pins
      omap: Don't select mux by default for each board


 arch/arm/mach-omap2/Kconfig |    4 ----
 arch/arm/plat-omap/gpio.c   |    5 +++++
 arch/arm/plat-omap/i2c.c    |    7 +++++++
 arch/arm/plat-omap/mcbsp.c  |   16 +++++-----------
 4 files changed, 17 insertions(+), 15 deletions(-)

-- 
Signature
