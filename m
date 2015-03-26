From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Mar 2015 11:29:24 -0700
Subject: [PATCHv2 0/2] qcom_rpm: add support for IPQ8064 resources
Message-ID: <1427394566-24327-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of the IPQ RPM support that Josh sent a while back.
I've removed the regulator part because that has been done a different
way now.

Josh Cartwright (2):
  mfd: devicetree: qcom_rpm: document IPQ8064 resources
  mfd: qcom_rpm: add support for IPQ8064

 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  1 +
 drivers/mfd/qcom_rpm.c                             | 41 ++++++++++++++++++++++
 include/dt-bindings/mfd/qcom-rpm.h                 |  6 ++++
 3 files changed, 48 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
