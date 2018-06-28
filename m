From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 28 Jun 2018 11:50:51 +0200
Subject: [PATCH 0/3] ARM64: dts: meson-axg: first round of daughter card
 updates
Message-ID: <20180628095054.13433-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a speaker amplifier and some leds present on daughter
cards which are connected to the s400 board.

Kevin, please note that the bindings documentation update for the tas5707
has been queued for next in Mark Brown's ASoC tree. Not having it won't
break anything but you may get checkpatch warning.

Jerome Brunet (3):
  ARM64: dts: meson-axg: add s400 microphone card leds
  ARM64: dts: meson-axg: add s400 main 12v supply
  ARM64: dts: meson-axg: add s400 speaker amplifier

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

-- 
2.14.4
