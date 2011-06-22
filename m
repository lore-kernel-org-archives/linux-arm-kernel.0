From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 22 Jun 2011 18:34:10 +0200
Subject: [PATCH 0/2] ARM: S5PV210: GONI board update for CIF camera support
Message-ID: <1308760452-30676-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds platform data definition for NOON010PC30 camera sensor 
for GONI board and renames sclk_cam clocks on S5PV210 platform which is needed
for FIMC media device driver.

The whole patches converting s5p-fimc to media controller API can be found at:

http://git.infradead.org/users/kmpark/linux-2.6-samsung
branch: s5p-fimc-next

Sylwester Nawrocki (2):
  ARM: S5PV210: Rename sclk_cam clocks for FIMC media driver
  ARM: S5PV210: Add support for NOON010PC30 sensor on GONI board

 arch/arm/mach-s5pv210/Kconfig     |    1 +
 arch/arm/mach-s5pv210/clock.c     |    6 +---
 arch/arm/mach-s5pv210/mach-goni.c |   52 +++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 4 deletions(-)

Created against for-next branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 

Regards,
--
Sylwester Nawrocki
Samsung Poland R&D Center
