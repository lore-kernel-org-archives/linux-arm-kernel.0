From: olof@lixom.net (Olof Johansson)
Date: Wed, 9 May 2012 09:28:43 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.4
Message-ID: <CAOesGMheimXMjB=-+9WNXc8Wu2nStfF3=6C3tMENTJybhn96ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/fixes-for-linus

for you to fetch changes up to e396dbd4ed2ccfd362261b05027bbdccec192b14:

  Merge tag 'omap-fixes-for-v3.4-rc6-take-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
fixes (2012-05-09 09:03:34 -0700)

----------------------------------------------------------------

ARM: SoC fixes for 3.4-rc

Things have slowed down a lot for us, but we have five more fixes for
omap and kirkwood below. Three are for boards setup issues, two are
SoC-level fixes.

----------------------------------------------------------------
Archit Taneja (1):
      ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields"

Ben Hutchings (1):
      ARM: orion5x: Fix GPIO enable bits for MPP9

Enrico Butera (1):
      ARM: OMAP: igep0020: fix smsc911x dummy regulator id

Ian Campbell (1):
      ARM: kirkwood: add missing kexec.h include

Janusz Krzysztofik (1):
      ARM: OMAP1: Amstrad Delta: Fix wrong IRQ base in FIQ handler

Olof Johansson (2):
      Merge branch 'kirkwood_fixes_for_v3.4' of
git://git.infradead.org/users/jcooper/linux-kirkwood into fixes
      Merge tag 'omap-fixes-for-v3.4-rc6-take-2' of
git://git.kernel.org/.../tmlind/linux-omap into fixes

 arch/arm/mach-kirkwood/board-dt.c                            | 1 +
 arch/arm/mach-omap1/ams-delta-fiq.c                          | 2 +-
 arch/arm/mach-omap2/board-igep0020.c                         | 2 +-
 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h | 8 ++++----
 arch/arm/mach-orion5x/mpp.h                                  | 4 ++--
 5 files changed, 9 insertions(+), 8 deletions(-)
