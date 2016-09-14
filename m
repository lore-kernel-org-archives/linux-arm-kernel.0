From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed, 14 Sep 2016 10:23:29 +0200
Subject: [PATCH v3 0/6] ARM: dts: bcm283x: add and use pinctrl groups
Message-ID: <1473841415-937-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

New in v3: Fixes in patch #2 (dpi name, drop changelog from commit
message) and patch #5 (drop unused alt3 group), the other patches are
unmodified.

cheers,
  Gerd

Eric Anholt (1):
  ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.

Gerd Hoffmann (5):
  pinctrl: bcm2835: add pull defines to dt bindings
  ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio

 arch/arm/boot/dts/bcm2835-rpi.dtsi    |  15 ++-
 arch/arm/boot/dts/bcm283x.dtsi        | 203 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c |   6 -
 include/dt-bindings/pinctrl/bcm2835.h |   5 +
 4 files changed, 217 insertions(+), 12 deletions(-)

-- 
1.8.3.1
