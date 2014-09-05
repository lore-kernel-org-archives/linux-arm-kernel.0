From: nm@ti.com (Nishanth Menon)
Date: Fri, 5 Sep 2014 15:51:48 -0500
Subject: [PATCH V2 0/3] mfd: palmas: add optional wakeup irq
Message-ID: <1409950311-25236-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

V2 of the series based on review conclusion in
https://patchwork.kernel.org/patch/4743321/

based on v3.17-rc1

Wakeup irq is a interrupt path which is provided by the pinctrl
hardware of certain SoCs such as TI's OMAP family of processors that
generates an interrupt for waking up from deep power saving modes.

Nishanth Menon (3):
  Documentation: dt-bindings: mfd: palmas: Fix example style of i2c
    peripheral
  Documentation: dt-bindings: mfd: palmas: document optional wakeup IRQ
  mfd: palmas: Add support for optional wakeup

 Documentation/devicetree/bindings/mfd/palmas.txt |   22 +++++++-
 drivers/mfd/palmas.c                             |   59 ++++++++++++++++++++++
 include/linux/mfd/palmas.h                       |    2 +
 3 files changed, 82 insertions(+), 1 deletion(-)

Regards,
	Nishanth Menon
-- 
1.7.9.5
