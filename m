From: zhouqiao@marvell.com (Qiao Zhou)
Date: Wed, 13 Jun 2012 17:04:08 +0800
Subject: [PATCH 0/3 V0] add 88pm80x mfd driver
Message-ID: <1339578251-15009-1-git-send-email-zhouqiao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add 88pm80x mfd driver, and also add sub-device: rtc and onkey.
would add below sub device later: regulator, headset detect
codec.

Qiao Zhou (3):
  mfd: support 88pm80x in 80x driver
  rtc: add rtc support to 88PM80X PMIC
  input: add onkey support to 88PM80X PMIC

 drivers/input/misc/88pm80x_onkey.c |  217 ++++++++
 drivers/input/misc/Kconfig         |   10 +
 drivers/input/misc/Makefile        |    1 +
 drivers/mfd/88pm80x-core.c         | 1002 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/88pm80x-i2c.c          |  370 +++++++++++++
 drivers/mfd/Kconfig                |   11 +
 drivers/mfd/Makefile               |    2 +
 drivers/rtc/Kconfig                |   10 +
 drivers/rtc/Makefile               |    1 +
 drivers/rtc/rtc-88pm80x.c          |  370 +++++++++++++
 include/linux/mfd/88pm80x.h        |  701 +++++++++++++++++++++++++
 11 files changed, 2695 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/88pm80x_onkey.c
 create mode 100644 drivers/mfd/88pm80x-core.c
 create mode 100644 drivers/mfd/88pm80x-i2c.c
 create mode 100644 drivers/rtc/rtc-88pm80x.c
 create mode 100644 include/linux/mfd/88pm80x.h

-- 
1.7.4.1
