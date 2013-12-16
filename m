From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 16 Dec 2013 16:46:36 -0500
Subject: [GIT PULL 2/3] ARM: keystone: SOC updates for 3.14
In-Reply-To: <1387230397-14338-1-git-send-email-santosh.shilimkar@ti.com>
References: <1387230397-14338-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1387230397-14338-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Please pull below keystone SOC updates for 3.14

Regards,
Santosh

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_3.14/soc

for you to fetch changes up to 8aad10f656470369b5802da422f68d4d31fcb865:

  ARM: keystone: defconfig: enable USB support (2013-12-16 16:03:36 -0500)

----------------------------------------------------------------
Keystone SOC updates for 3.14

- Allow keystone kernel to be build in BE mode
- Enabling DMA zone support
- Removal of double of_clk_init
- Enabling USB driver support in defconfig

----------------------------------------------------------------
Santosh Shilimkar (3):
      ARM: keystone: enable DMA zone for LPAE
      ARM: keystone: Make PM bus ready before populating platform devices
      ARM: keystone: Avoid calling of_clk_init() twice

Taras Kondratiuk (1):
      ARM: keystone: enable big endian support

WingMan Kwok (1):
      ARM: keystone: defconfig: enable USB support

 arch/arm/configs/keystone_defconfig |   20 +++++++++++++++++++-
 arch/arm/mach-keystone/Kconfig      |    2 ++
 arch/arm/mach-keystone/keystone.c   |    4 ++++
 arch/arm/mach-keystone/keystone.h   |    1 +
 arch/arm/mach-keystone/pm_domain.c  |    2 --
 5 files changed, 26 insertions(+), 3 deletions(-)
