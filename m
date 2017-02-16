From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 19:21:20 +0100
Subject: [PATCH 0/4] ARM: davinci: vpif capture & display support
Message-ID: <1487269285-6948-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds pdata quirks and other changes required to make vpif
work on the da850-evm board.

Bartosz Golaszewski (2):
  ARM: da850-evm: add a fixed regulator for the UI board IO expander
  ARM: davinci: add pdata-quirks for da850-evm vpif display

Kevin Hilman (2):
  ARM: davinci: board-da850-evm: add I2C ID for VPIF
  ARM: davinci: da8xx: add pdata-quirks for VPIF capture

 arch/arm/mach-davinci/board-da850-evm.c |   4 +
 arch/arm/mach-davinci/da8xx-dt.c        |   1 +
 arch/arm/mach-davinci/pdata-quirks.c    | 178 ++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)

-- 
2.9.3
