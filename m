From: vigneshr@ti.com (Vignesh R)
Date: Tue, 5 Dec 2017 12:18:10 +0530
Subject: [PATCH 0/2] 66AK2G: Add DT entry for UART1 and UART2
Message-ID: <20171205064812.15758-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds DT entry for the remaining two UART instances on 66AK2G
SoC.

Based on linux-next.

Franklin S Cooper Jr (2):
  ARM: dts: keystone-k2g: Add UART 1 and 2 instances
  ARM: dts: keystone-k2g-evm: Enable UART 2

 arch/arm/boot/dts/keystone-k2g-evm.dts | 13 +++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    | 29 ++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.15.0
