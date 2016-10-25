From: abailon@baylibre.com (Alexandre Bailon)
Date: Tue, 25 Oct 2016 14:11:31 +0200
Subject: [PATCH v2] Fix some potential warnings
Message-ID: <1477397492-7925-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some changes I'm working on causes some warning because two included
headers defines the same macros.

Change in V2:
Update the d830 evm board file to use the da8xx-cfgchip.h
These changes are required as I'm sending this patch apart from
the series "[PATCH/RFT v2 00/17] Add DT support for ohci-da8xx"

Alexandre Bailon (1):
  ARM: davinci: da8xx: Fix some redefined symbol warnings

 arch/arm/mach-davinci/board-da830-evm.c   |  3 ++-
 include/linux/platform_data/usb-davinci.h | 23 -----------------------
 2 files changed, 2 insertions(+), 24 deletions(-)

-- 
2.7.3
