From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Mar 2016 08:59:10 +0900
Subject: [PATCH 00/12] ARM, arm64: dts: use generic pinctrl properties
Message-ID: <1458259162-15706-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This series updates the device trees for the boards of Renesas ARM based
SoCs to use the generic properties. The device tree for the lager board was
already updated in an earlier patch which is present in
renesas-devel-20160318-v4.5.

Based on renesas-devel-20160318-v4.5

Simon Horman (12):
  ARM: dts: ape6evm: use generic pinctrl properties
  ARM: dts: armadillo800eva: use generic pinctrl properties
  ARM: dts: bockw: use generic pinctrl properties
  ARM: dts: marzen: use generic pinctrl properties
  ARM: dts: koelsch: use generic pinctrl properties
  ARM: dts: porter: use generic pinctrl properties
  ARM: dts: gose: use generic pinctrl properties
  ARM: dts: alt: use generic pinctrl properties
  ARM: dts: silk: use generic pinctrl properties
  ARM: dts: kzm9g: use generic pinctrl properties
  ARM: dts: kzm9d: use generic pinctrl properties
  arm64: dts: salvator-x: use generic pinctrl properties

 arch/arm/boot/dts/emev2-kzm9d.dts                  |  4 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              | 20 +++----
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      | 34 +++++------
 arch/arm/boot/dts/r8a7778-bockw.dts                | 40 ++++++-------
 arch/arm/boot/dts/r8a7779-marzen.dts               | 36 ++++++------
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 68 +++++++++++-----------
 arch/arm/boot/dts/r8a7791-porter.dts               | 60 +++++++++----------
 arch/arm/boot/dts/r8a7793-gose.dts                 | 40 ++++++-------
 arch/arm/boot/dts/r8a7794-alt.dts                  | 32 +++++-----
 arch/arm/boot/dts/r8a7794-silk.dts                 | 44 +++++++-------
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 | 30 +++++-----
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 46 +++++++--------
 12 files changed, 227 insertions(+), 227 deletions(-)

-- 
2.1.4
