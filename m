From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 15 Dec 2017 11:16:41 -0600
Subject: [PATCH 0/2] ARM: dts: Some am43x fixes
Message-ID: <20171215171643.8345-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This series has two fixes for am43x based platforms. First patch disables OPP50
on am437x-idk-evm which the board supply does not support. Second patch is for
am43x-epos-evm and adds dcdc2 regulator as the missing cpu0-supply which
enables CPUFreq on this platform.

Regards,
Dave

Dave Gerlach (2):
  ARM: dts: am437x-idk-evm: Disable OPP50 for MPU
  ARM: dts: am43x-epos-evm: Hook dcdc2 as the cpu0-supply

 arch/arm/boot/dts/am437x-idk-evm.dts | 14 ++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts |  4 ++++
 2 files changed, 18 insertions(+)

-- 
2.15.1
