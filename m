From: marek@goldelico.com (Marek Belisko)
Date: Tue, 30 Sep 2014 22:17:31 +0200
Subject: [PATCH 0/3] input: tsc2007: Extend for pre-calibration,
 flipping and rotation
Message-ID: <1412108254-19234-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following series add support to tsc2007 touchscreen driver for pre-calibration,
flipping and rotation. Added bindings are documented and used in gta04 device tree.

Marek Belisko (3):
  input: tsc2007: Add pre-calibration, flipping and rotation
  Documentation: dt: input: tsc2007: Document new parameters
  arm: dts: omap3-gta04: Extend touchscreen configs

 .../bindings/input/touchscreen/tsc2007.txt         | 17 ++++-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  6 ++
 drivers/input/touchscreen/tsc2007.c                | 89 +++++++++++++++++++++-
 include/linux/i2c/tsc2007.h                        |  6 ++
 4 files changed, 111 insertions(+), 7 deletions(-)

-- 
1.9.3
