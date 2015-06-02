From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  2 Jun 2015 11:37:46 +0200
Subject: [PATCH v3 0/3] ARM: berlin: BG2Q SPI support
Message-ID: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the SPI nodes for the Berlin BG2Q SoC as well as
comments on the Berlin spi pinctrl functions.

Antoine

Antoine Tenart (3):
  pinctrl: berlin: fix spi1 SS0n function name
  pinctrl: berlin: comment the spi functions
  ARM: berlin: add SPI nodes for BG2Q

 arch/arm/boot/dts/berlin2q.dtsi       | 36 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/berlin/berlin-bg2.c   | 18 +++++++++---------
 drivers/pinctrl/berlin/berlin-bg2cd.c |  8 ++++----
 drivers/pinctrl/berlin/berlin-bg2q.c  | 16 ++++++++--------
 4 files changed, 57 insertions(+), 21 deletions(-)

-- 
2.4.2
