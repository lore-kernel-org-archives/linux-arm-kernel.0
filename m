From: tony@atomide.com (Tony Lindgren)
Date: Tue,  1 Mar 2016 15:01:20 -0800
Subject: [GIT PULL 3/4] omap defconfig changes for v4.6 merge window
In-Reply-To: <pull-1456872971-400983>
References: <pull-1456872971-400983>
Message-ID: <pull-1456872971-400983-3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/defconfig-signed

for you to fetch changes up to 4e550018df068f6b14d36c72c723a507240f6456:

  ARM: multi_v7_defconfig: Enable LP872x regulator support (2016-02-29 14:58:01 -0800)

----------------------------------------------------------------
Defconfig changes for omap2plus_defconfig and multi_v7_defconfig
for v4.6 merge window:

- Enable IOMMU and omap3isp so we can enable TVP5150/1 video
  decoder

- Enable at24 eeprom for revision detection on beagle-x15

- Enable LP872x regulator for both omap2plus_defconfig and
  multi_v7_defconfig as it's needed at least by LG Optimus
  Black

----------------------------------------------------------------
Javier Martinez Canillas (3):
      ARM: omap2plus_defconfig: Enable OMAP IOMMU support
      ARM: omap2plus_defconfig: Enable ISP support and dependencies
      ARM: omap2plus_defconfig: Enable TI TVP5150 video decoder support

Nishanth Menon (1):
      ARM: omap2plus_defconfig: Enable AT24 eeprom

Paul Kocialkowski (2):
      ARM: omap2plus_defconfig: Enable LP872x regulator support
      ARM: multi_v7_defconfig: Enable LP872x regulator support

 arch/arm/configs/multi_v7_defconfig  |  1 +
 arch/arm/configs/omap2plus_defconfig | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)
