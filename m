From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 17 Dec 2011 13:42:32 +0000
Subject: [PATCHv2 0/5] Misc picoxcell updates for 3.3
Message-ID: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's v2 of a small series of feature updates for picoxcell in 3.3.

Jamie

Jamie Iles (5):
  ARM: picoxcell: remove mach/memory.h
  ARM: picoxcell: don't reserve irq_descs
  ARM: picoxcell: move io mappings to common.c
  MAINTAINERS: add maintainer entry for Picochip picoxcell
  ARM: picoxcell: implement watchdog restart

 MAINTAINERS                                   |    9 +++++
 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-picoxcell/Makefile              |    1 -
 arch/arm/mach-picoxcell/common.c              |   47 ++++++++++++++++++++++++-
 arch/arm/mach-picoxcell/common.h              |    1 -
 arch/arm/mach-picoxcell/include/mach/irqs.h   |    9 +----
 arch/arm/mach-picoxcell/include/mach/memory.h |    1 -
 arch/arm/mach-picoxcell/io.c                  |   32 -----------------
 8 files changed, 58 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
 delete mode 100644 arch/arm/mach-picoxcell/io.c

-- 
1.7.5.4
