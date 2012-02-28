From: jtzhou@marvell.com (Jett.Zhou)
Date: Tue, 28 Feb 2012 10:57:49 +0800
Subject: [V4 0/4] patches for power control on pm8606 oscillator
Message-ID: <1330397869-31644-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change log:
V4:
1 seperated the mfd power control osc patch for more clear.

Jett.Zhou (4):
  mfd: add power control interface for pm8606 chip
  mfd: code clean for pm8606 sub-dev initialization
  backlight: modified power control of pm860x backlight
  led: modified power control of pm860x led

 drivers/leds/leds-88pm860x.c          |   23 +++++++
 drivers/mfd/88pm860x-core.c           |  108 +++++++++++++++++++++++++++++++-
 drivers/video/backlight/88pm860x_bl.c |   49 +++++++++------
 include/linux/mfd/88pm860x.h          |   22 +++++++
 4 files changed, 177 insertions(+), 25 deletions(-)
