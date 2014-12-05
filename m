From: rjui@broadcom.com (Ray Jui)
Date: Fri, 5 Dec 2014 11:51:05 -0800
Subject: [PATCH v2 0/4] Add pinctrl support to Broadcom Cygnus SoC
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1417809069-26510-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial pinctrl support for the Broadcom Cygnus SoC.
The Cygnus pinctrl controller supports group based alternate function configuration

Changes from v1:
 - Fix a typo in device tree binding document

Ray Jui (4):
  pinctrl: Broadcom Cygnus pinctrl device tree binding
  pinctrl: cygnus: add initial pinctrl support
  ARM: mach-bcm: enable pinctrl support for Cygnus
  ARM: dts: enable pinctrl for Broadcom Cygnus

 .../bindings/pinctrl/brcm,cygnus-pinctrl.txt       |   92 +++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |    5 +
 arch/arm/mach-bcm/Kconfig                          |    1 +
 drivers/pinctrl/Kconfig                            |    7 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-bcm-cygnus.c               |  753 ++++++++++++++++++++
 6 files changed, 859 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-bcm-cygnus.c

-- 
1.7.9.5
