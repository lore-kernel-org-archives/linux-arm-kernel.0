From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri,  9 Feb 2018 11:05:18 +0100
Subject: [PATCH 0/3] regulator da9062: add and make use of map_mode support
Message-ID: <1518170721-28198-1-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds of_map_mode support to regulator da9062, documents its
bindings and makes use of it in dts phycore-imx6.

Christoph Fritz (3):
  regulator: da9062: add of_map_mode support for bucks
  dt-bindings: regulator: describe da9062's regulator modes
  ARM: dts: phycore-imx6: set buck regulator modes explicitly

 Documentation/devicetree/bindings/mfd/da9062.txt  |  8 ++++++++
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi |  4 ++++
 drivers/regulator/da9062-regulator.c              | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.1.4
