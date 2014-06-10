From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Jun 2014 13:58:24 -0700
Subject: [PATCH 0/2] Support apq8064 global clock control
Message-ID: <1402433906-19309-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches add full support for apq8064 in the global clock
controller driver. The first patch has already been on the list so
I've picked it up and resent because the second patch depends on it.

Srinivas Kandagatla (1):
  clk: qcom: add clocks necessary for apq8064 sdcc

Stephen Boyd (1):
  clk: qcom: Fully support apq8064 global clock control

 drivers/clk/qcom/gcc-msm8960.c               | 583 ++++++++++++++++++++++++++-
 include/dt-bindings/clock/qcom,gcc-msm8960.h |  11 +
 include/dt-bindings/reset/qcom,gcc-msm8960.h |  16 +
 3 files changed, 607 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
