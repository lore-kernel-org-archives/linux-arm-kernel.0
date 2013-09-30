From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 30 Sep 2013 11:49:34 +0200
Subject: [PATCH 0/3] v7-M support using MULTIPLATFORM
Message-ID: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series makes it possible to benefit from the MULTIPLATFORM stuff
also for my v7-M machine (that is not yet supported in mainline).

Best regards
Uwe

Uwe Kleine-K?nig (3):
  ARM: drop !ARCH_MULTIPLATFORM dependency of XIP_KERNEL
  ARM: allow MULTIPLATFORM on no-MMU machines
  [RFC] ARM: prepare ARMv7-M for MULTIPLATFORM use

 arch/arm/Kconfig            | 16 ++++++++++------
 arch/arm/kernel/entry-v7m.S |  6 ++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

-- 
1.8.4.rc3
