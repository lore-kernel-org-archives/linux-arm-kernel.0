From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Sat, 26 Jul 2014 01:14:21 +0530
Subject: [PATCH 0/3] ARM: dts: Add display DT changes for snow,
 peach_pit and peach_pi
Message-ID: <1406317464-7525-1-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on dt-samsung branch of Kukjin's samsung repository at:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

Add DT changes needed for bridge chips, panels and backlight on snow,
peach_pit and peach_pi.

To test these patches, you need the latest version of bridge chip series:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34667.html

Ajay Kumar (3):
  [PATCH 1/3] ARM: dts: Add DT changes for display on snow
  [PATCH 2/3] ARM: dts: Add DT changes for display on peach_pit
  [PATCH 3/3] ARM: dts: Add DT changes for display on peach_pi

 arch/arm/boot/dts/exynos5250-snow.dts      |   40 +++++++++++++++-------------
 arch/arm/boot/dts/exynos5420-peach-pit.dts |   36 +++++++++++++------------
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |   27 +++++++------------
 3 files changed, 50 insertions(+), 53 deletions(-)

-- 
1.7.9.5
