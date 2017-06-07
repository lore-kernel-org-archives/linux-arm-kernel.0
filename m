From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed,  7 Jun 2017 08:41:55 +0200
Subject: [PATCH v3 0/3] nvmem: upstream snvs_lpgpr driver
Message-ID: <20170607064158.16422-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
 drivers/nvmem/Kconfig                              |  13 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/snvs_lpgpr.c                         | 143 +++++++++++++++++++++
 5 files changed, 181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
 create mode 100644 drivers/nvmem/snvs_lpgpr.c

-- 
2.11.0
