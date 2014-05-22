From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 14:53:35 +0100
Subject: [RESEND 0/4] phy: Introduce support for MiPHY365x
Message-ID: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

As requested, please find the patches to be applied to your v3.16
pull-request.

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
