From: nm@ti.com (Nishanth Menon)
Date: Tue, 22 Sep 2015 11:08:35 -0500
Subject: [PATCH 0/3] ARM: dts/keystone: Introduce SoC specific compatible
 matches
Message-ID: <1442938118-4718-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Here is a series that introduces keystone SoC specific compatible flags

Series based on v4.3-rc1.

Test log(merge on master): http://paste.ubuntu.org.cn/3462285 (note
netcp seems to freezeup after a while into boot. debug not complete on
that yet - boots fine with a minimal system..)

Nishanth Menon (3):
  Documentation: dt: keystone: provide SoC specific compatible flags
  ARM: keystone: Update compatible to have SoC specific matches
  ARM: dts: keystone: Update SoC specific compatible flags

 .../devicetree/bindings/arm/keystone/keystone.txt    | 20 +++++++++++++++++---
 arch/arm/boot/dts/k2e-evm.dts                        |  2 +-
 arch/arm/boot/dts/k2e.dtsi                           |  3 +++
 arch/arm/boot/dts/k2hk-evm.dts                       |  2 +-
 arch/arm/boot/dts/k2hk.dtsi                          |  3 +++
 arch/arm/boot/dts/k2l-evm.dts                        |  2 +-
 arch/arm/boot/dts/k2l.dtsi                           |  3 +++
 arch/arm/boot/dts/keystone.dtsi                      |  1 +
 arch/arm/mach-keystone/keystone.c                    |  3 +++
 9 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.1.4
