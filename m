From: Guangyu.Chen@freescale.com (Nicolin Chen)
Date: Fri, 13 Dec 2013 23:44:06 +0800
Subject: [PATCH 0/2] Add missing audio-related clocks to imx6 clock tree
Message-ID: <cover.1386949189.git.Guangyu.Chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches appends some essential clocks of audio IP to the
current i.MX6 Series clock trees. 

Nicolin Chen (2):
  ARM: imx6sl: Add missing pll4_audio_div to the clock tree
  ARM: imx6sl: Add missing spba clock to clock tree

 arch/arm/mach-imx/clk-imx6sl.c           | 6 ++++--
 include/dt-bindings/clock/imx6sl-clock.h | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
1.8.4
