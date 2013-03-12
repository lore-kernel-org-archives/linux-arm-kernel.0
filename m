From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 12 Mar 2013 09:47:36 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.10
Message-ID: <20130312134736.GH12700@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_dt_for_v3.10

for you to fetch changes up to c3117edec5f92cce39f2d220c62f76675397af8d:

  Dove: Thermal: Add DT node and enable in defconfig (2013-03-12 11:33:22 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.10

 - mvebu: gpio expander for the Mirabox
 - kirkwood: thermal sensor
 - dove: thermal sensor

----------------------------------------------------------------
Andrew Lunn (1):
      Dove: Thermal: Add DT node and enable in defconfig

Gregory CLEMENT (1):
      arm: mvebu: enable gpio expander over i2c on Mirabox platform

Nobuhiro Iwamatsu (1):
      ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283

 arch/arm/boot/dts/armada-370-mirabox.dts | 11 +++++++++++
 arch/arm/boot/dts/dove.dtsi              |  5 +++++
 arch/arm/boot/dts/kirkwood-6282.dtsi     |  6 ++++++
 arch/arm/configs/dove_defconfig          |  2 ++
 arch/arm/configs/kirkwood_defconfig      |  2 ++
 5 files changed, 26 insertions(+)
