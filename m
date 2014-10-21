From: varkabhadram@gmail.com (Varka Bhadram)
Date: Tue, 21 Oct 2014 16:03:30 +0530
Subject: [PATCH arm-soc 0/2] remove duplicate check on resource
Message-ID: <1413887612-25012-1-git-send-email-varkab@cdac.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are based on arm-soc/master branch

Varka Bhadram (2):
  mach-omap2: gpmc: remove duplicate check on resource
  plat-omap: dmtimer: remove duplicate check on resource

 arch/arm/mach-omap2/gpmc.c   |    9 +++------
 arch/arm/plat-omap/dmtimer.c |    4 ----
 2 files changed, 3 insertions(+), 10 deletions(-)

-- 
1.7.9.5
