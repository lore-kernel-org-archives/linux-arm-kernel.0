From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Mar 2013 21:59:32 +0800
Subject: [PATCH 0/2] clk: mxs: mach header cleanup
Message-ID: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series cleans up the mach header inclusion from mxs clk drivers,
which is another step to multiplatform support.

Mike,

The series depends on some mxs platform cleanup patches on my tree.
May I ask you ACK on the patches to have them go arm-soc tree?

Shawn

Shawn Guo (2):
  clk: mxs: get base address from device tree
  clk: mxs: remove the use of mach level IO accessor

 arch/arm/boot/dts/imx23.dtsi |    1 +
 arch/arm/boot/dts/imx28.dtsi |    1 +
 drivers/clk/mxs/clk-imx23.c  |   37 +++++++++++++++++++++++--------------
 drivers/clk/mxs/clk-imx28.c  |   38 +++++++++++++++++++++++---------------
 4 files changed, 48 insertions(+), 29 deletions(-)

-- 
1.7.9.5
