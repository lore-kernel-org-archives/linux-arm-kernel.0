From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:31:09 +0800
Subject: [PATCH 0/3] AT91 pm cleanup for 3.21
Message-ID: <1423708269-7750-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch series purpose is to clean up the PM code.

Wenyou Yang (3):
  pm: at91: pm_slowclock: remove the unused code related with
    SLOWDOWN_MASTER_CLOCK
  ARM: at91: move "select SRAM" under SOC_AT91SAM9 and SOC_SAMA5
  pm: at91: remove CONFIG_AT91_SLOW_CLOCK config option

 arch/arm/mach-at91/Kconfig        |   17 +++--------------
 arch/arm/mach-at91/Makefile       |    2 +-
 arch/arm/mach-at91/pm.c           |   12 +-----------
 arch/arm/mach-at91/pm_slowclock.S |   37 -------------------------------------
 4 files changed, 5 insertions(+), 63 deletions(-)

-- 
1.7.9.5
