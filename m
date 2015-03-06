From: carlo@caione.org (Carlo Caione)
Date: Fri,  6 Mar 2015 16:51:14 +0100
Subject: [PATCH 0/2] Amlogic Meson8b pinctrl driver support
Message-ID: <1425657076-6709-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Two patches to extend the pinctrl driver to support AmLogic Meson8b SoCs fixing
the existing documentation.

Carlo Caione (2):
  pinctrl: Add support for Meson8b
  documentation: Fix pinctrl docs for Meson8b

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |    2 +-
 drivers/pinctrl/meson/Makefile                     |    2 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |    4 +
 drivers/pinctrl/meson/pinctrl-meson.h              |    1 +
 drivers/pinctrl/meson/pinctrl-meson8b.c            | 1009 ++++++++++++++++++++
 include/dt-bindings/gpio/meson8b-gpio.h            |  127 +++
 6 files changed, 1143 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson8b.c
 create mode 100644 include/dt-bindings/gpio/meson8b-gpio.h

-- 
1.9.1
