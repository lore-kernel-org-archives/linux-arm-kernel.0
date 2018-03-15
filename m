From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:02 +0100
Subject: [PATCH 00/60] use SPDX-License-Identifier for Kirkwood boards
Message-ID: <20180315165102.27160-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series follow the recent trend for the license description to use
the SPDX-License-Identifier.

The device tree for the SoCs were already converted because they
didn't have any licenses, so they were attributed a GPLv2.0 one.

In the end for kirkwood we have:

- 89 files under GPL2.0 (including the ones that initially didn't have
  any license)

- 8 files under GPL2.0+

- 8 files under dual license GPL2.0+/MIT (improperly called X11)

For the Armada we already switched all the file under a dual license
GPL2.0/MIT or GPL2.0+/MIT, allowing other project to reuse the same
device tree file. Maybe we should do the same for kirkwood, at least
for the device tree describing the SoCs.

But I know it is not so easy because in this case we need to contact
all the author in order to modify the license.

Gregory


Gregory CLEMENT (60):
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
  arm: dts: kirkwood-netgear_readynas_duo_v2: use
    SPDX-License-Identifier
  arm: dts: kirkwood-netgear_readynas_nv+_v2: use
    SPDX-License-Identifier
  arm: dts: kirkwood-nsa320: use SPDX-License-Identifier
  arm: dts: kirkwood-nsa325: use SPDX-License-Identifier
  arm: dts: kirkwood-ts419-6281: use SPDX-License-Identifier
  arm: dts: kirkwood-ts419-6282: use SPDX-License-Identifier
  arm: dts: kirkwood-ts419: use SPDX-License-Identifier
  arm: dts: kirkwood-sheevaplug-common: use SPDX-License-Identifier
  arm: dts: kirkwood-sheevaplug-esata: use SPDX-License-Identifier
  arm: dts: kirkwood-sheevaplug: use SPDX-License-Identifier
  arm: dts: kirkwood-blackarmor-nas220: use SPDX-License-Identifier

 arch/arm/boot/dts/kirkwood-b3.dts                  |  5 +--
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts   |  2 --
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
 60 files changed, 59 insertions(+), 479 deletions(-)

-- 
2.16.1
