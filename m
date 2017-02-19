From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 19 Feb 2017 23:41:13 +0100
Subject: [PATCH 0/1] meson-gxl: improve support for the P212 board
Message-ID: <20170219224114.17201-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The P212 board is a reference design and re-used by other boards (similar
to the meson-gxbb-p20x.dtsi which is inherited by the Wetek boards).
Until now only very basic functionality was supported, but most of the
interesting things (wifi, SD, eMMC, IR, etc.) are not enabled yet - which
changes with this patch.

I have tested this with a Khadas VIM board (patch for this will follow)
as I don't have a P212 board itself. Thus it would be nice if someone
could test it on an actual P212 board.

Please also specifically review the copyright statements in
meson-gxl-s905x-p212.dtsi - I want to make sure I didn't mess anything
up there.

Martin Blumenstingl (1):
  ARM64: dts: meson-gxl: improve support for the P212 reference design

 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  21 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     | 214 +++++++++++++++++++++
 2 files changed, 226 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi

-- 
2.11.1
