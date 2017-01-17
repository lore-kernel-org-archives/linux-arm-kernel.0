From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 17 Jan 2017 16:02:21 +0530
Subject: [PATCH 0/2] Add USB DRD 3.0 device node for Exynos7
References: <CGME20170117102937epcas5p1f49119a781097709b6bd6d29730c0c0f@epcas5p1.samsung.com>
Message-ID: <1484649143-19423-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds USB 3.0 DRD device node for Exynos7 and 
required Vbus and Vbus-boost support for espresso dev boards.
These patches are part of patch series [1] earlier submitted by Vivek

[1]: https://lkml.org/lkml/2014/11/21/247

While other patches in these series got merged, DTS related change were
left. I have prepared and tested these patches on top of krzk/for-next.


Pankaj Dubey (2):
  arm64: dts: exynos: Add USB 3.0 controller node for Exynos7
  arm64: dts: exynos: Add regulators for Vbus and Vbus-Boost

 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 44 +++++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         | 34 +++++++++++++++++++
 2 files changed, 78 insertions(+)

-- 
2.7.4
