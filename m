From: s.peter@mpl.ch (Stefan Peter)
Date: Mon, 19 Nov 2012 16:00:01 +0100
Subject: [PATCH 0/1 V2] ARM: kirkwood: Convert the mplcec4 board to pinctrl
Message-ID: <cover.1353336757.git.s.peter@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts the mplcec4 board to using the pinctrl patches.

Changes from V1
* moved sdio pinctrl definitions from mplcec4.dts to kirkwood-6281.dtsi for 
  usage by other boards
* fixed a typo in the sdio pinctrl definitions (/s/mmp13/mpp13/)

Stefan Peter (1):
  Convert mplcec4 board to pinctrl

 arch/arm/boot/dts/kirkwood-6281.dtsi   |    7 +++-
 arch/arm/boot/dts/kirkwood-mplcec4.dts |   59 ++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-mplcec4.c |   35 -------------------
 3 files changed, 65 insertions(+), 36 deletions(-)

-- 
1.7.9.5
