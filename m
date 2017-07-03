From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Mon,  3 Jul 2017 13:04:42 +0530
Subject: [PATCH v2 0/2] IPQ4019 dts fixes
Message-ID: <1499067284-21008-1-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
  * Incorporate Stephen Boyd's comment as a separate patch

v1:
  * Moved the xo and timer nodes to SoC dts file from board dts file.

Varadarajan Narayanan (2):
  dts: ipq4019: Fix pinctrl node name
  Subject: [PATCH] dts: ipq4019: Move xo and timer nodes to SoC dtsi

 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 21 +--------------------
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
