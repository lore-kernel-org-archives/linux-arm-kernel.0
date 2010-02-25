From: tony@atomide.com (Tony Lindgren)
Date: Thu, 25 Feb 2010 15:02:56 -0800
Subject: [PATCH 0/6] omap i2c init fix and trivial board changes for 2.6.34
Message-ID: <20100225230116.26233.65157.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Getting into fixes mode here. Still found few more trivial board
related patches that should go into this merge window.

Regards,

Tony


---

Ajay Kumar Gupta (2):
      AM35x: Add missing GPIO mux config for EHCI port
      AM35x: Enable OMAP_MUX in defconfig

Jarkko Nikula (1):
      omap: i2c: Fix muxing for command line enabled bus

Sriram (2):
      AM3517 EVM: Enable I2C support
      AM3517EVM : correct typo - tca6416 mispelt as tca6516

manjugk manjugk (1):
      Zoom3: Defconfig update


 arch/arm/configs/am3517_evm_defconfig |   43 +++++++++++++++++++++++++++++++--
 arch/arm/configs/omap_zoom3_defconfig |    6 ++---
 arch/arm/mach-omap1/i2c.c             |    6 +----
 arch/arm/mach-omap2/board-am3517evm.c |   15 +++++++-----
 arch/arm/mach-omap2/i2c.c             |    6 +----
 arch/arm/plat-omap/i2c.c              |   10 ++++++--
 arch/arm/plat-omap/include/plat/i2c.h |    5 ++--
 7 files changed, 65 insertions(+), 26 deletions(-)

-- 
Signature
