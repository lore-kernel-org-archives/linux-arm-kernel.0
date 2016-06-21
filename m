From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Tue, 21 Jun 2016 09:52:01 -0700
Subject: [GIT PULL 1/3] ARM: Keystone DTS update for 4.8
Message-ID: <1466527923-8689-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.8

for you to fetch changes up to 30220085a4b471e555f9233f861f43e4f24a0750:

  ARM: dts: k2g-evm: Add pinmuxing for UART0 (2016-06-09 09:40:21 -0700)

----------------------------------------------------------------
ARM: Keystone DTS update for 4.8

	- Pinmux entries for K2G
	- PCI DTS entry fixup

----------------------------------------------------------------
Keerthy (1):
      ARM: dts: keystone-k2l: Add pinctrl node

Lokesh Vutla (2):
      ARM: dts: keystone: Header file for pinctrl constants
      ARM: dts: k2g-evm: Add pinmuxing for UART0

Murali Karicheri (2):
      ARM: dts: keystone: remove bogus IO resource entry from PCI binding
      ARM: dts: keystone: add interrupt property to PCI controller bindings

Vitaly Andrianov (1):
      ARM: dts: k2g: Add pinctrl support

 arch/arm/boot/dts/keystone-k2e.dtsi    |   7 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts |  11 +++
 arch/arm/boot/dts/keystone-k2g.dtsi    |   8 ++
 arch/arm/boot/dts/keystone-k2l.dtsi    | 149 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi        |   7 +-
 include/dt-bindings/pinctrl/keystone.h |  39 +++++++++
 6 files changed, 217 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/keystone.h
