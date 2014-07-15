From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Jul 2014 15:59:40 -0700
Subject: [PATCH 0/2] APQ8064 multimedia clock driver
Message-ID: <1405465182-925-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches add support for the APQ8064 multimedia clock
controller. They rely on a couple other patches to this
driver[1][2].

Stephen Boyd (2):
  clk: qcom: pll: Add support for configuring SR PLLs
  clk: qcom: Add support for APQ8064 multimedia clocks

 .../devicetree/bindings/clock/qcom,mmcc.txt        |   1 +
 drivers/clk/qcom/clk-pll.c                         |  15 +-
 drivers/clk/qcom/clk-pll.h                         |   2 +
 drivers/clk/qcom/mmcc-msm8960.c                    | 433 ++++++++++++++++++++-
 include/dt-bindings/clock/qcom,mmcc-msm8960.h      |   8 +
 include/dt-bindings/reset/qcom,mmcc-msm8960.h      |   8 +
 6 files changed, 462 insertions(+), 5 deletions(-)

[1] https://patchwork.kernel.org/patch/4561071/
[2] https://patchwork.kernel.org/patch/4510951/

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
