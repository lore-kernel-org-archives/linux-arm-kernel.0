From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  3 Jan 2018 13:57:20 +0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.16
In-Reply-To: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
References: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1514959040-9992-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.16

for you to fetch changes up to 189114b47b1cfcc5da02db9bcafebd2042aa7ab8:

  ARM: imx_v6_v7_defconfig: enable CONFIG_CPU_FREQ_STAT (2017-12-26 17:04:13 +0800)

----------------------------------------------------------------
i.MX defconfig updates for 4.16:
 - Enable CPU_FREQ_STAT for cpufreq transtion statistics support.
 - Enable SRTC driver RTC_DRV_MXC_V2 for i.MX53.
 - Turn on a few drivers useful for DART-MX6 SoM support, SERDEV
   bluetooth, SERIAL_DEV_BUS, WL18XX, and DEFAULT_ON LED Trigger.

----------------------------------------------------------------
Dong Aisheng (1):
      ARM: imx_v6_v7_defconfig: enable CONFIG_CPU_FREQ_STAT

Neil Armstrong (1):
      ARM: imx_v6_v7_defconfig: Add missing config for DART-MX6 SoM

Patrick Bruenn (1):
      ARM: imx_v6_v7_defconfig: enable RTC_DRV_MXC_V2

 arch/arm/configs/imx_v6_v7_defconfig | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)
