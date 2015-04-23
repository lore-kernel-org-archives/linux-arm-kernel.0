From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 23 Apr 2015 15:37:28 -0400
Subject: [PATCH 0/4] ARM: keystone: Enable Netcp driver on K2 EVMs
Message-ID: <1429817852-27938-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NetCP driver support patches are already merged to v4.0.nd v4.1.
This series introduce patches to update the DTS bindings and
defconfig so that the network driver is fully functional on K2
EVMs :- K2HK, K2L and K2E.

It will be great if this can be merged to v4.1.

Murali Karicheri (4):
  ARM: keystone: defconfig: enable netcp driver by default
  ARM: dts: k2hk-evm: Add device bindings for netcp driver
  ARM: dts: k2e-evm: Add device bindings for netcp driver
  ARM: dts: k2l-evm: Add device bindings for netcp driver

 arch/arm/boot/dts/k2e-evm.dts       |    1 +
 arch/arm/boot/dts/k2e-netcp.dtsi    |  206 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2e.dtsi          |    1 +
 arch/arm/boot/dts/k2hk-evm.dts      |    1 +
 arch/arm/boot/dts/k2hk-netcp.dtsi   |  208 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2hk.dtsi         |    1 +
 arch/arm/boot/dts/k2l-evm.dts       |    1 +
 arch/arm/boot/dts/k2l-netcp.dtsi    |  189 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2l.dtsi          |    1 +
 arch/arm/configs/keystone_defconfig |    6 +
 10 files changed, 615 insertions(+)
 create mode 100644 arch/arm/boot/dts/k2e-netcp.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk-netcp.dtsi
 create mode 100644 arch/arm/boot/dts/k2l-netcp.dtsi

-- 
1.7.9.5
