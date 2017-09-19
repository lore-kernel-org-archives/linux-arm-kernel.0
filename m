From: vigneshr@ti.com (Vignesh R)
Date: Tue, 19 Sep 2017 11:45:48 +0530
Subject: [RESEND PATCH 0/3] K2G: Add support for PWM ECAP
Message-ID: <20170919061551.11981-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds support for TI ECAP PWM IP present in 66AK2G SoC.
Resending based on today's linux-next.


Vignesh R (3):
  ARM: dts: keystone-k2g: Add ECAP PWM DT nodes
  ARM: dts: keystone-k2g-evm: Enable PWM ECAP0
  ARM: configs: keystone: Enable TIECAP PWM driver

 arch/arm/boot/dts/keystone-k2g-evm.dts | 12 ++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    | 20 ++++++++++++++++++++
 arch/arm/configs/keystone_defconfig    |  2 ++
 3 files changed, 34 insertions(+)

-- 
2.14.1
