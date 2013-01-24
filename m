From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 24 Jan 2013 12:49:37 +0000
Subject: [GIT PULL] vexpress: fixes for v3.8-rc5
Message-ID: <1359031777.26878.49.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Could you, please, pull this small series of VE fixes for v3.8-rc5? It:

* makes the V2P-CA15_A7 (a.k.a. TC2) work with 3.8 kernels
* improves vexpress-sysreg.c behaviour on arm64 platforms

Thanks!

Pawel

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress/fixes

for you to fetch changes up to 52666298aebe5e9ab28a773ee61d2ce81fa097bb:

  mfd: vexpress-sysreg: Don't skip initialization on probe (2013-01-24 12:19:23 +0000)

----------------------------------------------------------------
Lorenzo Pieralisi (1):
      ARM: vexpress: extend the MPIDR range used for pen release check

Pawel Moll (2):
      ARM: vexpress: Enable A7 cores in V2P-CA15_A7's Device Tree
      mfd: vexpress-sysreg: Don't skip initialization on probe

 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts |    2 --
 arch/arm/plat-versatile/headsmp.S          |    2 +-
 drivers/mfd/vexpress-sysreg.c              |   32 +++++++++++++++++-----------
 3 files changed, 21 insertions(+), 15 deletions(-)
