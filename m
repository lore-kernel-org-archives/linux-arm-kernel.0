From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 29 Mar 2016 10:38:22 +0900
Subject: [PATCH 0/2] ARM: uniphier: updates for Linux 4.7-rc1
Message-ID: <1459215505-18035-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Two patches for UniPhier SMP updates.

Please get them into ASOC.



Masahiro Yamada (2):
  ARM: uniphier: fix up cache ops broadcast of ACTLR
  ARM: uniphier: initialize outer cache for secondary CPUs

 arch/arm/include/asm/hardware/cache-uniphier.h |  5 +++++
 arch/arm/mach-uniphier/platsmp.c               | 21 +++++++++++++++++++++
 arch/arm/mm/cache-uniphier.c                   | 19 ++++++++++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

-- 
1.9.1
