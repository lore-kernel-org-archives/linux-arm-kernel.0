From: rric@kernel.org (Robert Richter)
Date: Sun,  3 May 2015 22:49:28 +0200
Subject: [PATCH 0/4] arm64: gicv3: its: Fixes and updates for ThunderX
Message-ID: <1430686172-18222-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch series adds fixes and updates for ThunderX.

Patches are unrelated each other and can be applied individually.


Radha Mohan Chintakuntla (1):
  arm64: gicv3: its: Increase FORCE_MAX_ZONEORDER for Cavium ThunderX

Robert Richter (2):
  arm64: gicv3: its: Add range check for number of allocated pages
  arm64: gicv3: its: Read typer register outside the loop

Tirumalesh Chalamarla (1):
  arm64: gicv3: its: Encode domain number in PCI stream id

 arch/arm64/Kconfig                 |  1 +
 drivers/irqchip/irq-gic-v3-its.c   | 18 +++++++++++++-----
 include/linux/irqchip/arm-gic-v3.h |  1 +
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.1.1
