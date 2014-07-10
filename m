From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 10 Jul 2014 09:16:33 +0100
Subject: [PATCH v2 0/2] Support apq8064 global clock control
In-Reply-To: <1402433906-19309-1-git-send-email-sboyd@codeaurora.org>
References: <1402433906-19309-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1404980193-5967-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches add full support for apq8064 in the global clock
controller driver. The first patch has already been on the list so
I've picked it up and resent because the second patch depends on it.

Am resending the series with the fix to my patch.

Changes since v1:
	- fixed comment log spotted by Andreas.
	- added few more sdcc clocks.

Srinivas Kandagatla (1):
  clk: qcom: add clocks necessary for apq8064 sdcc

Stephen Boyd (1):
  clk: qcom: Fully support apq8064 global clock control

 drivers/clk/qcom/gcc-msm8960.c               | 583 ++++++++++++++++++++++++++-
 include/dt-bindings/clock/qcom,gcc-msm8960.h |  11 +
 include/dt-bindings/reset/qcom,gcc-msm8960.h |  16 +
 3 files changed, 607 insertions(+), 3 deletions(-)

-- 
1.9.1
