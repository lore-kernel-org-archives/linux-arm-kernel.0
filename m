From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Wed, 10 Sep 2014 22:54:54 +0200
Subject: [PATCH v2 0/2] ASoC/ARM: tegra: apalis/colibri t30: sgtl5000 audio
Message-ID: <cover.1410362950.git.marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds/integrates Freescale SGTL5000 analogue audio codec
support.

Changes in v2:
- Using simple-audio-card as suggested by Fabio.

Marcel Ziswiler (2):
  ARM: tegra: apalis/colibri t30: integrate audio support
  ARM: tegra: enable sgtl5000 audio

 arch/arm/boot/dts/tegra30-apalis.dtsi  | 65 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-colibri.dtsi | 65 ++++++++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig       |  2 ++
 3 files changed, 132 insertions(+)

-- 
1.9.3
