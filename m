From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 24 Jan 2016 00:36:38 +0200
Subject: [PATCH 0/2] ARM/sound: fix audio on kirkwood-openrd-client
Message-ID: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Audio playback has been broken some time on OpenRD client. With the
following patches I got the audio file playback working with mplayer.

Aaro Koskinen (2):
  ARM: DTS: kirkwood-openrd-client: fix audio
  ASoC: simple-card: don't fail if sysclk setting is not supported

 arch/arm/boot/dts/kirkwood-openrd-client.dts | 6 +++++-
 arch/arm/boot/dts/kirkwood.dtsi              | 2 +-
 sound/soc/generic/simple-card.c              | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.4.0
