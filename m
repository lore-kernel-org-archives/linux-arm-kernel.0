From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Mar 2014 15:48:23 +0800
Subject: [GIT PULL 2/2] ARM: Keystone SOC updates for 3.15
In-Reply-To: <1394005703-6624-1-git-send-email-santosh.shilimkar@ti.com>
References: <1394005703-6624-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1394005703-6624-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm-soc folks,

Please pull below keystone SOC updates for 3.15. It merges cleanly with
arm-soc 'for-next' and 'next/soc' heads.

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc

for you to fetch changes up to d6bb841291c44575e23ca0b6bb6b441661b0843f:

  ARM: config: keystone: enable AEMIF/NAND support (2014-02-28 21:06:46 -0500)

----------------------------------------------------------------
Keystone SOC updates for 3.15

- Enable Watchdog and GPIO config
- Enable LED driver config
- Enable NAND and EMIF driver config

----------------------------------------------------------------
Grygorii Strashko (2):
      ARM: config: keystone: enable gpio support
      ARM: config: keystone: enable led support

Ivan Khoronzhuk (2):
      ARM: config: keystone: enable watchdog support
      ARM: config: keystone: enable AEMIF/NAND support

 arch/arm/configs/keystone_defconfig |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
