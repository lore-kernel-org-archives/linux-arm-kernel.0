From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 10 Jul 2013 17:51:06 +0800
Subject: [PATCH 0/3] arm: atmel: at91sam9n12: add i2c pinctrl and qt1070
 support
Message-ID: <1373449869-5083-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch is based on linux master branch, implementation as following:
  - add the i2c pinctrl which needed for using at91sam9n12 TWI
  - enable qt1070
  - trivial fix for the gpio-key pin number


Bo Shen (3):
  arm: atmel: at91sam9n12: add pinctrl of TWI
  arm: atmel: at91sam9n12: add qt1070 support
  arm: atmel: at91sam9n12: correct pin number of gpio-key

 arch/arm/boot/dts/at91sam9n12.dtsi  |   20 ++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts |   18 +++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

-- 
1.7.9.5
