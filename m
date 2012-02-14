From: kumarrav@codeaurora.org (Ravi Kumar V)
Date: Tue, 14 Feb 2012 14:50:56 +0530
Subject: [PATCH] Add support for MSM GPIO IR receiver driver
Message-ID: <1329211256-12896-1-git-send-email-kumarrav@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is for GPIO based IR receivers, it can listen only to IR receiver 
modules which gives demodulated signal as output, this driver only passes the 
interrupt events to rc framework where pulse and space widths are calculated 
and input to decoders avaliable.

Ravi Kumar V (1):
  msm: rc: Add support for MSM GPIO based IR Receiver driver.

 drivers/media/rc/Kconfig        |    9 ++
 drivers/media/rc/Makefile       |    1 +
 drivers/media/rc/gpio-ir-recv.c |  189 +++++++++++++++++++++++++++++++++++++++
 include/media/gpio-ir-recv.h    |   23 +++++
 4 files changed, 222 insertions(+), 0 deletions(-)
 create mode 100644 drivers/media/rc/gpio-ir-recv.c
 create mode 100644 include/media/gpio-ir-recv.h

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
