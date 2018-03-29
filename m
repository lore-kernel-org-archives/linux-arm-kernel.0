From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 29 Mar 2018 13:38:18 +0530
Subject: [GIT PULL] DaVinci SoC update fixes for v4.17
Message-ID: <7f22cb95-13fa-7158-1cb1-b644e3c4e660@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 96c081735d5197d9d4fa0b6ce84cffa3bb197474:

  ARM: davinci: move davinci_clk_init() to init_time (2018-02-19 16:25:15 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.17/soc-2

for you to fetch changes up to f6adc9fd1ff9bbe766cbb68e84a0d97f54a4f436:

  ARM: davinci: da8xx: simplify CFGCHIP regmap_config (2018-03-29 12:19:12 +0530)

----------------------------------------------------------------
A fix and a clean-up patch for content previously queued for v4.17.

----------------------------------------------------------------
David Lechner (2):
      ARM: davinci: da8xx: fix oops in USB PHY driver due to stack allocated platform_data
      ARM: davinci: da8xx: simplify CFGCHIP regmap_config

 arch/arm/mach-davinci/devices-da8xx.c | 5 +----
 arch/arm/mach-davinci/usb-da8xx.c     | 8 ++++----
 2 files changed, 5 insertions(+), 8 deletions(-)
