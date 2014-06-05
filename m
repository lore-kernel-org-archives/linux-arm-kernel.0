From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 5 Jun 2014 18:19:27 +0800
Subject: [PATCH 0/5] ARM: atmel: switch audio to CCF
Message-ID: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the sama5d3xek and at91sam9n12ek have switch to CCF, in order to
support audio, also switch it to CCF.

This patch series based on next-2014-0604 tag.

Bo Shen (5):
  ASoC: atmel_wm8904: switch to CCF
  ASoC: wm8904: switch to CCF
  dt: wm8904: add device tree binding document
  ARM: atmel: sama5d3xek: switch sound to CCF
  ARM: atmel: at91sam9n12ek: switch sound to CCF

 Documentation/devicetree/bindings/sound/wm8904.txt | 32 ++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts                |  2 +
 arch/arm/boot/dts/sama5d3xmb.dtsi                  |  2 +
 sound/soc/atmel/atmel_wm8904.c                     | 50 ----------------------
 sound/soc/codecs/wm8904.c                          | 13 ++++++
 5 files changed, 49 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt

-- 
1.8.5.2
