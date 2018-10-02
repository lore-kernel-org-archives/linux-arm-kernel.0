From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  2 Oct 2018 10:43:39 +0200
Subject: [PATCH 0/2] arm64: dts: meson: s400: emmc updates
Message-ID: <20181002084341.5487-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the emmc pwrseq to the emmc node and disable the device
by default, since eMMC is not the default option for this board.

Jerome Brunet (2):
  arm64: dts: meson-axg: s400: add missing emmc pwrseq
  arm64: dts: meson-axg: s400: disable emmc

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1
