From: nm@ti.com (Nishanth Menon)
Date: Sat, 3 Oct 2015 18:38:47 -0500
Subject: [PATCH V2 0/3] ARM: dts/keystone: Introduce SoC specific compatible
 matches
In-Reply-To: <1442938118-4718-1-git-send-email-nm@ti.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
Message-ID: <1443915530-15035-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Round 2 of the series with updated patch #1. This series introduces
SoC specific dt compatible property to allow for future SoCs to be
handled and for userspace applications that can introduce features
based on SoC they are functioning on.

V1 of the series: http://marc.info/?l=devicetree&m=144309031109988&w=2
V2 of the series has the following changes:
	- updated commit message in patch #1
	- picked up acked-by for patch #1

Series based on v4.3-rc1

Tested on v4.3-rc3: http://pastebin.ubuntu.com/12659000/

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
