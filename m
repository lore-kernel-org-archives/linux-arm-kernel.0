From: linux@rempel-privat.de (Oleksij Rempel)
Date: Fri, 28 Nov 2014 17:50:52 +0100
Subject: [PATCH 0/2] suport for Alphascale ASM9260, part 3
In-Reply-To: <201411281509.19170.arnd@arndb.de>
References: <201411281509.19170.arnd@arndb.de>
Message-ID: <1417193454-31417-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oleksij Rempel (2):
  ARM: irqchip: mxs: prepare driver for HW with different offsets
  ARM: irqchip: mxs: add Alpascale ASM9260 support

 drivers/irqchip/Kconfig                    |   5 +
 drivers/irqchip/Makefile                   |   2 +-
 drivers/irqchip/alphascale_asm9260-icoll.h | 109 +++++++++++++++++++++
 drivers/irqchip/irq-mxs.c                  | 150 ++++++++++++++++++++++++++---
 4 files changed, 249 insertions(+), 17 deletions(-)
 create mode 100644 drivers/irqchip/alphascale_asm9260-icoll.h

-- 
1.9.1
