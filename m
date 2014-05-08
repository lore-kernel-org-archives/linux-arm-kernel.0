From: lho@apm.com (Loc Ho)
Date: Thu,  8 May 2014 17:03:15 -0600
Subject: [PATCH 0/4] edac: Add APM X-Gene SoC EDAC driver
Message-ID: <1399590199-12256-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC EDAC driver.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
Loc Ho (4):
  edac: Fix MC scrub mode comparsion bug for correctable error
  Documentation: Add documentation for the APM X-Gene SoC EDAC DTS
    binding
  edac: Add APM X-Gene SoC EDAC driver
  arm64: Add APM X-Gene SoC EDAC DTS entries

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   70 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   89 +
 drivers/edac/Kconfig                               |    9 +-
 drivers/edac/Makefile                              |    3 +
 drivers/edac/edac_mc.c                             |    2 +-
 drivers/edac/xgene_edac.c                          | 1915 ++++++++++++++++++++
 6 files changed, 2086 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
 create mode 100644 drivers/edac/xgene_edac.c
