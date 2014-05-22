From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Thu, 22 May 2014 19:24:40 +0300
Subject: [PATCH v1 0/5] clk: gcc: Add APQ8084 Global Clock Controller support
Message-ID: <1400775885-10296-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the global clock controller found on the
APQ8084 based platforms.

It applies to the clk-next tree and the following patchset on top of it:
https://lkml.org/lkml/2014/5/16/666

Georgi Djakov (5):
  clk: qcom: Add APQ8084 Global Clock Controller documentation
  clk: qcom: Allow an override function to be passed as data
  clk: gcc: Add APQ8084 Global Clock Controller support
  ARM: dts: qcom: Add APQ8084 Global Clock Controller DT node
  ARM: dts: qcom: Add APQ8084 serial port DT node

 .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   17 ++
 drivers/clk/qcom/Kconfig                           |    4 +-
 drivers/clk/qcom/gcc-msm8974.c                     |  174 ++++++++++++++++++--
 include/dt-bindings/clock/qcom,gcc-msm8974.h       |    4 +
 5 files changed, 185 insertions(+), 15 deletions(-)

-- 
1.7.9.5
