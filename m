From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jun 2014 14:01:52 +0100
Subject: [PATCH 0/5] phy: miphy365x: Introduce support for MiPHY365x
Message-ID: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

This submission is the same as the last one, only each channel is
now represented by its own sub-node.  The documentation has also
been updated accordingly.

Kind regards,
Lee

 .../devicetree/bindings/phy/phy-miphy365x.txt      |  76 +++
 arch/arm/boot/dts/stih416-b2020-revE.dts           |   5 +
 arch/arm/boot/dts/stih416-b2020.dts                |   7 +
 arch/arm/boot/dts/stih416.dtsi                     |  21 +
 drivers/phy/Kconfig                                |  10 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-miphy365x.c                        | 676 +++++++++++++++++++++
 include/dt-bindings/phy/phy-miphy365x.h            |  25 +
 8 files changed, 821 insertions(+)
