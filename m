From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Sat, 21 Jan 2017 15:02:37 -0800
Subject: [GIT_PULL 2/3] ARM: Keystone config for 4.11
In-Reply-To: <1485039758-15248-1-git-send-email-ssantosh@kernel.org>
References: <1485039758-15248-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1485039758-15248-2-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.11

for you to fetch changes up to a2735c3067e7c25c46433c1d73b97d4d4e512de8:

  ARM: Keystone: Enable ARCH_HAS_RESET_CONTROLLER (2017-01-19 09:36:08 -0800)

----------------------------------------------------------------
ARM: Keystone config support for 4.11

	- Enable Reset controller and on chip MSM RAM support.

----------------------------------------------------------------
Suman Anna (2):
      ARM: configs: keystone: Enable Generic on-chip SRAM driver
      ARM: Keystone: Enable ARCH_HAS_RESET_CONTROLLER

 arch/arm/configs/keystone_defconfig | 1 +
 arch/arm/mach-keystone/Kconfig      | 1 +
 2 files changed, 2 insertions(+)
