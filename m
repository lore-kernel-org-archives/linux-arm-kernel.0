From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 17 Jul 2017 12:56:50 +0800
Subject: [GIT PULL] i.MX fixes for 4.13
Message-ID: <20170717045648.GD3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.13

for you to fetch changes up to 05969566e6d64113a861adc6c17cbba685c640b3:

  ARM: dts: imx7d-sdb: Put pinctrl_spi4 in the correct location (2017-07-16 09:43:04 +0800)

----------------------------------------------------------------
i.MX fixes for 4.13:
 - A fix for imx7d-sdb board to move pinctrl_spi4 pins from low power
   iomux controller to normal iomuxc node, as the pins belong to normal
   iomuxc rather than low power one.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx7d-sdb: Put pinctrl_spi4 in the correct location

 arch/arm/boot/dts/imx7d-sdb.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
