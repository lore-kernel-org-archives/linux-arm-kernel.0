From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 24 Feb 2012 10:29:36 +0800
Subject: [V2 0/3] patches for power control on pm8606 oscillator
Message-ID: <1330050576-8841-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Samuel
change log:
V2:
	1 remove the unneeded "do /while" for being readable;
	2 keep the blank line for coding style;

Jett.Zhou (3):
  mfd: add power control interface for pm8606 chip
  backlight: modified power control of pm860x backlight
  led: modified power control of pm860x led

 drivers/leds/leds-88pm860x.c          |   23 +++++++
 drivers/mfd/88pm860x-core.c           |  106 +++++++++++++++++++++++++++++++-
 drivers/video/backlight/88pm860x_bl.c |   49 +++++++++-------
 include/linux/mfd/88pm860x.h          |   22 +++++++
 4 files changed, 175 insertions(+), 25 deletions(-)
