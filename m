From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 2 Feb 2015 14:51:43 +0800
Subject: [PATCH 0/4] ARM: at91: sama5d4ek: enable audio support
Message-ID: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set enable audio support on sama5d4ek.
It depends the patch [1] (ASoC: atmel-pcm-dma: won't check direction
when configure dma)
[1] https://patchwork.kernel.org/patch/5759441/


Bo Shen (4):
  ARM: at91: dt: sama5d4: add ssc nodes
  ARM: at91: dt: sama5d4ek: enable ssc0
  ARM: at91: dt: sama5d4ek: add and enable wm8904
  ARM: at91: dt: sama5d4ek: enable audio

 arch/arm/boot/dts/at91-sama5d4ek.dts | 31 ++++++++++++++++
 arch/arm/boot/dts/sama5d4.dtsi       | 70 ++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

-- 
2.3.0.rc0
