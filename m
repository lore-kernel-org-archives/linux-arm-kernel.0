From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 15 May 2012 21:55:00 +0400
Subject: [PATCH 0/2] ARM: clps711x: Last 2 patches
Message-ID: <1337104502-5292-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This final two patch for branch arm-soc clps711x/cleanup.
Removed redundant masking interrupts and adds the ability to
proper operation of the kernel at various clock speeds of the CPU.

Alexander Shiyan (2):
  ARM: clps711x: Cleanup IRQ handling
  ARM: clps711x: Added support for CPU frequencies other than 73 MHz

 arch/arm/mach-clps711x/Kconfig                 |    9 +++++++++
 arch/arm/mach-clps711x/common.c                |   12 ------------
 arch/arm/mach-clps711x/include/mach/hardware.h |    3 +++
 arch/arm/mach-clps711x/include/mach/irqs.h     |    5 +----
 arch/arm/mach-clps711x/include/mach/timex.h    |    4 +++-
 drivers/tty/serial/clps711x.c                  |    4 ++--
 6 files changed, 18 insertions(+), 19 deletions(-)

-- 
1.7.3.4
