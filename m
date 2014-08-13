From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 13 Aug 2014 17:34:30 +0200
Subject: [PATCH 0/5] phy: miphy28lp: Introduce support for MiPHY28lp
Message-ID: <1407944075-8093-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

The goal of this series is to add the support of MiPHY28lp Generic PHY.
I tried to be as close as possible to the MiPHY365x Lee Jones proposal.

Best Regards
Gabriel.

Gabriel Fernandez (5):
  phy: miphy28lp: Add Device Tree bindings for the MiPHY28lp
  phy: miphy28lp: Add MiPHY28lp header file for DT x Driver defines
  phy: miphy28lp: Provide support for the MiPHY28lp Generic PHY
  ARM: DT: STi: STiH407: Add DT node for MiPHY28lp
  ARM: multi_v7_defconfig: Enable MiPHY28lp - ST's Generic (SATA, PCIe &
    USB3) PHY

 .../devicetree/bindings/phy/phy-miphy28lp.txt      | 126 ++++
 arch/arm/boot/dts/stih407-b2120.dts                |  11 +
 arch/arm/boot/dts/stih407.dtsi                     |  65 ++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-miphy28lp.c                        | 736 +++++++++++++++++++++
 include/dt-bindings/phy/phy-miphy28lp.h            |  12 +
 8 files changed, 960 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
 create mode 100644 drivers/phy/phy-miphy28lp.c
 create mode 100644 include/dt-bindings/phy/phy-miphy28lp.h

-- 
1.9.1
