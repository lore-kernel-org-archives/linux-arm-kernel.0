From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 25 Jul 2012 17:53:30 +0530
Subject: [PATCH v2 0/2] Add D_CAN device tree data to AM335x-EVM
Message-ID: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thid patch series adds device tree data to AM335x-EVM file and
adds pinmux settings required to configure two of the AM335x EVM
pins to D_CAN TX/RX pins.

Changes from v1:
	- These two patches separated from c_can DT support
	  patch series.

AnilKumar Ch (2):
  arm/dts: AM33XX: Add D_CAN device tree data
  arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on AM335x-EVM

 arch/arm/boot/dts/am335x-evm.dts |   13 +++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |    5 +++++
 2 files changed, 18 insertions(+)

-- 
1.7.9.5
