From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 Jul 2015 21:06:07 +0800
Subject: [GIT PULL] CSR prima2_defconfig fixes for 4.2
Message-ID: <CAGsJ_4xHZsM46zPzZwq-1na5ScxV8bBe+yY_aQY1Hd6re6Dv_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/prima2-defconfig-for-4.2

for you to fetch changes up to 764c222555fe80cbc8fcbed985863e9b07858d51:

  ARM: prima2_defconfig: enable build for hwspinlock (2015-07-28 04:41:20 +0800)

----------------------------------------------------------------
enable SiRFSoC device drivers in CSR prima2_defconfig

make savedefconfig at first, then enable
1. sdhci driver
2. onkey
3. rtc
4. hwspinlock
for prima2_defconfig

----------------------------------------------------------------
Barry Song (5):
      ARM: prima2_defconfig: fix the outdated defconfig
      ARM: prima2_defconfig: enable build for SiRFSoC SDHC host
      ARM: prima2_defconfig: enable build for misc input
      ARM: prima2_defconfig: enable build for RTC
      ARM: prima2_defconfig: enable build for hwspinlock

 arch/arm/configs/prima2_defconfig |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-barry
