From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 23 Aug 2018 14:42:59 +0100
Subject: [PATCH 0/9] Add more support for r8a774a1
Message-ID: <1535031788-19907-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

This series adds SDHI, I2C, IIC, Thermal, IPMMU, MSIOF, A53, PWM,
Audio and FCP support to the r8a774a1 SoC dtsi.

There is a dependency with:
https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg30528.html

Thanks,
Fab

Biju Das (5):
  arm64: dts: renesas: r8a774a1: Add I2C and IIC-DVFS support
  arm64: dts: renesas: r8a774a1: Add RZ/G2M thermal support
  arm64: dts: renesas: r8a774a1: Add all MSIOF nodes
  arm64: dts: renesas: r8a774a1: Add Cortex-A53 CPU cores
  arm64: dts: renesas: r8a774a1: Add audio support

Fabrizio Castro (4):
  arm64: dts: renesas: r8a774a1: Add SDHI nodes
  arm64: dts: renesas: r8a774a1: Add IPMMU device nodes
  arm64: dts: renesas: r8a774a1: Add PWM device nodes
  arm64: dts: renesas: r8a774a1: Add FCPF and FCPV instances

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 848 +++++++++++++++++++++++++++++-
 1 file changed, 843 insertions(+), 5 deletions(-)

-- 
2.7.4
