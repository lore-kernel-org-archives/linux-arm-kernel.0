From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu,  8 Jan 2015 10:07:21 +0100
Subject: [PATCH] clocksource driver for Alphascale asm9260
In-Reply-To: <1417193657-31602-2-git-send-email-linux@rempel-privat.de>
References: <1417193657-31602-2-git-send-email-linux@rempel-privat.de>
Message-ID: <1420708042-22906-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
this patch provides clocksource support for Alphascale asm9260 SoC.
As was suggested..., I explicitly ask you to merge this patch :D

Oleksij Rempel (1):
  ARM: clocksource: add asm9260_timer driver

 drivers/clocksource/Kconfig         |   9 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/asm9260_timer.c | 220 ++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/clocksource/asm9260_timer.c

-- 
1.9.1
