From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 30 Jun 2014 16:07:40 +0200
Subject: [GIT PULL 2/2] ARM: berlin: SoC changes for v3.17
In-Reply-To: <1404137260-5876-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1404137260-5876-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1404137260-5876-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

This is round 1 of SoC related changes for Berlin SoCs.

There is only one patch from Antoine providing SMP on BG2 and BG2Q.

Please pull.

Thanks,
  Sebastian

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-soc-3.17-1

for you to fetch changes up to 7b7dfdd2b9927c1861bb6d03ca35261f1739aceb:

  ARM: berlin: add SMP support (2014-06-16 13:16:44 +0200)

----------------------------------------------------------------
Berlin SoC changes for v3.17

- SMP support for BG2 and BG2Q

----------------------------------------------------------------
Antoine T?nart (1):
      ARM: berlin: add SMP support

 arch/arm/mach-berlin/Kconfig   |  3 ++
 arch/arm/mach-berlin/Makefile  |  3 +-
 arch/arm/mach-berlin/headsmp.S | 30 +++++++++++++
 arch/arm/mach-berlin/platsmp.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-berlin/headsmp.S
 create mode 100644 arch/arm/mach-berlin/platsmp.c
