From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 12 May 2014 18:26:26 +0200
Subject: [PATCH v2 0/4] ARM: at91: move sam9n12 SoC and boards to the CCF
Message-ID: <1399911990-5086-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series moves the at91sam9n12 SoC and the at91sam9n12-ek board to
the Common Clock Framework.

It depends on these series: [1], [2].

Best Regards,

Boris

[1] http://lkml.iu.edu/hypermail/linux/kernel/1403.3/00074.html
[2] http://comments.gmane.org/gmane.linux.kernel.samsung-soc/27632

Boris BREZILLON (4):
  ARM: at91: prepare common clk transition for sam9n12 SoC
  ARM: at91/dt: define sam9n12 clocks
  ARM: at91/dt: define sam9n12ek crystal frequencies
  ARM: at91: move sam9n12 SoC to the CCF

 arch/arm/boot/dts/at91sam9n12.dtsi  | 348 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9n12ek.dts |   8 +
 arch/arm/mach-at91/Kconfig          |   1 -
 arch/arm/mach-at91/at91sam9n12.c    |   6 +-
 4 files changed, 359 insertions(+), 4 deletions(-)

-- 
1.8.3.2
