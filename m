From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  8 Oct 2015 12:18:44 +0100
Subject: [PATCH 0/4] arm64: dts: qcom: add support to LS and HS connectors
Message-ID: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

This patchset adds support for i2c and spi on High-Speed and Low speed
connectors on DB410c.
One of the patch fixes the sleep state of existing i2c node.

thanks,
srini


Srinivas Kandagatla (4):
  arm64: dts: fix i2c pinconf sleep state function
  arm64: dts: qcom: Add msm8916 I2C nodes.
  arm64: dts: apq8016-sbc: enable i2c buses on LS and HS
  arm64: dts: apq8016-sbc: enable spi buses on LS and HS

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  | 25 +++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 50 +++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi      | 31 ++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)

-- 
1.9.1
