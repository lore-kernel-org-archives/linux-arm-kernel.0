From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 16 Oct 2017 14:31:31 -0500
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.15
In-Reply-To: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
References: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1508182291-23352-5-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.15

for you to fetch changes up to e8c4c6eeaacd0fbc18fe8954b262cfd97836a76f:

  ARM: dts: msm8974-FP2: Add USB node (2017-10-11 15:52:49 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.15

* Add Support for MSM8974 based Fairphone 2 phone
* Add support for MSM8974 based Sony Xperia Z2 Tablet
* Add MSM8660 GSBI6/7 nodes
* Disable GSBI6 at APQ8064 platform level
* Fix phy cells on APQ8064

----------------------------------------------------------------
Andy Gross (1):
      ARM: dts: qcom-apq8064: Fix dsi and hdmi phy cells

Bjorn Andersson (1):
      ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet

Linus Walleij (1):
      ARM: dts: qcom: add MSM8660 GSBI6 and GSBI7

Luca Weiss (5):
      ARM: dts: qcom: Add initial DTS file for Fairphone 2 phone
      ARM: dts: msm8974-FP2: Introduce gpio-keys nodes
      ARM: dts: msm8974-FP2: Add regulator nodes for FP2
      ARM: dts: msm8974-FP2: Add sdhci1 node
      ARM: dts: msm8974-FP2: Add USB node

Srinivas Kandagatla (1):
      ARM: dts: qcom-apq8064: disable gsbi6 i2c by default at soc dtsi

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   5 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  67 +++
 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts   | 321 +++++++++++
 .../boot/dts/qcom-msm8974-sony-xperia-castor.dts   | 641 +++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  14 +
 arch/arm/boot/dts/qcom-msm8974pro.dtsi             |  18 +
 8 files changed, 1068 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8974pro.dtsi
