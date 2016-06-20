From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 20 Jun 2016 21:01:39 +0100
Subject: [PATCH 0/8] arm64: dts: db820c: Add basic board support
Message-ID: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

This patchset adds basic board support with uart/i2c/spi/sd card for db820c
board based on apq8096. I have tested this patchset on top of msm8996
patches at [1].
With this patchset am able to boot the board with sdcard and able to
play with i2c devices.

Thanks,
srini
[1] https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1170562.html


Srinivas Kandagatla (8):
  arm64: dts: db820c: add basic board support
  arm64: dts: db820c: add support to LS-UART0
  arm64: dts: db820c: add support to LS-I2C0
  arm64: dts: db820c: add support to LS-I2C1
  arm64: dts: db820c: add support to I2C on HS
  arm64: dts: db820c: add support to LS-SPI0
  arm64: dts: db820c: add support to SPI on HS
  arm64: dts: db820c: add support to external sd card.

 arch/arm64/boot/dts/qcom/Makefile                 |  2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi | 39 ++++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts       | 21 ++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi      | 88 +++++++++++++++++++++++
 4 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi

-- 
2.7.4
