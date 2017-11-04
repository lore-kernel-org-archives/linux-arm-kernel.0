From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat,  4 Nov 2017 19:09:36 +0800
Subject: [GIT PULL] arm: actions: soc for v4.15
Message-ID: <20171104110938.9019-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here's a (late) soc pull for Actions Semi.
These are pretty much non-functional cleanups.

Regards,
Andreas

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-soc-for-4.15

for you to fetch changes up to 6c2eb3e76fb84e2eb46d484f71fab469c0d9532c:

  ARM: owl: smp: Drop owl_secondary_boot() (2017-09-20 16:49:27 +0200)

----------------------------------------------------------------
Actions Semi Arm SoC for v4.15

This cleans up the S500 SMP code.

----------------------------------------------------------------
Andreas F?rber (2):
      ARM: owl: smp: Use __pa_symbol()
      ARM: owl: smp: Drop owl_secondary_boot()

 arch/arm/mach-actions/Makefile  |  4 +---
 arch/arm/mach-actions/headsmp.S | 52 -----------------------------------------
 arch/arm/mach-actions/platsmp.c |  2 +-
 3 files changed, 2 insertions(+), 56 deletions(-)
 delete mode 100644 arch/arm/mach-actions/headsmp.S
