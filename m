From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 06:59:02 +0200
Subject: [PATCH v2 0/5] ARM: defconfig: Cleanup from old entries
Message-ID: <1500353947-26122-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes since v1:
1. Rebase on Simon Horman's repo to avoid duplication.
2. Add Liviu Dudau's ack for vexpress.

Best regards,
Krzysztof


Krzysztof Kozlowski (5):
  ARM: multi_v7_defconfig: Cleanup from non-existing options
  ARM: ixp4xx_defconfig: Cleanup from non-existing options
  ARM: vexpress_defconfig: Cleanup from non-existing options
  ARM: ezx_defconfig: Cleanup from non-existing options
  ARM: qcom_defconfig: Cleanup from non-existing options

 arch/arm/configs/ezx_defconfig      | 1 -
 arch/arm/configs/ixp4xx_defconfig   | 4 ----
 arch/arm/configs/multi_v7_defconfig | 7 -------
 arch/arm/configs/qcom_defconfig     | 1 -
 arch/arm/configs/vexpress_defconfig | 1 -
 5 files changed, 14 deletions(-)

-- 
2.7.4
