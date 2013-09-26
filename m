From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Sep 2013 11:33:29 +0800
Subject: [PATCH 0/3] ARM: imx6q: enable PCIe support
Message-ID: <1380166412-13586-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the arch bits of imx6 pcie patch series [1].  With a proper
separation on the original patches, we can queue the arch bits via
arm-soc tree now.

Shawn

[1] http://thread.gmane.org/gmane.linux.drivers.devicetree/44659

Sean Cross (3):
  ARM: imx: Add LVDS general-purpose clocks to i.MX6Q
  ARM: imx6q: clock and Kconfig update for PCIe support
  ARM: dts: imx6qdl: add pcie device node

 .../devicetree/bindings/clock/imx6q-clock.txt      |    4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi                     |   16 +++++++++++++
 arch/arm/mach-imx/Kconfig                          |    2 ++
 arch/arm/mach-imx/clk-imx6q.c                      |   24 +++++++++++++++++++-
 4 files changed, 45 insertions(+), 1 deletion(-)

-- 
1.7.9.5
