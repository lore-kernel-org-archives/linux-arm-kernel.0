From: digetx@gmail.com (Dmitry Osipenko)
Date: Sun, 18 Feb 2018 20:01:44 +0300
Subject: [PATCH v1 0/2] Enable Video Decoder on Tegra30
Message-ID: <cover.1518973069.git.digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VDE on Terga30 is compatible with VDE on Tegra20, hence the 'tegra-vde'
driver works fine on Terga30. Let's add missing DT nodes to expose Video
Decoder Engine on Terga30.

Dmitry Osipenko (2):
  ARM: dts: tegra30: Add IRAM node
  ARM: dts: tegra30: Add video decoder node

 arch/arm/boot/dts/tegra30.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.16.1
