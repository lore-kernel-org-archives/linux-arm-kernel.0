From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 31 May 2017 17:59:57 +0300
Subject: [PATCHv4 0/6] ARM: OMAP2+: preparation for clk/clkctrl support
Message-ID: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is evolution of the v3b of the same series:
https://www.spinics.net/lists/arm-kernel/msg584344.html

Changes compared to v3b:

- Added patch #3 which stores the physical address for PRCM instances
  in addition to the virtual addresses
- Fixed patch #5 to use physical base address for xlate instead of
  the OMAP2_L4_IO_ADDRESS hack
- Dropped unnecessary device node passing from patch #6 which makes
  the code slightly more readable also

Integrated test branch here:
Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.12-rc1-clkctrl-integ-v4

-Tero
