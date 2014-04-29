From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Apr 2014 08:21:30 +0100
Subject: [PATCH 0/4] phy: Introduce support for MiPHY365x
Message-ID: <1398756095-32542-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Here is the MiPHY365x patchset complete with all the DT Acks applied.

This set has been on the list for ~10 weeks now with no further comments.

Would you be kind enough to merge the PHY patches/documentation please?

Kind regards,
Lee

 Documentation/devicetree/bindings/phy/phy-miphy365x.txt |  62 +++++++++++
 arch/arm/boot/dts/stih416-b2020-revE.dts                |   6 +-
 arch/arm/boot/dts/stih416-b2020.dts                     |   6 ++
 arch/arm/boot/dts/stih416.dtsi                          |  14 +++
 drivers/phy/Kconfig                                     |  10 ++
 drivers/phy/Makefile                                    |   1 +
 drivers/phy/phy-miphy365x.c                             | 630 ++++++++++++++++++++++
 include/dt-bindings/phy/phy-miphy365x.h                 |  25 +++++
 8 files changed, 753 insertions(+), 1 deletion(-)
