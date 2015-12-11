From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 Dec 2015 18:11:44 +0000
Subject: [PATCH 0/2] arm64: dts: qcom: few i2c fixes
Message-ID: <1449857504-11365-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

Here are two i2c dt fixes which I have been using for long time on Landing team tree.

Can you please consider fixes for v4.5.

Thanks,
srini

Srinivas Kandagatla (2):
  arm64: dts: fix the i2c aliasing to match to schematics.
  arm64: dts: set the default i2c pin drive strength to 16mA

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  | 3 +++
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.9.1
