From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 27 Mar 2018 16:07:12 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.17 (#spdx)
Message-ID: <87o9j9txwv.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the SPDX pull request for dt for mvebu for v4.17.

Gregory

The following changes since commit 29e36c1f63d16c6fe895fa4e33b01e45a11f96de:

  ARM: dts: armada388-clearfog: add SFP module support (2018-03-27 15:07:46 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.17-spdx

for you to fetch changes up to eb59e09203312de2112b63e0f4c4b4278e4daab9:

  arm: dts: kirkwood*.dts: use SPDX-License-Identifier for board using GPL-2.0+ (2018-03-27 15:43:12 +0200)

----------------------------------------------------------------
mvebu SPDX dt for 4.17

convert to the SPDX-License-Identifier for the Kirkwood and the Armada
based device tree files.

Compared to the series submitted most of the patch have been squashed:
the result is grouped by SoC, boards, type of licenses and the patches
that were explicitly acked on the mailing list.

----------------------------------------------------------------
Gregory CLEMENT (12):
      arm: dts: armada-*.dtsi: use SPDX-License-Identifier for most of the Armada SoCs
      arm: dts: armada-xp-98dx: use SPDX-License-Identifier for prestara 98d SoCs
      arm: dts: armada-*.dts: use SPDX-License-Identifier for most of the Armada based board
      arm: dts: armada-370-db: use SPDX-License-Identifier
      arm: dts: armada-xp-db-dxbc2: use SPDX-License-Identifier
      arm: dts: armada-xp-db-xc3-24g4xg: use SPDX-License-Identifier
      arm: dts: armada-388-rd: use SPDX-License-Identifier
      arm: dts: armada-385-db-ap: use SPDX-License-Identifier
      arm: dts: armada-385-turris-omnia: use SPDX-License-Identifier
      arm: dts: kirkwood*.dts: use SPDX-License-Identifier for boards using GPL-2.0
      arm: dts: kirkwood*.dts: use SPDX-License-Identifier for boards using GPL-2.0+/MIT
      arm: dts: kirkwood*.dts: use SPDX-License-Identifier for board using GPL-2.0+

 arch/arm/boot/dts/armada-370-db.dts                | 39 +---------------------
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     | 39 +---------------------
 arch/arm/boot/dts/armada-370-mirabox.dts           | 39 +---------------------
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 39 +---------------------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 39 +---------------------
 arch/arm/boot/dts/armada-370-rd.dts                | 39 +---------------------
 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  |  5 +--
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  |  5 +--
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  5 +--
 .../dts/armada-370-seagate-personal-cloud-2bay.dts |  5 +--
 .../boot/dts/armada-370-seagate-personal-cloud.dts |  5 +--
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  5 +--
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   | 39 +---------------------
 arch/arm/boot/dts/armada-370-xp.dtsi               | 39 +---------------------
 arch/arm/boot/dts/armada-370.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-375-db.dts                | 39 +---------------------
 arch/arm/boot/dts/armada-375.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-380.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-385-db-ap.dts             | 33 +-----------------
 arch/arm/boot/dts/armada-385-linksys-caiman.dts    | 34 +------------------
 arch/arm/boot/dts/armada-385-linksys-cobra.dts     | 34 +------------------
 arch/arm/boot/dts/armada-385-linksys-rango.dts     | 34 +------------------
 arch/arm/boot/dts/armada-385-linksys-shelby.dts    | 34 +------------------
 arch/arm/boot/dts/armada-385-linksys.dtsi          | 34 +------------------
 arch/arm/boot/dts/armada-385-synology-ds116.dts    | 33 +-----------------
 arch/arm/boot/dts/armada-385-turris-omnia.dts      | 35 +------------------
 arch/arm/boot/dts/armada-385.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-388-clearfog-base.dts     | 38 +--------------------
 arch/arm/boot/dts/armada-388-clearfog-pro.dts      | 38 +--------------------
 arch/arm/boot/dts/armada-388-clearfog.dts          | 38 +--------------------
 arch/arm/boot/dts/armada-388-clearfog.dtsi         | 38 +--------------------
 arch/arm/boot/dts/armada-388-db.dts                | 39 +---------------------
 arch/arm/boot/dts/armada-388-gp.dts                | 33 +-----------------
 arch/arm/boot/dts/armada-388-rd.dts                | 39 +---------------------
 arch/arm/boot/dts/armada-388.dtsi                  | 34 +------------------
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 38 +--------------------
 arch/arm/boot/dts/armada-38x.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-390-db.dts                | 39 +---------------------
 arch/arm/boot/dts/armada-390.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-395-gp.dts                | 33 +-----------------
 arch/arm/boot/dts/armada-395.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-398-db.dts                | 39 +---------------------
 arch/arm/boot/dts/armada-398.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-39x.dtsi                  | 39 +---------------------
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 39 +---------------------
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          | 39 +---------------------
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          | 39 +---------------------
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          | 39 +---------------------
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           | 39 +---------------------
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      | 39 +---------------------
 arch/arm/boot/dts/armada-xp-db.dts                 | 38 +--------------------
 arch/arm/boot/dts/armada-xp-gp.dts                 | 39 +---------------------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    | 39 +---------------------
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      | 33 +-----------------
 arch/arm/boot/dts/armada-xp-matrix.dts             | 39 +---------------------
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 39 +---------------------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 39 +---------------------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 39 +---------------------
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     | 39 +---------------------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   | 39 +---------------------
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     | 39 +---------------------
 arch/arm/boot/dts/armada-xp.dtsi                   | 39 +---------------------
 arch/arm/boot/dts/kirkwood-b3.dts                  |  5 +--
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts   |  3 +-
 arch/arm/boot/dts/kirkwood-d2net.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |  4 +--
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |  4 +--
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  5 +--
 arch/arm/boot/dts/kirkwood-dir665.dts              |  4 +--
 arch/arm/boot/dts/kirkwood-ds109.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ds110jv10.dts           |  4 +--
 arch/arm/boot/dts/kirkwood-ds111.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ds112.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ds209.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ds210.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ds212.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ds212j.dts              |  4 +--
 arch/arm/boot/dts/kirkwood-ds409.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ds409slim.dts           |  4 +--
 arch/arm/boot/dts/kirkwood-ds411.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ds411j.dts              |  4 +--
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |  4 +--
 arch/arm/boot/dts/kirkwood-laplug.dts              |  4 +--
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   | 39 +---------------------
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    | 39 +---------------------
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   | 39 +---------------------
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    | 39 +---------------------
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  | 39 +---------------------
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   | 39 +---------------------
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   | 39 +---------------------
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        | 39 +---------------------
 arch/arm/boot/dts/kirkwood-linksys-viper.dts       |  4 +--
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  5 +--
 arch/arm/boot/dts/kirkwood-nas2big.dts             |  4 +--
 arch/arm/boot/dts/kirkwood-net2big.dts             |  4 +--
 arch/arm/boot/dts/kirkwood-net5big.dts             |  4 +--
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  6 +---
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |  6 +---
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  4 +--
 arch/arm/boot/dts/kirkwood-nsa320.dts              |  5 +--
 arch/arm/boot/dts/kirkwood-nsa325.dts              |  5 +--
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |  4 +--
 arch/arm/boot/dts/kirkwood-openrd-base.dts         |  5 +--
 arch/arm/boot/dts/kirkwood-openrd-client.dts       |  5 +--
 arch/arm/boot/dts/kirkwood-openrd-ultimate.dts     |  5 +--
 arch/arm/boot/dts/kirkwood-openrd.dtsi             |  5 +--
 arch/arm/boot/dts/kirkwood-pogo_e02.dts            |  4 +--
 arch/arm/boot/dts/kirkwood-rd88f6192.dts           |  5 +--
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         |  5 +--
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |  5 +--
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |  5 +--
 arch/arm/boot/dts/kirkwood-rs212.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-rs409.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-rs411.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |  3 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |  3 +-
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |  3 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |  4 +--
 arch/arm/boot/dts/kirkwood-t5325.dts               |  4 +--
 arch/arm/boot/dts/kirkwood-ts419-6281.dts          |  6 +---
 arch/arm/boot/dts/kirkwood-ts419-6282.dts          |  6 +---
 arch/arm/boot/dts/kirkwood-ts419.dtsi              |  6 +---
 122 files changed, 122 insertions(+), 2561 deletions(-)
