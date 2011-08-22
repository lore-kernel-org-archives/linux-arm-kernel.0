From: jason.hui@linaro.org (Jason Liu)
Date: Mon, 22 Aug 2011 19:53:23 +0800
Subject: [PATCH 0/2] Consolidate and clean up the arch/arm/mach-mx5/mm-*.c
Message-ID: <1314014005-9923-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two patches work for consolidate and clean up the arch/arm/mach-mx5/mm-*.c

Jason Liu (2):
  ARM: i.MX5/mm: Consolidate arch/arm/mach-mx5/mm-*.c
  ARM: i.MX5/mm: use static mapping for TZIC

 arch/arm/mach-mx5/Makefile            |    1 -
 arch/arm/mach-mx5/mm-mx50.c           |   72 ---------------------------------
 arch/arm/mach-mx5/mm.c                |   61 +++++++++++++++++++++-------
 arch/arm/plat-mxc/include/mach/mx51.h |    1 +
 arch/arm/plat-mxc/include/mach/mx53.h |    1 +
 5 files changed, 48 insertions(+), 88 deletions(-)
 delete mode 100644 arch/arm/mach-mx5/mm-mx50.c

-- 
1.7.4.1
