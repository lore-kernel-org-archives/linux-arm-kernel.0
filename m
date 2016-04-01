From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  1 Apr 2016 16:16:12 +0200
Subject: [PATCH 0/2] reset: Add support for Oxford Semiconductor Reset
Message-ID: <1459520174-12897-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset includes support for the reset controller driver for
Oxford Semiconductor OXNAS SoC Family.

It was originally posted part of a platform patchset available here :
http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

Changes this v3 patchset :
- Get rid of PLX Technology, replace by Oxford Semiconductor

Neil Armstrong (2):
  reset: Add Oxford Semiconductor Reset Controller driver
  dt-bindings: Add Oxford Semiconductor Reset Controller bindings

 .../devicetree/bindings/reset/oxnas,reset.txt      |  58 +++++++++
 drivers/reset/Kconfig                              |   3 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-oxnas.c                        | 136 +++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/oxnas,reset.txt
 create mode 100644 drivers/reset/reset-oxnas.c

-- 
1.9.1
