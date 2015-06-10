From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 10 Jun 2015 15:03:57 +0100
Subject: [PATCH 0/9]  Add STiH407 fanmily pinctrl DT for tsin,
 tsout and mtsin channels
Message-ID: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

This set adds in the necessary DT pinctrl configuration for the transport stream
input channels, transport stream output channels and merged transport stream input
channels for STiH407 family silicon.

Some of these channels have alternate pinctrl configurations depending on the board
design. These pinctrl groups will be used by the LinuxDVB c8sectpfe driver which
will be upstreamed in due course, which allows LDVB tuners and demodulators to be
used with an upstream kernel to get transport stream data into the SoC.

regards,

Peter.

Peter Griffin (9):
  ARM: STi: DT: Add STiH407 family tsin0 pinctrl configuration
  ARM: STi: DT: Add STiH407 family tsin1 pinctrl configuration
  ARM: STi: DT: Add STiH407 family tsin2 pinctrl configuration
  ARM: STi: DT: Add STiH407 family tsin3 pinctrl configuration
  ARM: STi: DT: Add STiH407 family tsin4 pinctrl configuration
  ARM: STi: DT: Add STiH407 family tsin5 pinctrl configuration
  ARM: STi: DT: Add STiH407 family tsout0 pinctrl configuration
  ARM: STi: DT: Add STiH407 family tsout1 pinctrl configuration
  ARM: STi: DT: Add STiH407 family mtsin0 pinctrl configuration

 arch/arm/boot/dts/stih407-pinctrl.dtsi | 200 +++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

-- 
1.9.1
