From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu,  8 Jun 2017 18:51:31 +0200
Subject: [PATCH v4 0/3] nvmem: upstream snvs_lpgpr driver
Message-ID: <20170608165134.14971-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changes v4:
 - change dependencies in Kconfig
 - remove unused includes and order them alphabetically
 - set MODULE_LICENSE = GPL v2
 - remove unused int err variable

changes v3:
 - remove regmap and offset properties.

changes v2:
 - correct typos: Registe, parrent...

Oleksij Rempel (3):
  nvmem: dt: document SNVS LPGPR binding
  nvmem: add snvs_lpgpr driver
  ARM: dts: imx6qdl.dtsi: add "fsl,imx6q-snvs-lpgpr" node

 .../devicetree/bindings/nvmem/snvs-lpgpr.txt       |  19 +++
 arch/arm/boot/dts/imx6qdl.dtsi                     |   4 +
 drivers/nvmem/Kconfig                              |  10 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/snvs_lpgpr.c                         | 136 +++++++++++++++++++++
 5 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
 create mode 100644 drivers/nvmem/snvs_lpgpr.c

-- 
2.11.0
