From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 23 Jun 2017 19:25:50 +0200
Subject: [GIT PULL] ARM: actions: arm for v4.13
Message-ID: <20170623172556.12618-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here's the initial arm pull for Actions Semi.

Regards,
Andreas

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-soc-for-4.13

for you to fetch changes up to ba2694def2361d9b8d944f6df4aa077ad7290746:

  MAINTAINERS: Update Actions Semi section with SPS (2017-06-21 18:17:44 +0200)

----------------------------------------------------------------
Actions Semi ARM SoC for v4.13

This adds a Kconfig symbol and mach-actions with board and SMP code,
plus a MAINTAINERS entry.

----------------------------------------------------------------
Andreas F?rber (4):
      ARM: Prepare Actions Semi S500
      MAINTAINERS: Add Actions Semi Owl section
      ARM: owl: Implement CPU enable-method for S500
      MAINTAINERS: Update Actions Semi section with SPS

 MAINTAINERS                     |  16 ++++
 arch/arm/Kconfig                |   2 +
 arch/arm/Makefile               |   1 +
 arch/arm/mach-actions/Kconfig   |  15 ++++
 arch/arm/mach-actions/Makefile  |   4 +
 arch/arm/mach-actions/headsmp.S |  68 ++++++++++++++++
 arch/arm/mach-actions/owl.c     |  28 +++++++
 arch/arm/mach-actions/platsmp.c | 166 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 300 insertions(+)
 create mode 100644 arch/arm/mach-actions/Kconfig
 create mode 100644 arch/arm/mach-actions/Makefile
 create mode 100644 arch/arm/mach-actions/headsmp.S
 create mode 100644 arch/arm/mach-actions/owl.c
 create mode 100644 arch/arm/mach-actions/platsmp.c
