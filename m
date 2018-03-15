From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 16:06:41 +0100
Subject: [PATCH 00/36] use SPDX-License-Identifier for 32 bits Armada SoCs and
 boards
Message-ID: <20180315150717.10588-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series follow the recent trend for the license description to use
the SPDX-License-Identifier.

Gregory

Gregory CLEMENT (36):
  arm: dts: armada-370-xp: use SPDX-License-Identifier for Armada 370/XP
    SoCs
  arm: dts: armada-375: use SPDX-License-Identifier for Armada 375 SoCs
  arm: dts: armada-38x: use SPDX-License-Identifier for Armada 38x SoCs
  arm: dts: armada-39x: use SPDX-License-Identifier for Armada 39x SoCs
  arm: dts: armada-xp-98dx: use SPDX-License-Identifier for prestara 98d
    SoCs
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
  arm: dts: armada-385-linksys*: use SPDX-License-Identifier for Linksys
    boards
  arm: dts: armada-385-synology-ds116: use SPDX-License-Identifier
  arm: dts: armada-385-turris-omnia: use SPDX-License-Identifier
  arm: dts: armada-388-clearfog*: use SPDX-License-Identifier for
    clearfog and microsom
  arm: dts: armada-388-gp: use SPDX-License-Identifier
  arm: dts: armada-395-gp: use SPDX-License-Identifier
  arm: dts: armada-xp-linksys-mamba: use SPDX-License-Identifier
  arm: dts: armada-370-seagate-nas-*: use SPDX-License-Identifier
  arm: dts: armada-370-seagate-personal-cloud*: use
    SPDX-License-Identifier

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
 62 files changed, 62 insertions(+), 2082 deletions(-)

-- 
2.16.1
