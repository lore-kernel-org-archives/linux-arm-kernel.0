From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Mar 2018 10:02:32 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.17 (#2)
Message-ID: <87zi33w253.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.17.

Gregory

The following changes since commit a83aeb3836b1cd65770b20eafefbef7467972fa2:

  ARM: dts: armada388-clearfog: increase speed of i2c0 to 400kHz (2018-03-05 17:33:42 +0100)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.17-2

for you to fetch changes up to c46b3bfd89da9a127ad89792054c408776c34590:

  ARM: dts: armada388-clearfog: add SFP module support (2018-03-19 22:40:04 +0100)

----------------------------------------------------------------
mvebu dt for 4.17 (part 2)

 - convert to the SPDX-License-Identifier for the kirkwood and the
   armada based device tree files

 - add SFP module support on the clearfog (Armada 388 based board)

 - disable internal RTC node for Linksys boards (Armada 38x based
   boards)

----------------------------------------------------------------
Gregory CLEMENT (96):
      arm: dts: armada-370-xp: use SPDX-License-Identifier for Armada 370/XP SoCs
      arm: dts: armada-375: use SPDX-License-Identifier for Armada 375 SoCs
      arm: dts: armada-38x: use SPDX-License-Identifier for Armada 38x SoCs
      arm: dts: armada-39x: use SPDX-License-Identifier for Armada 39x SoCs
      arm: dts: armada-xp-98dx: use SPDX-License-Identifier for prestara 98d SoCs
      arm: dts: armada-370-db: use SPDX-License-Identifier
      arm: dts: armada-370-dlink-dns327l: use SPDX-License-Identifier
      arm: dts: armada-370-mirabox: use SPDX-License-Identifier
      arm: dts: armada-370-netgear-rn*: use SPDX-License-Identifier
      arm: dts: armada-370-rd: use SPDX-License-Identifier
      arm: dts: armada-370-synology-ds213j: use SPDX-License-Identifier
      arm: dts: armada-375-db: use SPDX-License-Identifier
      arm: dts: armada-388-db: use SPDX-License-Identifier
      arm: dts: armada-388-rd: use SPDX-License-Identifier
      arm: dts: armada-390-db: use SPDX-License-Identifier
      arm: dts: armada-398-db: use SPDX-License-Identifier
      arm: dts: armada-xp-axpwifiap: use SPDX-License-Identifier
      arm: dts: armada-xp-db-dxbc2: use SPDX-License-Identifier
      arm: dts: armada-xp-db-xc3-24g4xg: use SPDX-License-Identifier
      arm: dts: armada-xp-db: use SPDX-License-Identifier
      arm: dts: armada-xp-gp: use SPDX-License-Identifier
      arm: dts: armada-xp-lenovo-ix4-300d: use SPDX-License-Identifier
      arm: dts: armada-xp-matrix: use SPDX-License-Identifier
      arm: dts: armada-xp-netgear-rn2120: use SPDX-License-Identifier
      arm: dts: armada-xp-openblocks-ax3-4: use SPDX-License-Identifier
      arm: dts: armada-xp-synology-ds414: use SPDX-License-Identifier
      arm: dts: armada-385-db-ap: use SPDX-License-Identifier
      arm: dts: armada-385-linksys*: use SPDX-License-Identifier for Linksys boards
      arm: dts: armada-385-synology-ds116: use SPDX-License-Identifier
      arm: dts: armada-385-turris-omnia: use SPDX-License-Identifier
      arm: dts: armada-388-clearfog*: use SPDX-License-Identifier for clearfog and microsom
      arm: dts: armada-388-gp: use SPDX-License-Identifier
      arm: dts: armada-395-gp: use SPDX-License-Identifier
      arm: dts: armada-xp-linksys-mamba: use SPDX-License-Identifier
      arm: dts: armada-370-seagate-nas-*: use SPDX-License-Identifier
      arm: dts: armada-370-seagate-personal-cloud*: use SPDX-License-Identifier
      arm: dts: kirkwood-linkstation-6282: use SPDX-License-Identifier
      arm: dts: kirkwood-linkstation-duo-6281: use SPDX-License-Identifier
      arm: dts: kirkwood-linkstation-lsqvl: use SPDX-License-Identifier
      arm: dts: kirkwood-linkstation-lsvl: use SPDX-License-Identifier
      arm: dts: kirkwood-linkstation-lswsxl: use SPDX-License-Identifier
      arm: dts: kirkwood-linkstation-lswvl: use SPDX-License-Identifier
      arm: dts: kirkwood-linkstation-lswxl: use SPDX-License-Identifier
      arm: dts: kirkwood-linkstation: use SPDX-License-Identifier
      arm: dts: kirkwood-d2net: use SPDX-License-Identifier
      arm: dts: kirkwood-db-88f6281: use SPDX-License-Identifier
      arm: dts: kirkwood-db-88f6282: use SPDX-License-Identifier
      arm: dts: kirkwood-db: use SPDX-License-Identifier
      arm: dts: kirkwood-dir665: use SPDX-License-Identifier
      arm: dts: kirkwood-ds109: use SPDX-License-Identifier
      arm: dts: kirkwood-ds110jv10: use SPDX-License-Identifier
      arm: dts: kirkwood-ds111: use SPDX-License-Identifier
      arm: dts: kirkwood-ds112: use SPDX-License-Identifier
      arm: dts: kirkwood-ds209: use SPDX-License-Identifier
      arm: dts: kirkwood-ds210: use SPDX-License-Identifier
      arm: dts: kirkwood-ds212: use SPDX-License-Identifier
      arm: dts: kirkwood-ds212j: use SPDX-License-Identifier
      arm: dts: kirkwood-ds409: use SPDX-License-Identifier
      arm: dts: kirkwood-ds409slim: use SPDX-License-Identifier
      arm: dts: kirkwood-ds411: use SPDX-License-Identifier
      arm: dts: kirkwood-ds411j: use SPDX-License-Identifier
      arm: dts: kirkwood-ds411slim: use SPDX-License-Identifier
      arm: dts: kirkwood-laplug: use SPDX-License-Identifier
      arm: dts: kirkwood-linksys-viper: use SPDX-License-Identifier
      arm: dts: kirkwood-mv88f6281gtw-ge: use SPDX-License-Identifier
      arm: dts: kirkwood-nas2big: use SPDX-License-Identifier
      arm: dts: kirkwood-net2big: use SPDX-License-Identifier
      arm: dts: kirkwood-net5big: use SPDX-License-Identifier
      arm: dts: kirkwood-netxbig: use SPDX-License-Identifier
      arm: dts: kirkwood-openblocks_a7: use SPDX-License-Identifier
      arm: dts: kirkwood-openrd-base: use SPDX-License-Identifier
      arm: dts: kirkwood-openrd-client: use SPDX-License-Identifier
      arm: dts: kirkwood-openrd-ultimate: use SPDX-License-Identifier
      arm: dts: kirkwood-openrd: use SPDX-License-Identifier
      arm: dts: kirkwood-pogo_e02: use SPDX-License-Identifier
      arm: dts: kirkwood-rd88f6192: use SPDX-License-Identifier
      arm: dts: kirkwood-rd88f6281-a: use SPDX-License-Identifier
      arm: dts: kirkwood-rd88f6281-z0: use SPDX-License-Identifier
      arm: dts: kirkwood-rd88f6281: use SPDX-License-Identifier
      arm: dts: kirkwood-rs212: use SPDX-License-Identifier
      arm: dts: kirkwood-rs409: use SPDX-License-Identifier
      arm: dts: kirkwood-rs411: use SPDX-License-Identifier
      arm: dts: kirkwood-synology: use SPDX-License-Identifier
      arm: dts: kirkwood-t5325: use SPDX-License-Identifier
      arm: dts: kirkwood-b3: use SPDX-License-Identifier
      arm: dts: kirkwood-netgear_readynas_duo_v2: use SPDX-License-Identifier
      arm: dts: kirkwood-netgear_readynas_nv+_v2: use SPDX-License-Identifier
      arm: dts: kirkwood-nsa320: use SPDX-License-Identifier
      arm: dts: kirkwood-nsa325: use SPDX-License-Identifier
      arm: dts: kirkwood-ts419-6281: use SPDX-License-Identifier
      arm: dts: kirkwood-ts419-6282: use SPDX-License-Identifier
      arm: dts: kirkwood-ts419: use SPDX-License-Identifier
      arm: dts: kirkwood-sheevaplug-common: use SPDX-License-Identifier
      arm: dts: kirkwood-sheevaplug-esata: use SPDX-License-Identifier
      arm: dts: kirkwood-sheevaplug: use SPDX-License-Identifier
      arm: dts: kirkwood-blackarmor-nas220: use SPDX-License-Identifier

Hauke Mehrtens (1):
      ARM: dts: armada-385-linksys: Disable internal RTC

Russell King (1):
      ARM: dts: armada388-clearfog: add SFP module support

 arch/arm/boot/dts/armada-370-db.dts                | 39 +---------
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     | 39 +---------
 arch/arm/boot/dts/armada-370-mirabox.dts           | 39 +---------
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 39 +---------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 39 +---------
 arch/arm/boot/dts/armada-370-rd.dts                | 39 +---------
 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  |  5 +-
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  |  5 +-
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  5 +-
 .../dts/armada-370-seagate-personal-cloud-2bay.dts |  5 +-
 .../boot/dts/armada-370-seagate-personal-cloud.dts |  5 +-
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  5 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   | 39 +---------
 arch/arm/boot/dts/armada-370-xp.dtsi               | 39 +---------
 arch/arm/boot/dts/armada-370.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-375-db.dts                | 39 +---------
 arch/arm/boot/dts/armada-375.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-380.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-385-db-ap.dts             | 33 +--------
 arch/arm/boot/dts/armada-385-linksys-caiman.dts    | 34 +--------
 arch/arm/boot/dts/armada-385-linksys-cobra.dts     | 34 +--------
 arch/arm/boot/dts/armada-385-linksys-rango.dts     | 34 +--------
 arch/arm/boot/dts/armada-385-linksys-shelby.dts    | 34 +--------
 arch/arm/boot/dts/armada-385-linksys.dtsi          | 39 ++--------
 arch/arm/boot/dts/armada-385-synology-ds116.dts    | 33 +--------
 arch/arm/boot/dts/armada-385-turris-omnia.dts      | 35 +--------
 arch/arm/boot/dts/armada-385.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-388-clearfog-base.dts     | 38 +---------
 arch/arm/boot/dts/armada-388-clearfog-pro.dts      | 38 +---------
 arch/arm/boot/dts/armada-388-clearfog.dts          | 38 +---------
 arch/arm/boot/dts/armada-388-clearfog.dtsi         | 83 ++++------------------
 arch/arm/boot/dts/armada-388-db.dts                | 39 +---------
 arch/arm/boot/dts/armada-388-gp.dts                | 33 +--------
 arch/arm/boot/dts/armada-388-rd.dts                | 39 +---------
 arch/arm/boot/dts/armada-388.dtsi                  | 34 +--------
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 38 +---------
 arch/arm/boot/dts/armada-38x.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-390-db.dts                | 39 +---------
 arch/arm/boot/dts/armada-390.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-395-gp.dts                | 33 +--------
 arch/arm/boot/dts/armada-395.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-398-db.dts                | 39 +---------
 arch/arm/boot/dts/armada-398.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-39x.dtsi                  | 39 +---------
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 39 +---------
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          | 39 +---------
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          | 39 +---------
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          | 39 +---------
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           | 39 +---------
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      | 39 +---------
 arch/arm/boot/dts/armada-xp-db.dts                 | 38 +---------
 arch/arm/boot/dts/armada-xp-gp.dts                 | 39 +---------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    | 39 +---------
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      | 33 +--------
 arch/arm/boot/dts/armada-xp-matrix.dts             | 39 +---------
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 39 +---------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 39 +---------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 39 +---------
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     | 39 +---------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   | 39 +---------
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     | 39 +---------
 arch/arm/boot/dts/armada-xp.dtsi                   | 39 +---------
 arch/arm/boot/dts/kirkwood-b3.dts                  |  5 +-
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts   |  3 +-
 arch/arm/boot/dts/kirkwood-d2net.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |  4 +-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |  4 +-
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  5 +-
 arch/arm/boot/dts/kirkwood-dir665.dts              |  4 +-
 arch/arm/boot/dts/kirkwood-ds109.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ds110jv10.dts           |  4 +-
 arch/arm/boot/dts/kirkwood-ds111.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ds112.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ds209.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ds210.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ds212.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ds212j.dts              |  4 +-
 arch/arm/boot/dts/kirkwood-ds409.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ds409slim.dts           |  4 +-
 arch/arm/boot/dts/kirkwood-ds411.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ds411j.dts              |  4 +-
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |  4 +-
 arch/arm/boot/dts/kirkwood-laplug.dts              |  4 +-
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   | 39 +---------
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    | 39 +---------
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   | 39 +---------
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    | 39 +---------
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  | 39 +---------
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   | 39 +---------
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   | 39 +---------
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        | 39 +---------
 arch/arm/boot/dts/kirkwood-linksys-viper.dts       |  4 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  5 +-
 arch/arm/boot/dts/kirkwood-nas2big.dts             |  4 +-
 arch/arm/boot/dts/kirkwood-net2big.dts             |  4 +-
 arch/arm/boot/dts/kirkwood-net5big.dts             |  4 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  6 +-
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |  6 +-
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  4 +-
 arch/arm/boot/dts/kirkwood-nsa320.dts              |  5 +-
 arch/arm/boot/dts/kirkwood-nsa325.dts              |  5 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |  4 +-
 arch/arm/boot/dts/kirkwood-openrd-base.dts         |  5 +-
 arch/arm/boot/dts/kirkwood-openrd-client.dts       |  5 +-
 arch/arm/boot/dts/kirkwood-openrd-ultimate.dts     |  5 +-
 arch/arm/boot/dts/kirkwood-openrd.dtsi             |  5 +-
 arch/arm/boot/dts/kirkwood-pogo_e02.dts            |  4 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts           |  5 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         |  5 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |  5 +-
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |  5 +-
 arch/arm/boot/dts/kirkwood-rs212.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-rs409.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-rs411.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |  3 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |  3 +-
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |  3 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |  4 +-
 arch/arm/boot/dts/kirkwood-t5325.dts               |  4 +-
 arch/arm/boot/dts/kirkwood-ts419-6281.dts          |  6 +-
 arch/arm/boot/dts/kirkwood-ts419-6282.dts          |  6 +-
 arch/arm/boot/dts/kirkwood-ts419.dtsi              |  6 +-
 122 files changed, 139 insertions(+), 2594 deletions(-)
