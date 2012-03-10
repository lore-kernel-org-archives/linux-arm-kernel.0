From: alan@signal11.us (Alan Ott)
Date: Sat, 10 Mar 2012 13:44:09 -0500
Subject: [PATCH 0/2] ARM: AT91: cleanup patches from Arnd Bergmann
Message-ID: <1331405049-3186-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm helping Arnd Bergmann get some of his cleanup patches upstream. This
set covers the AT91 and is based off of torvalds/linux.git.

Thanks,

Alan.

Arnd Bergmann (2):
  ARM: at91: only RM9200 has ISA-style PIO
  ARM: at91: Use proper __iomem annotations

 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-at91/at91rm9200.c            |    2 +-
 arch/arm/mach-at91/include/mach/hardware.h |    4 ++++
 arch/arm/mach-at91/setup.c                 |    4 ++--
 4 files changed, 8 insertions(+), 3 deletions(-)
