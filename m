From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 29 Oct 2015 13:55:45 +0800
Subject: [RFC PATCH 0/2] ARM: at91/pm: init fast startup signal to the PMC
Message-ID: <1446098147-32487-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to initialize the fast startup signal to the PMC.

The patch is based on patch set:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376493.html


Wenyou Yang (2):
  ARM: at91: pm: init fast startup trigger signals to PMC
  ARM: at91/dt: sama5d2_xplained: add pmc_fast_restart node

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |    8 ++++
 arch/arm/mach-at91/pm.c                     |   60 +++++++++++++++++++++++++++
 include/linux/clk/at91_pmc.h                |   32 ++++++++++++++
 3 files changed, 100 insertions(+)

-- 
1.7.9.5
