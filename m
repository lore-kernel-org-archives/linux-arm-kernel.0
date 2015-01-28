From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 28 Jan 2015 19:38:58 +0100
Subject: [PATCH 0/5] ARM: at91/dt: add matrix and SMC nodes
Message-ID: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds the matrix and SMC syscon nodes whose registers are needed
by other peripherals (EBI, USB Device).

Best Regards,

Boris

Alexander Stein (2):
  ARM: at91/dt: add matrix node in at91sam9263 dtsi
  ARM: at91/dt: add SMC0/1 nodes in at91sam9263 dtsi

Boris Brezillon (3):
  ARM: at91/dt: fix matrix compatible in at91sam9261.dtsi
  ARM: at91/dt: add SMC and HSMC nodes
  ARM: at91/dt: add matrix nodes

 arch/arm/boot/dts/at91sam9260.dtsi | 10 ++++++++++
 arch/arm/boot/dts/at91sam9261.dtsi |  7 ++++++-
 arch/arm/boot/dts/at91sam9263.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 10 ++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi | 10 ++++++++++
 arch/arm/boot/dts/at91sam9rl.dtsi  | 10 ++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 10 ++++++++++
 arch/arm/boot/dts/sama5d3.dtsi     | 10 ++++++++++
 arch/arm/boot/dts/sama5d4.dtsi     |  5 +++++
 9 files changed, 86 insertions(+), 1 deletion(-)

-- 
1.9.1
