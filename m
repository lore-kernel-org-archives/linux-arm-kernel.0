From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Jul 2014 12:41:09 +0100
Subject: [PATCH v3 0/5] phy: miphy365x: Introduce support for MiPHY365x
Message-ID: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

This patchset is based on the two core patches you sent to the
list which facilitate creating PHYs residing on multi-channel
controllers.  The changes since the last submission centre
around dynamic PHY creation based solely on what is provided via
Device Tree, as requested.  The other review comments have also
been addressed in this set.

Kind regards,
Lee

 .../devicetree/bindings/phy/phy-miphy365x.txt      |  76 +++
 arch/arm/boot/dts/stih416-b2020-revE.dts           |  10 +
 arch/arm/boot/dts/stih416-b2020.dts                |  12 +
 arch/arm/boot/dts/stih416.dtsi                     |  22 +
 drivers/phy/Kconfig                                |  10 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-miphy365x.c                        | 636 +++++++++++++++++++++
 include/dt-bindings/phy/phy-miphy365x.h            |  14 +
 8 files changed, 781 insertions(+)
