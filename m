From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 5 Jun 2015 15:52:22 -0700
Subject: [PATCH 0/3] Pinctrl support for msm8660
Message-ID: <1433544745-325-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per your request Linus, happy birthday!

Regards,
Bjorn

Bjorn Andersson (3):
  pinctrl: qcom: Add MSM8660 pinctrl definitions
  pinctrl: dt-binding: Add DT binding documentation for MSM8660
  ARM: dts: qcom: Replace gpio node with pinctrl node

 .../bindings/pinctrl/qcom,msm8660-pinctrl.txt      |  90 ++
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  11 +-
 drivers/pinctrl/qcom/Kconfig                       |   8 +
 drivers/pinctrl/qcom/Makefile                      |   1 +
 drivers/pinctrl/qcom/pinctrl-msm8660.c             | 984 +++++++++++++++++++++
 5 files changed, 1089 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
 create mode 100644 drivers/pinctrl/qcom/pinctrl-msm8660.c

-- 
1.8.2.2
