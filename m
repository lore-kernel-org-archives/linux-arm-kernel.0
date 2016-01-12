From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Jan 2016 13:45:58 +0000
Subject: [PATCH 0/5] arm64: dts: apq8016-sbc dt patches.
Message-ID: <1452606358-24569-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

Here are some dt patches which I can go on in next patch cycle.
Most of the patches are to do with adding regulators to apq8016-sbc/db410c.

One patch moves up the sdhci node under soc node and other patch is to add
missing regulators and pinctrl to sdhc_1.

thanks,
srini


Srinivas Kandagatla (5):
  arm64: dts: apq8016-sbc: add regulators support
  arm64: dts: apq8016-sbc: move sdhci node under soc node
  arm64: dts: remove s2 regulator from smd regulators.
  arm64: dts: apq8016-sbc: make 1.8v available on LS expansion
  arm64: dts: apq8016-sbc: Add real regulators and pinctrl for sdhc

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 160 +++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi     |   1 -
 2 files changed, 156 insertions(+), 5 deletions(-)

-- 
1.9.1
