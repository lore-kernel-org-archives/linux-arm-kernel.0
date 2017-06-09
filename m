From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 09 Jun 2017 13:59:11 +0900
Subject: [PATCH 0/3] Add support for the s6e63j0x03 panel on Rinato board
References: <CGME20170609045937epcas5p2120f6388b74fa73ea6ed835f7741f61e@epcas5p2.samsung.com>
Message-ID: <1496984354-5271-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The purpose of this patch is add support for s6e63j0x03 AMOLED panel
on the rinato board(Samsung Galaxy Gear 2).

The first and second patches are Add the binding document and panel
driver. The third patch is remove the unnecessary properties in the
rinato dts.

Best regards,
Hoegeun

Hoegeun Kwon (3):
  dt-bindings: Add support for samsung s6e63j0x03 panel binding
  drm/panel: Add support for s6e63j0x03 panel driver
  ARM: dts: exynos: Remove the display-timing and delay from rinato dts

 .../bindings/display/panel/samsung,s6e63j0x03.txt  |  24 +
 arch/arm/boot/dts/exynos3250-rinato.dts            |  22 -
 drivers/gpu/drm/panel/Kconfig                      |   7 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   | 491 +++++++++++++++++++++
 5 files changed, 523 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c

-- 
1.9.1
