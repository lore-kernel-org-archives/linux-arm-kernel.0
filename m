From: ccross@google.com (Colin Cross)
Date: Thu, 26 Aug 2010 20:40:10 -0700
Subject: [GIT PULL] tegra fixes for 2.6.36
Message-ID: <AANLkTi==Z-SbfSWBhxoZMpKLtCwA9O_oUgh8PWrMNRoG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
Please pull tegra fixes from:

git://android.git.kernel.org/kernel/tegra.git for-linus

Thanks,
Colin

The following changes since commit d4348c678977c7093438bbbf2067c49396ae941b:
  Linus Torvalds (1):
        Merge branch 'perf-fixes-for-linus' of
git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://android.git.kernel.org/kernel/tegra.git for-linus

Olof Johansson (2):
      arm: tegra: fix compilation of board-harmony.c
      arm: tegra: VMALLOC_END should be unsigned long

 arch/arm/mach-tegra/board-harmony.c        |    2 --
 arch/arm/mach-tegra/include/mach/vmalloc.h |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)
