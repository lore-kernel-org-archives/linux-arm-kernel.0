From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Jul 2014 15:42:29 -0700
Subject: [PATCH 0/2] qcom clock fixes
Message-ID: <1405464151-16152-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's two small fixes for the qcom clock drivers. Nobody has reported
these as regressions so we can safely wait for 3.17, but I've marked
them with the "Fixes" tag so that stable trees can pick them up as
necessary.

Stephen Boyd (2):
  clk: qcom: Fix PLL rate configurations
  clk: qcom: mdp_lut_clk is a child of mdp_src

 drivers/clk/qcom/common.c       | 39 ++++++++++++++++++++++++++++-----------
 drivers/clk/qcom/common.h       |  6 ++++++
 drivers/clk/qcom/mmcc-msm8960.c |  2 +-
 drivers/clk/qcom/mmcc-msm8974.c | 10 ++++------
 4 files changed, 39 insertions(+), 18 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
