From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Apr 2013 14:57:11 +0530
Subject: [PATCH 0/4] ARM: davinci: sparse warning fixes
Message-ID: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes some sparse errors/warnings
occurring in arch/arm/mach-davinci/*

Tested on DA850 EVM (boot and suspend-to-RAM test).

Sekhar Nori (4):
  ARM: davinci: da850 evm: fix const qualifier placement
  ARM: davinci: da8xx dt: make file local symbols static
  ARM: davinci: sram.c: fix incorrect type in assignment
  ARM: davinci: ensure global variables are declared

 arch/arm/mach-davinci/board-da850-evm.c |    4 ++--
 arch/arm/mach-davinci/da8xx-dt.c        |    4 ++--
 arch/arm/mach-davinci/pm.c              |    1 +
 arch/arm/mach-davinci/sram.c            |    4 ++--
 arch/arm/mach-davinci/usb.c             |    1 +
 5 files changed, 8 insertions(+), 6 deletions(-)

-- 
1.7.10.1
