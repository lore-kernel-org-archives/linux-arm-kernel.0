From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 29 Mar 2016 12:57:30 +0530
Subject: [PATCH 0/4] Few more updates for NS2 DT
Message-ID: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset primarily adds more PL330 and PL022 DT nodes for
NS2 SVK. It also moves clock DT nodes to separate file to be
consistent with other Broadcom SoCs DT files.

The patchset is based on v4.6-rc1 tag and is available in ns2_dt3_v1
branch of https://github.com/Broadcom/arm64-linux.git

All patches have been tested on Broadcom NS2 SVK.

Anup Patel (4):
  arm64: dts: Add ARM PL330 DMA DT node for NS2
  arm64: dts: Add maintenance interrupt for GIC in NS2 DT
  arm64: dts: Move NS2 clock DT nodes to separate DT file
  arm64: dts: Add ARM PL022 SPI DT nodes for NS2

 arch/arm64/boot/dts/broadcom/ns2-clock.dtsi | 105 +++++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts    |  45 ++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi       | 124 +++++++++++-----------------
 3 files changed, 196 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-clock.dtsi

-- 
1.9.1
