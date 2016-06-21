From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Tue, 21 Jun 2016 09:52:02 -0700
Subject: [GIT PULL 2/3] ARM: Keystone config updates for 4.8
In-Reply-To: <1466527923-8689-1-git-send-email-ssantosh@kernel.org>
References: <1466527923-8689-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1466527923-8689-2-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.8

for you to fetch changes up to 229a4bc846e85461252ab7aec3ab2cae4bf22a9c:

  ARM: keystone: remove redundant depends on ARM_PATCH_PHYS_VIRT (2016-06-14 17:56:51 -0700)

----------------------------------------------------------------
ARM: Keystone config updates for 4.8

	- Enable PINCTRL support
	- Remove redundant ARM_PATCH_PHYS_VIRT

----------------------------------------------------------------
Franklin S Cooper Jr (1):
      ARM: keystone: Enable PINCTRL_SINGLE Config

Lokesh Vutla (1):
      ARM: keystone: Enable PINCTRL config

Masahiro Yamada (1):
      ARM: keystone: remove redundant depends on ARM_PATCH_PHYS_VIRT

 arch/arm/configs/keystone_defconfig | 1 +
 arch/arm/mach-keystone/Kconfig      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
