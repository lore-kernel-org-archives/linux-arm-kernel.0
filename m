From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Fri, 26 Oct 2018 09:46:58 +0000
Subject: [PATCH V2 0/4] ARM: dts: imx: Add flexcan stop mode wakeup
Message-ID: <20181026094444.25305-1-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset intends to add flexcan stop mode wakeup support on IMX6/7
platforms.

ChangeLog:
V1->V2:
	*update stop mode property(stop-mode -> fsl,stop-mode).

Dong Aisheng (4):
  ARM: dts: imx6sx: Add flexcan stop mode wakeup support
  ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
  ARM: dts: imx6ul: Add flexcan stop mode wakeup support
  ARM: dts: imx7s: Add flexcan stop mode wakeup support

 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 arch/arm/boot/dts/imx6sx.dtsi  | 2 ++
 arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
 arch/arm/boot/dts/imx7s.dtsi   | 2 ++
 4 files changed, 8 insertions(+)

-- 
2.17.1
