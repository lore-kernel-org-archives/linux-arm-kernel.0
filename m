From: lho@apm.com (Loc Ho)
Date: Fri, 29 May 2015 16:04:32 -0600
Subject: [PATCH 0/3] edac: Add L3/SoC support to the APM X-Gene SoC EDAC driver
Message-ID: <1432937075-16558-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v1:
* Add L3/SoC support to the APM X-Gene SoC EDAC driver

---
Loc Ho (3):
  Documentation: Update the APM X-Gene SoC EDAC DTS binding for L3/SoC
    subnodes
  edac: Add L3/SoC support to the APM X-Gene SoC EDAC driver
  arm64: Add L3/SoC DT subnodes to the APM X-Gene SoC EDAC node

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   18 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   10 +
 drivers/edac/xgene_edac.c                          |  746 +++++++++++++++++++-
 3 files changed, 773 insertions(+), 1 deletions(-)
