From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 12 Dec 2011 21:46:49 +0000
Subject: [PATCH 0/5] Misc picoxcell features for 3.3
Message-ID: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are a few minor picoxcell features for 3.3 to implement a restart method
for the machine using Russell's new infrastructure and a couple of minor
cleanups.

Jamie Iles (5):
  ARM: picoxcell: remove mach/memory.h
  ARM: picoxcell: don't reserve irq_descs
  ARM: picoxcell: move io mappings to common.c
  MAINTAINERS: add maintainer entry for Picochip picoxcell
  ARM: picoxcell: implement watchdog restart

 MAINTAINERS                                   |    8 ++++
 arch/arm/mach-picoxcell/Makefile              |    1 -
 arch/arm/mach-picoxcell/common.c              |   46 ++++++++++++++++++++++++-
 arch/arm/mach-picoxcell/common.h              |    1 -
 arch/arm/mach-picoxcell/include/mach/irqs.h   |    9 +----
 arch/arm/mach-picoxcell/include/mach/memory.h |    1 -
 arch/arm/mach-picoxcell/io.c                  |   32 -----------------
 7 files changed, 55 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
 delete mode 100644 arch/arm/mach-picoxcell/io.c

-- 
1.7.5.4
