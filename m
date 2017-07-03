From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Mon,  3 Jul 2017 13:17:11 +0530
Subject: [PATCH v3 0/2] IPQ4019 dts fixes
Message-ID: <1499068033-24000-1-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
  * Fix commit subject for
	dts: ipq4019: Move xo and timer nodes to SoC dtsi

v2:
  * Incorporate Stephen Boyd's comment as a separate patch
    (i.e. fix pinctrl node name)

v1:
  * Moved the xo and timer nodes to SoC dts file from board dts file.

Varadarajan Narayanan (2):
  dts: ipq4019: Fix pinctrl node name
  dts: ipq4019: Move xo and timer nodes to SoC dtsi

 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 21 +--------------------
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
