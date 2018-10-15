From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 15 Oct 2018 18:28:31 +0200
Subject: [PATCH 0/2] arm64: dts: meson: reserved memory updates
Message-ID: <20181015162833.7544-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patcheset provide updates regarding reserved memory on
Amlogic platforms.

Jerome Brunet (2):
  arm64: dts: meson: fix reserve memory regions
  arm64: dts: meson-axg: drop FW reserved memory

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 21 +++--------------
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 27 ++++++++--------------
 2 files changed, 12 insertions(+), 36 deletions(-)

-- 
2.17.2
