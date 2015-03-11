From: carlo@caione.org (Carlo Caione)
Date: Wed, 11 Mar 2015 10:00:28 +0100
Subject: [PATCH v2 0/2] Amlogic Meson8b pinctrl driver support
Message-ID: <1426064430-5826-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Two patches to extend the pinctrl driver to support AmLogic Meson8b SoCs fixing
the existing documentation.

Changelog:

v2: * fix holes in GPIOs numbering
v1: * initial version

Carlo Caione (2):
  pinctrl: Add support for Meson8b
  documentation: Fix pinctrl docs for Meson8b

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |    2 +-
 drivers/pinctrl/meson/Makefile                     |    2 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |    4 +
 drivers/pinctrl/meson/pinctrl-meson.h              |    1 +
 drivers/pinctrl/meson/pinctrl-meson8b.c            | 1013 ++++++++++++++++++++
 include/dt-bindings/gpio/meson8b-gpio.h            |   31 +
 6 files changed, 1051 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson8b.c
 create mode 100644 include/dt-bindings/gpio/meson8b-gpio.h

-- 
1.9.1
