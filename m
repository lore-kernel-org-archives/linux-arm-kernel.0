From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:08 +0900
Subject: [GIT PULL 0/3] Renesas ARM based SoC defconfig updates for v3.11 #2
Message-ID: <1371106811-25223-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

This series is based on renesas-defconfig-for-v3.11 which you
have previously pulled.

The following changes since commit 76d415dfa7d53a2f92550484d766ae475a427daf:

  ARM: shmobile: kzm9g: enable AS3711 PMIC in defconfig (2013-06-04 21:47:10 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v3.11

for you to fetch changes up to d69626d8913ceeacaa2cd369a2487c85f818fef1:

  ARM: shmobile: bockw defconfig: add MMCIF support (2013-06-12 17:25:57 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC defconfig updates for v3.11

* Changes by Morimoto-san to enable MMCIF, M25P80 and RTC RX8581 for the
  bockw board

----------------------------------------------------------------
Kuninori Morimoto (3):
      ARM: shmobile: bockw defconfig: add RTC RX8581 support
      ARM: shmobile: bockw defconfig: add M25P80 support
      ARM: shmobile: bockw defconfig: add MMCIF support

 arch/arm/configs/bockw_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)
