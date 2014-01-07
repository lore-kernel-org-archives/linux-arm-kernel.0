From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 07 Jan 2014 09:42:31 +0100
Subject: [GIT PULL FOR v3.14] Renesas pinctrl fixes
Message-ID: <1497178.A4PLILmBU4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 44a45b55a72754e5c9ed047179fb269b530f45fc:

  pinctrl: sh-pfc: ARM: Constify pins and cfg_regs arrays (2013-12-20 12:28:40 
+0100)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git pinmux/next/pfc

for you to fetch changes up to 82b2e0a549800ee35f2af6982205f070367b24e0:

  pinctrl: sh-pfc: r8a7791: Add I2C pins (2014-01-07 09:39:20 +0100)

----------------------------------------------------------------
Valentine Barshak (4):
      pinctrl: sh-pfc: r8a7790: Fix vsync value in the vin3_sync_mux array
      pinctrl: sh-pfc: r8a7791: Group USB PWEN and OVC pins together
      pinctrl: sh-pfc: r8a7791: Add VIN pins
      pinctrl: sh-pfc: r8a7791: Add I2C pins

 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 594 ++++++++++++++++++++++++++++++++--
 2 files changed, 568 insertions(+), 28 deletions(-)

-- 
Regards,

Laurent Pinchart
