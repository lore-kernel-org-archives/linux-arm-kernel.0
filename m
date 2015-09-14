From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Sep 2015 08:42:38 -0500
Subject: [PATCH 0/3] arm: am4: initialiaze twd local timer
Message-ID: <1442238160-5674-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following patches are a rebase of the old series [1] to make use
of TWD/Global timers with AM437x devices.

Note that this depends on another patch which used to be part of this
series, but now it was sent separately [2].

[1] http://marc.info/?l=linux-omap&m=143940944508625&w=2
[2] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8434/1

Felipe Balbi (2):
  arm: omap2: Kconfig: select TWD and global timer on AM43xx devices
  arm: omap2: board-generic: use omap4_local_timer_init for AM437x

 arch/arm/kernel/smp_twd.c           | 4 ----
 arch/arm/mach-omap2/Kconfig         | 3 +++
 arch/arm/mach-omap2/board-generic.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.5.0
