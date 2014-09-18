From: nm@ti.com (Nishanth Menon)
Date: Thu, 18 Sep 2014 14:04:43 -0500
Subject: [PATCH V3 0/3] mfd: palmas: add optional wakeup irq
Message-ID: <1411067086-16613-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
V3 update for the previous series:
Changes in V3 (from review updates):
	- Allow driver to function even if wakeirq fails
	- Fix irq flags

V2: http://marc.info/?l=linux-kernel&m=140995041418575&w=2
v1: https://patchwork.kernel.org/patch/4743321/

Nishanth Menon (3):
  Documentation: dt-bindings: mfd: palmas: Fix example style of i2c
    peripheral
  Documentation: dt-bindings: mfd: palmas: document optional wakeup IRQ
  mfd: palmas: Add support for optional wakeup

 Documentation/devicetree/bindings/mfd/palmas.txt |   22 +++++++-
 drivers/mfd/palmas.c                             |   62 ++++++++++++++++++++++
 include/linux/mfd/palmas.h                       |    2 +
 3 files changed, 85 insertions(+), 1 deletion(-)

-- 
1.7.9.5
