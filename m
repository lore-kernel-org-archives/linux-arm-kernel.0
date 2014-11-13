From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 12 Nov 2014 17:59:42 -0800
Subject: [GIT PULL 3/3] ARM: Keystone dts updates for 3.19
In-Reply-To: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
References: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1415843982-5739-3-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts

for you to fetch changes up to fc89a576006794f06f7b2919131f6e3e07af5b92:

  ARM: dts: keystone-k2e: add DT bindings for PCI controller for port 1 (2014-11-04 10:27:21 -0800)

----------------------------------------------------------------
Keystone dts updates for 3.19

	- PCIE controller related updates
	- 1GBe phy related upates

----------------------------------------------------------------
Grygorii Strashko (2):
      ARM: dts: k2e-evm: add 1g ethernet phys nodes
      ARM: dts: k2l-evm: add 1g ethernet phys nodes

Murali Karicheri (2):
      ARM: dts: keystone: add DT bindings for PCI controller for port 0
      ARM: dts: keystone-k2e: add DT bindings for PCI controller for port 1

 arch/arm/boot/dts/k2e-evm.dts   | 12 +++++++++++
 arch/arm/boot/dts/k2e.dtsi      | 45 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2l-evm.dts   | 12 +++++++++++
 arch/arm/boot/dts/keystone.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)
