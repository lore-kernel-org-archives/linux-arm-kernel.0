From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 24 Feb 2012 10:54:23 +0800
Subject: [V3 0/3] patches for power control on pm8606 oscillator
Message-ID: <1330052063-12170-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change log:
V3:
1 fix build error;

Jett.Zhou (3):
  mfd: add power control interface for pm8606 chip
  backlight: modified power control of pm860x backlight
  led: modified power control of pm860x led

 drivers/leds/leds-88pm860x.c          |   23 +++++++
 drivers/mfd/88pm860x-core.c           |  108 +++++++++++++++++++++++++++++++-
 drivers/video/backlight/88pm860x_bl.c |   49 +++++++++------
 include/linux/mfd/88pm860x.h          |   22 +++++++
 4 files changed, 177 insertions(+), 25 deletions(-)
