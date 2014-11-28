From: linux@rempel-privat.de (Oleksij Rempel)
Date: Fri, 28 Nov 2014 16:05:19 +0100
Subject: [PATCH] suport for Alphascale ASM9260, part 2
In-Reply-To: <201411281509.19170.arnd@arndb.de>
References: <201411281509.19170.arnd@arndb.de>
Message-ID: <1417187120-23659-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it is secong logical part of ASM9260 patch set.

Oleksij Rempel (1):
  ARM: clk: add clk-asm9260 driver

 drivers/clk/Makefile                           |   1 +
 drivers/clk/clk-asm9260.c                      | 359 +++++++++++++++++++++++++
 include/dt-bindings/clock/alphascale,asm9260.h |  97 +++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/clk/clk-asm9260.c
 create mode 100644 include/dt-bindings/clock/alphascale,asm9260.h

-- 
1.9.1
