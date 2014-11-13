From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 12 Nov 2014 17:59:41 -0800
Subject: [GIT PULL 2/3] ARM: keystone: config updates for 3.19
In-Reply-To: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
References: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1415843982-5739-2-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc

for you to fetch changes up to 97ef1af9b275924406556bfaec528a3e9e2980c7:

  ARM: keystone: defconfig: add options to enable PCI controller (2014-11-04 10:29:39 -0800)

----------------------------------------------------------------
Keystone config updates for 3.19

	- Enable PCIE controller and related options
	- Enable MDIO and ethernet phy options
	- Enable DSP IRQCHIP option

----------------------------------------------------------------
Grygorii Strashko (2):
      ARM: keystone_defconfig: enable dsp irq and gpio support
      ARM: keystone_defconfig: enable mdio and marvell eth phys

Murali Karicheri (2):
      ARM: keystone: add pcie related options
      ARM: keystone: defconfig: add options to enable PCI controller

 arch/arm/configs/keystone_defconfig | 7 +++++++
 arch/arm/mach-keystone/Kconfig      | 2 ++
 2 files changed, 9 insertions(+)
