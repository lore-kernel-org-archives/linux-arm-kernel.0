From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Thu, 25 Feb 2016 13:49:17 -0800
Subject: [GIT PULL v2] ARM: Keystone DTS for 4.6 
Message-ID: <1456436957-22836-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Find updated pull request renaming the newly added DTS files. 

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.6_v2

for you to fetch changes up to 5b7551db86884c54bf1d2e2a943d4ec3f5463da8:

  ARM: dts: keystone: Add minimum support for K2G evm (2016-02-25 09:27:39 -0800)

----------------------------------------------------------------
ARM: DTS: Add new bindings for K2G and the K2G evm

K2G SoC family is the newest version of the Keystone family of processors.

The technical reference manual for K2G can be found here:
http://www.ti.com/lit/ug/spruhy8/spruhy8.pdf

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: keystone: Create new binding for K2G SoC

Vitaly Andrianov (2):
      ARM: dts: keystone: Add Initial DT support for TI K2G SoC family
      ARM: dts: keystone: Add minimum support for K2G evm

 .../devicetree/bindings/arm/keystone/keystone.txt  |  5 ++
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts             | 32 ++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi                | 89 ++++++++++++++++++++++
 arch/arm/mach-keystone/keystone.c                  |  1 +
 5 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-evm.dts
 create mode 100644 arch/arm/boot/dts/keystone-k2g.dtsi
