From: abailon@baylibre.com (Alexandre Bailon)
Date: Thu, 27 Oct 2016 17:32:35 +0200
Subject: [PATCH v4] Remove duplicated defines (was [PATCH v3] Fix some
 potential warnings)
Message-ID: <1477582356-28156-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated defines before they cause warning.

Change in V2:
Update the d830 evm board file to use the da8xx-cfgchip.h
These changes are required as I'm sending this patch apart from
the series "[PATCH/RFT v2 00/17] Add DT support for ohci-da8xx"

Changes in v3:
* Change the patch description to better respect what the patch fix.
* Sorted new header sorted in alphabetical order.

Alexandre Bailon (1):
  ARM: davinci: da8xx: Remove duplicated defines

 arch/arm/mach-davinci/board-da830-evm.c     |  5 +++--
 arch/arm/mach-davinci/board-omapl138-hawk.c |  3 ++-
 include/linux/platform_data/usb-davinci.h   | 23 -----------------------
 3 files changed, 5 insertions(+), 26 deletions(-)

-- 
2.7.3
