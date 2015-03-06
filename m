From: tyler.baker@linaro.org (tyler.baker at linaro.org)
Date: Fri,  6 Mar 2015 15:35:03 -0800
Subject: [PATCH 0/2] ARM: dts: add dts files for Cubieboard4
Message-ID: <1425684905-23652-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler.baker@linaro.org>

This series adds basic support for the Cubietech Cubieboard4.

The Cubietech Cubieboard4 is a A80 based development board with 2GB DDR3, 8GB
eMMC, Micro SD, HDMI, VGA, 3.5mm audio jack. One USB OTG port and four USB 2.0
ports.

The sun9i-a80-optimus device tree[1] has been used to boot this board for some
time now, as the two platforms are very similar. But there are differences, so 
it deserves it's own device tree. I've tested this series on a 
Cubieboard4[2][3] and can confirm UART, eMMC, and MMC are working properly.

This patch series is based on arm-soc v4.0-rc2.

[1] http://kernelci.org/boot/sun9i-a80-cubieboard4/ 
[2] http://lava.kernelci.org/scheduler/job/47969/log_file#L_13_308
[3] http://lava.kernelci.org/scheduler/job/47969/log_file#L_17_11

Tyler Baker (2):
  ARM: dts: add cubietech cubieboard4
  ARM: dts: add vendor prefix for cubietech

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        | 100 +++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts

-- 
2.1.0
