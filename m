From: vigneshr@ti.com (Vignesh R)
Date: Thu, 23 Jul 2015 20:24:04 +0530
Subject: [PATCH v3 0/2] pixcir_i2c_ts: Add optional wakeup irq support
Message-ID: <1437663246-16049-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



This is the v3 of the patch series to add optional wake irq support for
pixcir_i2c_tsc.

Tested on am437x-gp-evm, with some out of tree patches to support
suspend/resume on am437x.


Vignesh R (2):
  input: touchscreen: pixcir_i2c_ts: Add support for optional wakeup
    interrupt
  ARM: dts: am437x-gp-evm: Add wakeup interrupt source for
    pixcir_i2c_tsc

 arch/arm/boot/dts/am437x-gp-evm.dts       |  4 ++++
 drivers/input/touchscreen/pixcir_i2c_ts.c | 22 ++++++++++++++++++----
 include/linux/input/pixcir_ts.h           |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.4.5
