From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Jan 2017 11:06:21 +0100
Subject: [PATCH 0/2] arm64: dts: r8a779[56]: Enable I2C DVFS DMA
Message-ID: <1485511583-21614-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series enables DMA for I2C DVFS on the r8a7795 and r8a7796 SoCs.
I2C DVFS was recently enabled on the salvator-x board for those SoCs.

Base:
* This series is based on renesas-devel-20170127v2-v4.10-rc5

Dependencies:
* This series has a run-time dependency on
  "[PATCH 0/2] clk: renesas: r8a7795/r8a7796: Add IIC-DVFS clock"

Simon Horman (2):
  arm64: dts: r8a7796: Enable I2C DVFS DMA
  arm64: dts: r8a7795: Enable I2C DVFS DMA

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 3 +++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.7.0.rc3.207.g0ac5344
