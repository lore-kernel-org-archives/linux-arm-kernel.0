From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 14 Oct 2013 13:38:28 +0800
Subject: [PATCH 0/5] ARM:at91:enable sound on at91sam9n12ek board
Message-ID: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable sound on at91sam9n12ek board with wm8904 codec


Bo Shen (5):
  ARM: at91: add at91sam9n12 ssc clock in look up table
  ARM: at91: add ssc dma parameter for at91sam9n12
  ARM: at91: enable wm8904 on at91sam9n12ek board
  ARM: at91: enable ssc on at91sam9n12ek board
  ARM: at91: add sound support on at91sam9n12ek board

 arch/arm/boot/dts/at91sam9n12.dtsi  |    3 +++
 arch/arm/boot/dts/at91sam9n12ek.dts |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9n12.c    |    1 +
 3 files changed, 38 insertions(+)

-- 
1.7.9.5
