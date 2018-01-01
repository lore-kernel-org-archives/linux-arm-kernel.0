From: andy.gross@linaro.org (Andy Gross)
Date: Mon,  1 Jan 2018 00:53:26 -0600
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.16
In-Reply-To: <1514789609-4133-1-git-send-email-andy.gross@linaro.org>
References: <1514789609-4133-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1514789609-4133-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.16

for you to fetch changes up to 342a2922acb0f1be6b5e937427545f04c9d0a7ee:

  arm64: dts: qcom: msm8916-pins: keep cdc_dmic pins in suspend mode (2017-12-31 23:50:14 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.16

* Assorted cleanups for msm8916
* Fix IPC references for smsm

----------------------------------------------------------------
Bjorn Andersson (2):
      arm64: dts: msm8916: Add missing #phy-cells
      arm64: dts: msm8916: Correct ipc references for smsm

Damien Riegel (6):
      arm64: dts: qcom: pm8916: fix wcd_codec indentation
      arm64: dts: qcom: msm8916-pins: remove assignments to bias-disable
      arm64: dts: qcom: msm8916: drop unused board-specific nodes
      arm64: dts: qcom: msm8916: normalize I2C and SPI nodes
      arm64: dts: qcom: msm8916-pins: move sdhc2 cd node with its siblings
      arm64: dts: qcom: msm8916-pins: keep cdc_dmic pins in suspend mode

 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 88 ++++++++----------------------
 arch/arm64/boot/dts/qcom/msm8916.dtsi      | 29 +++++-----
 arch/arm64/boot/dts/qcom/pm8916.dtsi       | 82 ++++++++++++++--------------
 3 files changed, 77 insertions(+), 122 deletions(-)
