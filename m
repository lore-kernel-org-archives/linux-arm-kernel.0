From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 16 Oct 2017 14:31:27 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.15
Message-ID: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.15

for you to fetch changes up to 8cd00d5a43982417d0671f94af933ad3be2f3be9:

  arm64: dts: msm8916: Mark rmtfs node as qcom, rmtfs-mem compatible (2017-10-11 23:57:05 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.15

* Add PCIE support to relevant MSM8996 based boards
* Add RPM clock controller node on MSM8996
* Add dload address on MSM8916 and MSM8996
* Add MBHC button support on APQ8016 SBC
* Add RTMFS specific compatible for rmtfs memory node
* Fixups for MSM8916 GPIO line names and MDP address length

----------------------------------------------------------------
Bjorn Andersson (2):
      arm64: dts: qcom: Specify dload address for msm8916 and msm8996
      arm64: dts: msm8916: Mark rmtfs node as qcom, rmtfs-mem compatible

Craig Tatlor (1):
      arm64: dts: qcom: msm8916: Shrink mdp address length for msm8916

Linus Walleij (1):
      arm64: dts: qcom: sbc: Name GPIO lines

Rajendra Nayak (1):
      arm64: dts: msm8996: Add the rpm clock controller node

Srinivas Kandagatla (4):
      arm64: dts: qcom: msm8996: add support to pcie
      arm64: dts: apq8096-db820c: Enable on board 3 pcie root complex
      arm64: dts: apq8096-db820c: never disable regulator on LS expansion
      arm64: dts: apq8016-sbc: add mbhc buttons support

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi    | 171 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |  22 +++
 arch/arm64/boot/dts/qcom/msm8916.dtsi        |   7 +-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi   | 195 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 179 ++++++++++++++++++++++++
 5 files changed, 573 insertions(+), 1 deletion(-)
