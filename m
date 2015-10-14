From: agross@codeaurora.org (Andy Gross)
Date: Wed, 14 Oct 2015 15:03:29 -0500
Subject: [GIT PULL] qcom arm64 updates for 4.4
Message-ID: <1444853009-20313-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git at git.codeaurora.org:quic/kernel/agross-msm.git tags/qcom-arm64-for-4.4

for you to fetch changes up to 00a9e053da0b9e150b7f8fefa3c409d7e71ce48f:

  arm64: dts: apq8016-sbc: enable spi buses on LS and HS (2015-10-13 21:53:03 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.4

* Add RNG device tree node
* Add MSM8x16 serial UART1 node
* Enable eMMC on apq8016-sbc board
* Fix I2C pinconf sleep state function
* Add MSM8916 I2C nodes
* Enable I2C busses on LS and HS on APQ8016-sbc
* Enable SPI busses on LS and HS on APQ8016-sbc

----------------------------------------------------------------
Andy Gross (1):
      arm64: dts: qcom: Add 8x16 Serial UART1 node

Georgi Djakov (1):
      arm64: dts: qcom: Enable eMMC on apq8016-sbc board

Srinivas Kandagatla (4):
      arm64: dts: fix i2c pinconf sleep state function
      arm64: dts: qcom: Add msm8916 I2C nodes.
      arm64: dts: apq8016-sbc: enable i2c buses on LS and HS
      arm64: dts: apq8016-sbc: enable spi buses on LS and HS

Stanimir Varbanov (1):
      arm64: dts: qcom: Add RNG device tree node

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  |   30 +++++++++++
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi |   76 +++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi      |   46 +++++++++++++++++
 3 files changed, 150 insertions(+), 2 deletions(-)
