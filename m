From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 13 Jun 2017 15:48:25 -0400
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.13
In-Reply-To: <1497383309-14226-1-git-send-email-andy.gross@linaro.org>
References: <1497383309-14226-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1497383309-14226-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.13

for you to fetch changes up to 20afb8ec093ad71d72656a4714673b1021ea5876:

  arm64: dts: apq8016-sbc: Correct WLAN LED default-trigger (2017-06-05 21:28:59 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.13

* Fix APQ8016 SBC WLAN LED
* Add MSM8996 CPU node
* Add MSM8992 SMEM and fixed regulator
* Fixup MSM8916 USB support

----------------------------------------------------------------
Bjorn Andersson (1):
      arm64: dts: apq8016-sbc: Correct WLAN LED default-trigger

Jeremy McNicoll (2):
      arm64: dts: msm8992 add fixed regulator
      arm64: dts: smem enablement for msm8992

Rajendra Nayak (1):
      arm64: dts: msm8996: Add CPU clock controller node

Stephen Boyd (1):
      arm64: dts: qcom: Collapse usb support into one node

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 36 +++++++++---------
 arch/arm64/boot/dts/qcom/msm8916.dtsi     | 62 +++++++++++++++----------------
 arch/arm64/boot/dts/qcom/msm8992.dtsi     | 53 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi     |  6 +++
 4 files changed, 107 insertions(+), 50 deletions(-)
