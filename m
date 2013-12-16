From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 16 Dec 2013 18:39:36 +0200
Subject: [PATCH 0/4] ARM: keystone: enable GPIO support
Message-ID: <1387211981-26045-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds Keystone GPIO IP definition in DT and enable GPIO support in
Keystone configuration file.

Also, it enables LEDs support for Keystone 2 K2H EVM as specified in board 
schematic. For more information see:
- http://www.advantech.com/Support/TI-EVM/EVMK2HX.aspx 

Depends on:
[PATCH 0/2] gpio: davinci: reuse for keystone arch
- https://lkml.org/lkml/2013/12/12/366

Grygorii Strashko (4):
  arm: dts: keystone: add GPIO device entry
  ARM: keystone_defconfig: enable gpio support
  arm: dts: keystone-evm: add LEDs supports
  ARM: keystone_defconfig: enable LED support

 arch/arm/boot/dts/k2hk-evm.dts      |   23 ++++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi     |   45 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/keystone_defconfig |   11 +++++++++
 3 files changed, 79 insertions(+)

-- 
1.7.9.5
