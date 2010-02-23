From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 23 Feb 2010 15:42:58 +0530
Subject: [PATCH 0/4] ux500: u8500 v1 revision, clock gating
Message-ID: <1266919983-32759-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These apply on top of the clkdev_add_table patch and the ux500 patches in
next/rmk-devel.

Rabin Vincent (4):
  ux500: fix CLKRST addresses
  ux500: move system timer to cpu file
  ux500: add support for u8500 v1 revision
  ux500: support clock gating

 arch/arm/mach-ux500/board-mop500.c          |   20 +-
 arch/arm/mach-ux500/clock.c                 |  491 +++++++++++++++++++++++++--
 arch/arm/mach-ux500/clock.h                 |  125 +++++++
 arch/arm/mach-ux500/cpu-u8500.c             |   44 +++-
 arch/arm/mach-ux500/include/mach/hardware.h |   37 ++-
 arch/arm/mach-ux500/include/mach/setup.h    |    3 +
 6 files changed, 657 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm/mach-ux500/clock.h
