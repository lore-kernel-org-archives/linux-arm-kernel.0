From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 10 Jan 2013 10:23:54 +0900
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.9
Message-ID: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following defconfig enhancements for 3.9.

----------------------------------------------------------------
The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git defconfig

for you to fetch changes up to 34d5821ede67551163eedad3ad35cac2642185cf:

  ARM: mach-shmobile: kzm9g: Enable ARM_APPENDED_DTB in defconfig (2013-01-09 15:08:05 +0900)

----------------------------------------------------------------
Simon Horman (5):
      ARM: mach-shmobile: mackerel: update defconfig
      ARM: shmobile: fix memory size for kota2_defconfig
      ARM: mach-shmobile: kzm9g: use voltage regulators by default
      ARM: mach-shmobile: armadillo: update defconfig
      ARM: mach-shmobile: kzm9g: Enable ARM_APPENDED_DTB in defconfig

 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 arch/arm/configs/kota2_defconfig           |    2 +-
 arch/arm/configs/kzm9g_defconfig           |    3 +++
 arch/arm/configs/mackerel_defconfig        |    3 ++-
 4 files changed, 7 insertions(+), 3 deletions(-)
