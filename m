From: lho@apm.com (Loc Ho)
Date: Tue, 12 Jan 2016 16:04:57 -0700
Subject: [PATCH 0/3] edac: xgene: Add missing SoC register bus error handling
 and fix CE promotes to UE
Message-ID: <1452639900-30919-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing register bus error handling for SoC and fix an checking
condition for CE error promotes to UE. DT binding and documentation are
also updated.

---
Loc Ho (3):
  Documentation: Update the APM X-Gene SoC EDAC DTS binding with fix to
    the RB
  edac: xgene: Add missing SoC register bus error handling and fix CE
    promotes to UE
  arm64: Update the APM X-Gene EDAC node to the RB register resource

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |    7 ++
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |    6 ++
 drivers/edac/xgene_edac.c                          |   62 +++++++++++++++++++-
 3 files changed, 74 insertions(+), 1 deletions(-)
