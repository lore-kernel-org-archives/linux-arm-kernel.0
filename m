From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 13 Mar 2017 10:10:49 +0100
Subject: [RESEND PATCH 0/3] ARM64: dts: meson-gx: Cleanup for common nodes
Message-ID: <1489396252-28696-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we know the GXBB and GXL/GXM share more hardware, we can safely move
the remaining peripheral nodes present in the GXBB dtsi to the common GX dtsi.
The following patches are small cleanups and helps to uniform the GX common
dtsi compatible scheme.

Changes since original v1 at [1]:
 - Add back missing changelog on patches 1 and 3

[1] http://lkml.kernel.org/r/1489055948-10656-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (3):
  ARM64: dts: meson-gx: Finally move common nodes to GX dtsi
  ARM64: dts: meson-gx: empty line cleanup
  ARM64: dts: meson-gx: Prepend GX generic compatible like other nodes

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 39 ++++++++++++++++++++------
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 43 ++++++-----------------------
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  8 ++++++
 3 files changed, 47 insertions(+), 43 deletions(-)

-- 
1.9.1
