From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 23 Apr 2014 11:41:02 +0530
Subject: [PATCH 0/2] OMAP2+: optional clock handling fixes
Message-ID: <1398233465-8845-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches fix some opt clock handling in gpio and in
hwmod.

Rajendra Nayak (2):
  gpio: omap: prepare and unprepare the debounce clock
  ARM: OMAP2+: hwmod: Don't leave the optional clocks in
    clk_prepare()ed state

 arch/arm/mach-omap2/omap_hwmod.c |   13 ++-----------
 drivers/gpio/gpio-omap.c         |   10 +++++-----
 2 files changed, 7 insertions(+), 16 deletions(-)

-- 
1.7.9.5
