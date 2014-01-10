From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jan 2014 11:45:34 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v3.14
Message-ID: <cover.1389321620.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider these renesas ARM Based SoC Fixes for v3.14.

This pull-request is based on the Third Round of Renesas ARM Based SoC
Updates for v3.14, tagged as renesas-soc3-for-v3.14, which you have
previously pulled.

It resolves a problem introduced by a patch included in the second round of such
changes, tagged as renesas-soc2-for-v3.14, which you have also previously
pulled.

renesas-soc3-for-v3.14 is based on renesas-soc2-for-v3.14.



The following changes since commit d85bcfa916ffdf078f188aeab60f738b290f4309:

  arm: shmobile: r7s72100: add i2c clocks (2013-12-24 21:09:19 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-fixes-for-v3.14

for you to fetch changes up to db455c786886465c4d7fcd012fe2684b4c887776:

  ARM: shmobile: r8a7790: Fix I2C controller names (2014-01-06 14:25:39 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v3.14

* r8a7790 (R-Car H2) SoC

  - Correct I2C controller names

    This fixes the issue introduced by
    b448c904f5058b6c "ARM: shmobile: r8a7790: add I2C support"
    which is queued-up for v3.14.

----------------------------------------------------------------
Valentine Barshak (1):
      ARM: shmobile: r8a7790: Fix I2C controller names

 arch/arm/mach-shmobile/clock-r8a7790.c | 8 ++++----
 arch/arm/mach-shmobile/setup-r8a7790.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
