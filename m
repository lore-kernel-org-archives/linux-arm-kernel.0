From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 16:52:31 -0800
Subject: [PATCH 0/2] Add pm8994 gpio and mpp support
Message-ID: <1447807953-11924-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the support for pm8994 gpio and mpp modules. Given that there's
nothing besides a compatible string update, I'm going to send a separate
patch to add generic compatible strings for these sorts of things.

Stephen Boyd (2):
  pinctrl: qcom: spmi-gpio: Add pm8994 gpio support
  pinctrl: qcom: spmi-mpp: Add pm8994 mpp support

Cc: <devicetree@vger.kernel.org>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt  | 1 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 1 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                      | 1 +
 4 files changed, 5 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
