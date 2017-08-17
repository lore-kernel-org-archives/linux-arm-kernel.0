From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 16 Aug 2017 17:30:41 -0700
Subject: [GIT PULL 2/3] ARM: Keystone config bits for 4.14
In-Reply-To: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
References: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1502929842-8156-2-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_4.14

for you to fetch changes up to 97bb74db1ed9955a89a684095542cb98c9ccdae9:

  ARM: configs: keystone: Enable D_CAN driver (2017-08-10 09:50:42 -0700)

----------------------------------------------------------------
ARM: Keystone config bits for 4.14

Enables:
- Message Manager
- TI SCI & GenPD driver
- Reset drivers
- MMC & regulators
- DCAN driver

----------------------------------------------------------------
Franklin S Cooper Jr (1):
      ARM: configs: keystone: Enable D_CAN driver

Lokesh Vutla (1):
      ARM: configs: keystone: Enable MMC and regulators

Nishanth Menon (2):
      ARM: configs: keystone: Enable Message Manager
      ARM: configs: keystone: Enable TI-SCI protocol and genpd driver

Suman Anna (1):
      ARM: configs: keystone: Enable reset drivers

 arch/arm/configs/keystone_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)
