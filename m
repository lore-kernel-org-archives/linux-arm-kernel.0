From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 10 Jun 2015 15:51:21 -0700
Subject: [GIT PULL v2] Keystone DTS update for v4.2
Message-ID: <1433976681-4179-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

As you suggested, please find updated pull request without the config patch.


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts-for-4.2

for you to fetch changes up to 0b239342305069a09afda35e52e1f49d171a87b2:

  ARM: dts: k2l: fix the netcp range size (2015-06-10 15:43:00 -0700)

----------------------------------------------------------------
Keystone DTS update for 4.2
	- Includes NETCP related EVM updates

----------------------------------------------------------------
Murali Karicheri (6):
      ARM: dts: k2hk-evm: Add device bindings for netcp driver
      ARM: dts: k2e-evm: Add device bindings for netcp driver
      ARM: dts: k2l-evm: Add device bindings for netcp driver
      ARM: dts: k2hk: fix the netcp range size
      ARM: dts: k2e: fix the netcp range size
      ARM: dts: k2l: fix the netcp range size

 arch/arm/boot/dts/k2e-evm.dts     |   1 +
 arch/arm/boot/dts/k2e-netcp.dtsi  | 206 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2e.dtsi        |   1 +
 arch/arm/boot/dts/k2hk-evm.dts    |   1 +
 arch/arm/boot/dts/k2hk-netcp.dtsi | 208 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2hk.dtsi       |   1 +
 arch/arm/boot/dts/k2l-evm.dts     |   1 +
 arch/arm/boot/dts/k2l-netcp.dtsi  | 189 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2l.dtsi        |   1 +
 9 files changed, 609 insertions(+)
 create mode 100644 arch/arm/boot/dts/k2e-netcp.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk-netcp.dtsi
 create mode 100644 arch/arm/boot/dts/k2l-netcp.dtsi
