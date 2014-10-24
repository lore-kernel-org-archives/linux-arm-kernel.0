From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 24 Oct 2014 10:23:42 +0530
Subject: [PATCH V3 0/3] rtc: omap: Add support for regulator supply
Message-ID: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for regulator supply.

Changes since v2:
 - Rebased on top of Johan Hovold's recent rtc cleanup series[1]
 - Addressed Johan Hovold's comments.

[1] https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg748519.html

Lokesh Vutla (2):
  rtc: omap: use module_platform_driver
  rtc: omap: Support regulator supply for RTC

Tero Kristo (1):
  rtc: omap: Update Kconfig for OMAP RTC

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  3 +++
 drivers/rtc/Kconfig                                |  6 ++---
 drivers/rtc/rtc-omap.c                             | 30 +++++++++++++++++++---
 3 files changed, 33 insertions(+), 6 deletions(-)

-- 
1.9.1
