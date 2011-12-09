From: khilman@ti.com (Kevin Hilman)
Date: Fri, 09 Dec 2011 09:47:04 -0800
Subject: [GIT PULL] OMAP: minor PM cleanups for v3.3
Message-ID: <87pqfxhc2v.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following minor PM cleanups for v3.3.

Thanks,

Kevin


The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.3/cleanup/pm

Abhilash K V (1):
      ARM: OMAP2+: voltage: add check for missing PMIC info in VP init

Kevin Hilman (2):
      ARM: OMAP2+: PM: only register TWL with voltage layer when device is present
      ARM: OMAP: voltage: cleanup VC/VP error messages

Ohad Ben-Cohen (1):
      ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}

 arch/arm/mach-omap2/pm.c                      |    6 ++----
 arch/arm/mach-omap2/twl-common.c              |   11 +++++++++++
 arch/arm/mach-omap2/twl-common.h              |    3 +++
 arch/arm/mach-omap2/vc.c                      |    5 ++---
 arch/arm/mach-omap2/vp.c                      |    6 ++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    7 +++++++
 arch/arm/plat-omap/omap_device.c              |   13 +++----------
 7 files changed, 34 insertions(+), 17 deletions(-)
