From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu,  8 Jan 2015 09:59:26 +0100
Subject: [PATCH] clk support for Alphascale asm9260
In-Reply-To: <1417187120-23659-1-git-send-email-linux@rempel-privat.de>
References: <1417187120-23659-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1420707567-22760-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
this patch provides clk support for Alphascale asm9260 SoC.
As was suggested by one of ARM maintainers, I explicitly ask you to
merge this patch :D

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
