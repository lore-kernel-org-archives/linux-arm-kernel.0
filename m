From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Jan 2013 09:49:30 +0900
Subject: [GIT PULL v2] Renesas ARM-based SoC defconfig for v3.9
Message-ID: <1358210975-26970-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following defconfig enhancements for 3.9.

----------------------------------------------------------------
The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git 

for you to fetch changes up to 8098df15c26b2bf16924df5a134d1a649692ab62:

  ARM: mach-shmobile: kzm9d: update defconfig (2013-01-15 08:57:09 +0900)

----------------------------------------------------------------
Simon Horman (5):
      ARM: mach-shmobile: mackerel: update defconfig
      ARM: mach-shmobile: fix memory size for kota2_defconfig
      ARM: mach-shmobile: kzm9g: defconfig update
      ARM: mach-shmobile: armadillo: update defconfig
      ARM: mach-shmobile: kzm9d: update defconfig

 arch/arm/boot/dts/emev2-kzm9d.dts             |    2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    4 ++++
 arch/arm/boot/dts/sh7372-mackerel.dts         |    4 ++++
 arch/arm/boot/dts/sh73a0-kzm9g.dts            |    4 ++++
 arch/arm/configs/armadillo800eva_defconfig    |    5 ++---
 arch/arm/configs/kota2_defconfig              |    2 +-
 arch/arm/configs/kzm9d_defconfig              |    4 +---
 arch/arm/configs/kzm9g_defconfig              |    4 +++-
 arch/arm/configs/mackerel_defconfig           |    2 +-
 9 files changed, 21 insertions(+), 10 deletions(-)
