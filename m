From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Mon, 25 Apr 2016 10:51:20 -0700
Subject: [GIT PULL 1/2] ARM: Keystone dts update for 4.7
Message-ID: <1461606681-4284-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.7

for you to fetch changes up to 14de48a412f00f8e0a5413844d846bc5657db327:

  ARM: keystone: dts: add psci command definition (2016-04-13 08:55:44 -0700)

----------------------------------------------------------------
ARM: Keystone DTS for 4.7

- Remainder k2-* rename to keystone-*
- PSCI node info
- SPI alias nodes for bootloaders

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: dts: k2*: Rename the k2* files to keystone-k2* files

Vignesh R (1):
      ARM: dts: keystone: Add aliases for SPI nodes

Vitaly Andrianov (1):
      ARM: keystone: dts: add psci command definition

 MAINTAINERS                                                   |  2 +-
 arch/arm/boot/dts/Makefile                                    |  6 +++---
 .../boot/dts/{k2e-clocks.dtsi => keystone-k2e-clocks.dtsi}    |  0
 arch/arm/boot/dts/{k2e-evm.dts => keystone-k2e-evm.dts}       |  2 +-
 arch/arm/boot/dts/{k2e-netcp.dtsi => keystone-k2e-netcp.dtsi} |  0
 arch/arm/boot/dts/{k2e.dtsi => keystone-k2e.dtsi}             |  4 ++--
 .../boot/dts/{k2hk-clocks.dtsi => keystone-k2hk-clocks.dtsi}  |  0
 arch/arm/boot/dts/{k2hk-evm.dts => keystone-k2hk-evm.dts}     |  2 +-
 .../boot/dts/{k2hk-netcp.dtsi => keystone-k2hk-netcp.dtsi}    |  0
 arch/arm/boot/dts/{k2hk.dtsi => keystone-k2hk.dtsi}           |  4 ++--
 .../boot/dts/{k2l-clocks.dtsi => keystone-k2l-clocks.dtsi}    |  0
 arch/arm/boot/dts/{k2l-evm.dts => keystone-k2l-evm.dts}       |  2 +-
 arch/arm/boot/dts/{k2l-netcp.dtsi => keystone-k2l-netcp.dtsi} |  0
 arch/arm/boot/dts/{k2l.dtsi => keystone-k2l.dtsi}             |  4 ++--
 arch/arm/boot/dts/keystone.dtsi                               | 11 +++++++++++
 15 files changed, 24 insertions(+), 13 deletions(-)
 rename arch/arm/boot/dts/{k2e-clocks.dtsi => keystone-k2e-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2e-evm.dts => keystone-k2e-evm.dts} (98%)
 rename arch/arm/boot/dts/{k2e-netcp.dtsi => keystone-k2e-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2e.dtsi => keystone-k2e.dtsi} (97%)
 rename arch/arm/boot/dts/{k2hk-clocks.dtsi => keystone-k2hk-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2hk-evm.dts => keystone-k2hk-evm.dts} (99%)
 rename arch/arm/boot/dts/{k2hk-netcp.dtsi => keystone-k2hk-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2hk.dtsi => keystone-k2hk.dtsi} (96%)
 rename arch/arm/boot/dts/{k2l-clocks.dtsi => keystone-k2l-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2l-evm.dts => keystone-k2l-evm.dts} (98%)
 rename arch/arm/boot/dts/{k2l-netcp.dtsi => keystone-k2l-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2l.dtsi => keystone-k2l.dtsi} (96%)
