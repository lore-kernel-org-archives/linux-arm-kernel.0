From: s-anna@ti.com (Suman Anna)
Date: Wed, 11 Jan 2017 19:48:38 -0600
Subject: [PATCH v2 0/5] Reset Controller Nodes for TI Keystone platforms
Message-ID: <20170112014843.19569-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

This is a slightly updated patch series for the reset controller nodes for
TI Keystone2 SoCs. The only change is to rename the reset controller nodes
from "psc-reset-controller" to just "reset-controller" following Rob Herring's
comment on the Documentation update patch [1]. There are no changes to the first
2 patches. I have already posted a v2 for the Documentation update as well.
Please pick this up instead of the v1 series [2].

regards
Suman

[1] https://www.spinics.net/lists/arm-kernel/msg553646.html
[2] https://www.spinics.net/lists/arm-kernel/msg552911.html


Suman Anna (5):
  ARM: Keystone: Enable ARCH_HAS_RESET_CONTROLLER
  ARM: dts: keystone: Add PSC node
  ARM: dts: keystone-k2hk: Add PSC reset controller node
  ARM: dts: keystone-k2l: Add PSC reset controller node
  ARM: dts: keystone-k2e: Add PSC reset controller node

 arch/arm/boot/dts/keystone-k2e.dtsi  | 13 +++++++++++++
 arch/arm/boot/dts/keystone-k2hk.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2l.dtsi  | 16 ++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi      |  5 +++++
 arch/arm/mach-keystone/Kconfig       |  1 +
 5 files changed, 55 insertions(+)

-- 
2.10.2
