From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:13:57 +0100
Subject: [PATCH 00/16] arm64: dts: msm8996: add more device support
Message-ID: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Here is a patchset for msm8996 which enables more support to serial, i2c, spi,
sd card and pinctrl on msm8996. I was able to test i2c/sdcard with this patchset
on a APQ8096 based board on mainline.

Thanks,
srini

Srinivas Kandagatla (16):
  arm64: dts: msm8996: add msmgpio label
  arm64: dts: msm8996: add blsp2_uart1 pinctrl
  arm64: dts: msm8996: add blsp2_uart2 pinctrl nodes.
  arm64: dts: msm8996: add support blsp2_uart2
  arm64: dts: msm8996: add blsp1_i2c2 pinctrl nodes.
  arm64: dts: msm8996: add support to blsp1_i2c2 device
  arm64: dts: msm8996: add blsp2_i2c1 pinctrl
  arm64: dts: msm8996: add support to blsp2_i2c1
  arm64: dts: msm8996: add support to blsp2_i2c0 pinctrl
  arm64: dts: msm8996: add support to blsp2_i2c0
  arm64: dts: msm8996: add support to blsp1_spi0 pinctrl
  arm64: dts: msm8996: add support to blsp1_spi0
  arm64: dts: msm8996: add support to blsp2_spi5 pinctrl
  arm64: dts: msm8996: add support to blsp2_spi5
  arm64: dts: msm8996: add sdc2 pinctrl
  arm64: dts: msm8996: add sdc2 support

 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 303 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi      | 103 +++++++++-
 2 files changed, 405 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi

-- 
2.7.4
