From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 31 Aug 2016 19:05:10 -0400
Subject: [GIT PULL 2/2] ARM: config: Keystone config update for 4.9
In-Reply-To: <1472684710-22905-1-git-send-email-ssantosh@kernel.org>
References: <1472684710-22905-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1472684710-22905-2-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.9

for you to fetch changes up to 81b1f69e0185b1e9053ae5ce3948967ccaa29bba:

  ARM: keystone: defconfig: Fix USB configuration (2016-08-31 16:10:50 -0400)

----------------------------------------------------------------
ARM: config: Add CONFIG_NOP_USB_XCEIV

Keystone usb phy needs CONFIG_NOP_USB_XCEIV to be enabled.

----------------------------------------------------------------
Roger Quadros (1):
      ARM: keystone: defconfig: Fix USB configuration

 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)
