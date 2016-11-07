From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  7 Nov 2016 22:41:25 +0100
Subject: [PATCH 0/3] Various ARM64 Armada DT warning fixup
Message-ID: <20161107214128.18401-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the series sent for Armada 370/XP, this patchset fixes up
various warning from the DT compiler when using the flag W=1 with
make.

Being a fresh new port, the arm64 we did a better job for dt than for
the arm32 so there is only a few patches needed.

Gregory

Gregory CLEMENT (3):
  arm64: dts: marvell: Fixup internal-regs DT warning for Armada 37xx
  arm64: dts: marvell: Fixup config-space DT warning For Armada 7K/8K
  ARM64: dts: marvell: Fixup memory DT warning for Armada 37xx

 arch/arm64/boot/dts/marvell/armada-3720-db.dts          | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 2 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi           | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi    | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.10.1
