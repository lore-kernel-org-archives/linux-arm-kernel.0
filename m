From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 17 Mar 2014 17:45:33 +0800
Subject: [PATCH 0/8] ARM: at91: sama5d3: enable sound support
Message-ID: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add sound support on sama5d3xek board.

This patch series based on the following patch set:
  clk: at91: better support for the PCKs
  http://comments.gmane.org/gmane.linux.kernel/1664477


Bo Shen (5):
  ARM: at91: sama5d3: add DMA property for SSC devices
  ARM: at91: sama5d3: disable sound by default
  ARM: at91: sama5d3: correct the sound compatible string
  ARM: at91: sama5d3: add the missing property
  ARM: at91: sama5d3: clock for ssc from rk pin

Boris BREZILLON (3):
  ASoC: atmel: support CCF based clks
  ASoC: atmel: document clock properties of the wm8904 driver
  ARM: at91/dt: add clock properties to the wm8904 codec node

 .../devicetree/bindings/sound/atmel-wm8904.txt     |  2 ++
 arch/arm/boot/dts/sama5d3.dtsi                     |  6 ++++++
 arch/arm/boot/dts/sama5d3xmb.dtsi                  | 11 +++++++++-
 sound/soc/atmel/atmel_wm8904.c                     | 25 +++++++++++-----------
 4 files changed, 31 insertions(+), 13 deletions(-)

-- 
1.8.5.2
