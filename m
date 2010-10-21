From: napohybelskurwysynom2010@gmail.com (Zimny Lech)
Date: Thu, 21 Oct 2010 02:23:11 +0200
Subject: [RFC] Removal of dead code from arch/arm/*
Message-ID: <AANLkTim+vj_OAd22TdThuC-HSqUiDjguOHQWjyqFaq6N@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I will begin testing this, I would like to know your opinion about this patches
git pull git://github.com/napohybelskurwysynom2010/Linux-2.6-nps.git rodc1

 arch/arm/kernel/time.c                       |    6 +-
 arch/arm/mach-omap1/board-sx1.c              |   27 -
 arch/arm/mach-omap1/pm.c                     |    7 -
 arch/arm/mach-s3c2410/include/mach/gpio.h    |    4 -
 arch/arm/mach-s3c2443/mach-smdk2443.c        |    8 -
 arch/arm/mach-sa1100/include/mach/SA-1101.h  |  925 --------------------------
 arch/arm/mach-sa1100/include/mach/hardware.h |    4 -
 arch/arm/mach-u300/clock.c                   |   91 ---
 arch/arm/plat-mxc/include/mach/mx51.h        |    4 -
 arch/m32r/kernel/time.c                      |    6 +-
 drivers/acpi/proc.c                          |    2 +-
 11 files changed, 3 insertions(+), 1081 deletions(-)


-- 
Slawa!
N.P.S.

Les fleurs du mal unfold
Comme les fleurs du mal
Dark demons of my soul
Un amour fatal
